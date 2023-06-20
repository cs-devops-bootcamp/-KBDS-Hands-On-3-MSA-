# SNS 주제 만들기
- AWS 관리 콘솔을 엽니다.
- SNS 서비스로 이동합니다.
- "주제 생성"을 클릭합니다.
- 유형에서 표준을 선택합니다.
- 주제에 "kbds-sns" 이름을 입력합니다.
- "주제 생성"을 클릭하면 SNS 주제가 생성됩니다.

# SQS 대기열 생성
- AWS 관리 콘솔을 엽니다.
- SQS 서비스로 이동합니다.
- "대기열 생성"을 클릭합니다.
- 유형에서 표준을 선택합니다.
- 대기열에 "kbds-sqs"라는 이름을 입력합니다.
- "대기열 생성"을 클릭하여 SQS 대기열을 만듭니다.

# 구독으로 연결
- 생성된 "kbds-sqs"로 이동합니다.
- 하단의 SNS 구독 파트에서 "Amazon SNS 주제 구독"을 클릭합니다.
- 주제 목록에서 "kbds-sns"의 arn을 확인합니다.
    - 예시 : arn:aws:sns:ap-northeast-2:{YourAccountNumber}:kbds-sns
- "저장" 버튼을 눌러 구독을 연결합니다.


# ARN 확인
- "sales-api-lambda"의 .env에 입력하기 위한 SNS의 ARN을 확인합니다.
- "order-lambda"를 위한 serverless.yml의 `sqs:`에 입력하기 위한 SQS 대기열의 ARN을 확인합니다.

# 테스트
- 터미널에 `curl -X POST YOUR_API_GW_URL/checkout` 입력
- 콘솔에서 kbds-sqs에 접근 후 우측 상단 "메시지 전송 및 수신" 클릭
- 사용가능한 메시지 확인 후 우측 "메시지 폴링" 클릭
- 하단 메시지 확인
    ```
        {
            "Type" : "Notification",
            "MessageId" : "b9f18937-ae7c-565c-81c3-d43c8e826599",
            "TopicArn" : "arn:aws:sns:ap-northeast-2:807207935784:kbds-sns",
            "Subject" : "도넛 재고 부족",
            "Message" : "도넛 재고가 10 이하입니다. 도넛 생산을 요청합니다. \n메시지 작성 시각: Tue Jun 20 2023 03:36:30 GMT+0000 (Coordinated Universal Time)",
            "Timestamp" : "2023-06-20T03:36:30.278Z",
            "SignatureVersion" : "1",
            "Signature" : "U8IYl7qkpOwdj1KARak8NmsGEVuQ89ylWLQybPpdG10uzM90gqM1UZl0eiA3gZ+csiPNYALHa6IBL6MaYgTmOwX56AUjZdpryA0zD+yzmU/5lJ9hGIgYm18QgNV8QoVi/flAjMAvc6HxtpUBRrouSA+QXvqHoTvXGvE+W3QJknk0lALA6Bs7Mm/BFPDQ+3I7ybu0pCIldBqssUc6qLAl3GXkdqd/UrnwOdnogXg1aeDeVa31ljd3/zkGNPJ1FqTcdvFX8Jd3hkyd0Hwi9XMD74KLZSSOsREBZlUY1v0Mn9GwUdq4/X+dNFEj42OHxiTMYEblv5Snpmn+wC4fCv19mg==",
            "SigningCertURL" : "https://sns.ap-northeast-2.amazonaws.com/SimpleNotificationService-01d088a6f77103d0fe307c0069e40ed6.pem",
            "UnsubscribeURL" : "https://sns.ap-northeast-2.amazonaws.com/?Action=Unsubscribe&SubscriptionArn=arn:aws:sns:ap-northeast-2:807207935784:kbds-sns:5b6c2701-8a1b-42dd-8c8f-e3ba28595b29",
            "MessageAttributes" : {
                "MessageAttributeProductId" : {"Type":"Number","Value":"1"},
                "MessageAttributeProductName" : {"Type":"String","Value":"KBDS도넛"}
            }
        }
    ```