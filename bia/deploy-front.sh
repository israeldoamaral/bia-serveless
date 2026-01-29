#!/bin/bash

API_URL=https://bia-serverless.israeldoamaral.cloud
echo " Iniciando build..."
npm install --loglevel=error
cd client
npm install --legacy-peer-deps --loglevel=error
VITE_API_URL=$API_URL npm run build --force
echo " Build finalizado"
cd ..
echo " Fazendo upload dos assets para o S3..."
aws s3 sync client/build/ s3://bia-serverless-front.israeldoamaral.cloud --exclude "index.html"

echo " Fazendo upload do index.html para o S3..."
aws s3 sync client/build/ s3://bia-serverless-front.israeldoamaral.cloud --exclude "*" --include "index.html"
echo " Envio Finalizado"
    

echo "Deploy finalizado com sucesso!!"