const axios = require('axios').default
const consumer = async (event) => {
  for (const record of event.Records) {
    const json = JSON.parse(record.body).MessageAttributes
    const payload = {
      "MessageGroupId": "stock-arrival-group",
      "MessageAttributeProductId": json.MessageAttributeProductId.Value,
      "MessageAttributeProductName": json.MessageAttributeProductName.Value,
      "OrderStockCnt": 10,
      "CallbackUrl": "5.stock-lmabda-URL"
    }
    console.log(`공장으로 보내는 메시지 페이로드 : ${JSON.stringify(payload)}`)
    try {
      const response = await axios.post(
        `http://13.124.57.122/api/manufactures`,
        payload
      );
      console.log(`응답 정보 : ${response.data}`);
    } catch (error) {
      console.log(`공장으로 메시지 전달 실패`)
      console.error(error);
    }
  }
};

module.exports = {
  consumer,
};
