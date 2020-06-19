#!/bin/bash
KEY_FILE="kube.key"
CERT_FILE="kube.crt"
HOST="app3.conectado.local"
CERT_NAME="app3-secret"

echo "Criando certificado auto assinado"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${KEY_FILE} -out ${CERT_FILE} -subj "/CN=${HOST}/O=${HOST}"

echo "Criando secret no kubernetes"
kubectl create secret tls ${CERT_NAME} --key ${KEY_FILE} --cert ${CERT_FILE}

