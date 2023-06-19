const serverless = require("serverless-http");
const express = require("express");
const app = express();
app.use(express.json())

const {
  connectDb,
  queries: { getProduct, increaseStock }
} = require('./database')

app.post("/product/donut", connectDb, async (req, res, next) => {
  const [result] = await req.conn.query(
    getProduct('CP-502101')
  )
  if (result.length > 0) {
    console.log(`공장에서 전달 받은 메시지 : ${JSON.stringify(req.body)}`)
    const product = result[0]
    const incremental = parseInt(req.body.OrderStockCnt) || 10

    await req.conn.query(increaseStock(product.product_id, incremental))
    console.log(`입고 완료! 남은 재고: ${product.stock + incremental}`);
    return res.status(200).json({ message: `입고 완료! 남은 재고: ${product.stock + incremental}` });
  } else {
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
