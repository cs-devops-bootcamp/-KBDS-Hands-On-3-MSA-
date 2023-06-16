const serverless = require("serverless-http");
const express = require("express");
require('dotenv').config()
const app = express();
app.use(express.json())

const AWS = require("aws-sdk") // STEP 2
const sns = new AWS.SNS({ region: "ap-northeast-2" }) // STEP 2

const {
  connectDb,
  queries: { getProduct, setStock }
} = require('./database')

app.get("/product/donut", connectDb, async (req, res, next) => {
  const [result] = await req.conn.query(
    getProduct('CP-502101')
  )

  await req.conn.end()
  if (result.length > 0) {
    return res.status(200).json(result[0]);
  } else {
    return res.status(400).json({ message: "상품 없음" });
  }
});

app.post("/checkout", connectDb, async (req, res, next) => {
  const [result] = await req.conn.query(
    getProduct('CP-502101')
  )
  if (result.length > 0) {
    const product = result[0]
    if (product.stock >= 10) {
      await req.conn.query(setStock(product.product_id, product.stock - 1))
      return res.status(200).json({ message: `구매 완료! 남은 재고: ${product.stock - 1}` });
    }
    else {
      await req.conn.end()
      const now = new Date().toString()
      const message = `도너츠 재고가 10 이하입니다. 도넛 생산을 요청합니다. \n메시지 작성 시각: ${now}`
      const params = {
        Message: message,
        Subject: '도너츠 재고 부족',
        MessageAttributes: {
          MessageAttributeProductId: {
            StringValue: product.product_id,
            DataType: "String",
          },
          MessageAttributeProductCnt: {
            StringValue: `10`,
            DataType: "Number",
          },
          MessageAttributeRequester: {
            StringValue: `도넛관리 담당자`,
            DataType: "String",
          }
        },

        TopicArn: process.env.TOPIC_ARN
      }
      console.log("보내는 메시지 결과물  : ", params)
      await sns.publish(params).promise()
      return res.status(200).json({ message: `구매 실패! 남은 재고: ${product.stock}, 생산요청 진행중` });
    }
  } else {
    await req.conn.end()
    return res.status(400).json({ message: "상품 없음" });
  }
});

app.use((req, res, next) => {
  return res.status(404).json({
    error: "Not Found",
  });
});

module.exports.handler = serverless(app);
module.exports.app = app;