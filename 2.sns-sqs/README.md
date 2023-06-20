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

# 리소스를 구독으로 연결
- 생성된 "kbds-sqs"로 이동합니다.
- 하단의 SNS 구독 파트에서 "Amazon SNS 주제 구독"을 클릭합니다.
- 주제 목록에서 "kbds-sns"의 arn을 확인합니다.
    - 예시 : arn:aws:sns:ap-northeast-2:{YourAccountNumber}:kbds-sns
- "저장" 버튼을 눌러 구독을 연결합니다.


# ARN 확인
- "sales-api-lambda"의 .env에 입력하기 위한 SNS의 ARN을 확인합니다.
- "order-lambda"를 위한 serverless.yml의 `sqs:`에 입력하기 위한 SQS 대기열의 ARN을 확인합니다.