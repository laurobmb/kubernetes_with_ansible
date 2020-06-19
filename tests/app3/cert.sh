#!/bin/bash
HOST="app3.conectado.local"
CERT_NAME="app3-secret"

echo " >>>>>>>>>>>>>>>>>>>>>> Gerando chave privada da CA"
openssl genrsa -out rootCA.key 2048
sleep 1

echo " >>>>>>>>>>>>>>>>>>>>>> Gerando certificado autoassinado da CA"
openssl req -out rootCA.pem -key rootCA.key -new -x509 -days 3650 -subj "/C=BR/ST=Pernambuco/L=Recife/O=Suporte Avancado/O=Security/CN=root.$1"
sleep 1

echo " >>>>>>>>>>>>>>>>>>>>>> Gerando chave privada do servidor"
openssl genrsa -out $1.key 2048
sleep 1

echo " >>>>>>>>>>>>>>>>>>>>>> Gerando certificado do servidor"
openssl req -out $1.req -key $1.key -new -subj "/C=BR/ST=Pernambuco/L=Recife/O=Suporte Avancado/O=Security/CN=$1"
sleep 1

echo " >>>>>>>>>>>>>>>>>>>>>> Assinando o certificado do servidor com a CA"
openssl x509 -in $1.req -out $1.pem -days 365 -req -CA rootCA.pem -CAkey rootCA.key -CAcreateserial
sleep 1

echo " >>>>>>>>>>>>>>>>>>>>>> Verificando assinatura digital do certificado"
openssl verify -CAfile rootCA.pem -purpose sslserver $1.pem
sleep 1

echo " >>>>>>>>>>>>>>>>>>>>>> Criando secret no kubernetes"
kubectl create secret tls ${CERT_NAME} --key $1.key --cert $1.pem
