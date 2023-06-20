# .env 구성 예시
```
HOSTNAME=kbds.{YourAccountString}.ap-northeast-2.rds.amazonaws.com
USERNAME=admin
PASSWORD=12345678
DATABASE=kbds
TOPIC_ARN=arn:aws:sns:ap-northeast-2:{YourAccountNumber}:kbds-sns
```

# 테스트

## 조회
터미털에 `
- 요청 예시
    - `curl -X GET https://1u2jeh36y7.execute-api.ap-northeast-2.amazonaws.com/product/donut`
- 응답 예시
    - `{"product_id":1,"sku":"CP-502101","name":"KBDS도넛","price":19900,"stock":12,"factory_id":1,"pending":0}` 

## 구매
터미널에 `curl -X POST YOUR_API_GW_URL/checkout` 입력
- 요청 예시
    -  `curl -X POST https://1u2jeh36y7.execute-api.ap-northeast-2.amazonaws.com/checkout`
- 응답 예시
    - `{"message":"구매 완료! 남은 재고: 10"`

## 재고 10 미만의 경우
- step2 이전
    - `{"message":"Internal Server Error"}`
    - CloudWatch에서 "ERROR	Unhandled Promise Rejection"  확인
- step2 이후
    - 생산 요청의 경우
        - `{"message":"구매 완료! 남은 재고: 9, 생산 요청 진행중"}`
    - 생산 요청 진행 중인 경우
        - `{"message":"생산 진행중입니다. 잠시 후 다시 시도해주세요."}`

## 상품 설정 초기화
- 수량 11, 진행 false
터미널에 `curl -X POST YOUR_API_GW_URL/reset` 입력
