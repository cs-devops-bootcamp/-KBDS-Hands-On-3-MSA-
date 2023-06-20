# DB 접속
- 터미널에서 `mysql -h {YOUR_DB_ENDPOINT} -u {YOUR_USER_NAME} -p` 입력
- 비밀번호 입력
- 예시
    - `mysql -h kbds.asd2d72bnc.ap-northeast-2.rds.amazonaws.com -u admin -p`
    - `12345678`

# 데이터베이스 확인
- `show databases;` 입력
- 결과 예시 
    | Database           |
    |--------------------|
    | information_schema |
    | kbds               |
    | mysql              |
    | performance_schema |
    | sys                |

# kbds 데이터베이스에서 테이블 및 value 생성
- `use kbds`
- init.sql 내용 복사 후 붙여넣기
- 데이터 입력확인
    - `SELECT * FROM product;` 입력
- 결과 예시
    
    | product_id | sku       | name| price | stock | factory_id | pending |
    |------------|-----------|------------|-------|-------|------------|---------|
    | 1          | CP-502101 | KBDS도넛 | 19900 | 13    | 1          | 0       |
