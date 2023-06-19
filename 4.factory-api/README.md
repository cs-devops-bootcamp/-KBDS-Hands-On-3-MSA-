## Docker Install & Build & Run
`./install_docker.sh`

## Test
```
curl -X POST 'http://3.34.185.91/api/manufactures' \
--header 'Content-Type: application/json' \
--data-raw '{
      "MessageGroupId": "stock-arrival-group",
      "MessageAttributeProductId": "1",
      "MessageAttributeProductCnt": "9",
      "OrderStockCnt": 10,
      "CallbackUrl": "your Stock-Lambda-api_gw URL"
    }'
```