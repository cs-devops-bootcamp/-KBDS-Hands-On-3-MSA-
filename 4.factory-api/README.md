# FactoryApi

MSA를 학습하기 위한 Project3에 필요한 factory-api 서버이며 외부 sandbox 서버 역할을 한다. 요청을 받으면 일정시간후에 회신합니다.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Rrf.
https://thepugautomatic.com/2020/08/communicating-between-liveviews-on-the-same-page/
https://blog.miguelcoba.com/deploying-a-phoenix-16-app-with-docker-and-elixir-releases


## 사용법

Env : dev
```
mix deps.get
mix phx.server  
```

Env : prod  
```
MIX_ENV=prod mix release
_build/prod/rel/company_api/bin/company_api start
```

Env : prod in Docker
```
docker build --no-cache -t factory .
docker run --env-file ./.docker-prod.env -u root  -p 4000:4000 -it factory
```



## Test
```
curl --location --request POST 'http://localhost:4000/api/manufactures' \
--header 'Content-Type: application/json' \
--data-raw '{
  "MessageGroupId": "stock-arrival-group",
  "MessageAttributeProductId": "CP-502101",
  "MessageAttributeProductCnt": 10,
  "MessageAttributeFactoryId": "FF-500293",
  "MessageAttributeRequester": "홍길동",
  "CallbackUrl": "https://rr298yy7hk.execute-api.ap-northeast-2.amazonaws.com/arrival"
}'
```
