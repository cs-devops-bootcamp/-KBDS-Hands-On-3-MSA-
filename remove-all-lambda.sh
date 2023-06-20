# `./remove-all-lmabda.sh` 로 실행

cd 1-2.sales-api-lambda && sls remove && cd ..
cd 3.order-lambda && sls remove && cd ..
cd 5.stock-lambda && sls remove && cd ..
echo "Lambda remove complete"
