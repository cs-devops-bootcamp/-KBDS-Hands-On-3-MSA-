## 도커 설치, 빌드, 실행
- EC2에 ssh 접속 후 
  - `git clone https://github.com/cs-devops-bootcamp/KBDS-Hands-On-3-MSA.git`
- `cd KBDS-Hands-On-3-MSA/4.factory-api` 
- `chmod +x install_docker.sh`
- `./install_docker.sh`

## Test
- 요청 예시
  ```
    curl -X POST 'http://13.124.57.122/api/manufactures' \
    --header 'Content-Type: application/json' \
    --data-raw '{
          "MessageGroupId": "stock-arrival-group",
          "MessageAttributeProductId": "1",
          "MessageAttributeProductCnt": "9",
          "OrderStockCnt": 10,
          "CallbackUrl": "your Stock-Lambda-api_gw URL"
        }'
  ```

- 응답 예시
  ```
    {"data":{"data":{"CallbackUrl":"your Stock-Lambda-api_gw URL","MessageAttributeProductCnt":"9","MessageAttributeProductId":"1","MessageGroupId":"stock-arrival-group","OrderStockCnt":10},"id":"22a0cc0e-0f22-11ee-9253-0242ac110002","reqestor":null}}                           
  ```