#!/bin/bash


readonly BIN_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )
readonly BASE_DIR=$( dirname $BIN_DIR)

TEMP_KEY="$BIN_DIR/html/_KEY.txt"
TEMP_CSR="$BIN_DIR/html/_CSR.txt"

readonly OUTPUT_H="$BASE_DIR/sketch_WMaster/certificate-generated.h"
OUTPUT_KEY="$BASE_DIR/sketch_WMaster/data/_KEY.txt"
OUTPUT_CSR="$BASE_DIR/sketch_WMaster/data/_CSR.txt"

readonly DEFAULT_DNAME="webrelay"
readonly DEFAULT_AP_IP="192.168.4.1"

INPUT_DNAME="esp8266"
INPUT_KEYSIZE=2048
INPUT_DURATION=$((25*365))
INPUT_EMAIL="root@localhost"

INPUT_COUNTRY="FR"
INPUT_REGION="BZH"
INPUT_CITY="Roscoff"
INPUT_ORGANIZATION="1e1"
INPUT_ORGANIZATION_UNIT="@lan"
INPUT_PASSWORD="🛂: Césame, ouvre-toi! 🔓 Спасибо, Сезам. :🚀"


while getopts d:e:n:p:s: flag
do
    case "${flag}" in
        d) INPUT_DURATION=${OPTARG};;
        e) INPUT_EMAIL=${OPTARG};;
        n) INPUT_DNAME=${OPTARG};;
        p) INPUT_PASSWORD=${OPTARG};;
        s) INPUT_KEYSIZE=${OPTARG};;
    esac
done


echo "generate Key"
#    -aes256 -passout pass:"${INPUT_PASSWORD}" -out ${TEMP_KEY} ${INPUT_KEYSIZE} \
openssl genrsa \
    -out ${TEMP_KEY} ${INPUT_KEYSIZE} \

echo "key file"
ls -l $TEMP_KEY

echo "generate Cert"
#    -new -key ${TEMP_KEY} -passin pass:"${INPUT_PASSWORD}" \
openssl req \
    -new -key ${TEMP_KEY} \
    -out ${TEMP_CSR} \
    -x509 -sha256 \
    -days ${INPUT_DURATION} \
    -subj "/C=${INPUT_COUNTRY}/ST=${INPUT_REGION}/L=${INPUT_CITY}/O=${INPUT_ORGANIZATION}/OU=${INPUT_ORGANIZATION_UNIT}/CN=${INPUT_DNAME}.local/emailAddress=${INPUT_EMAIL}" \
    -addext subjectAltName=DNS:${INPUT_DNAME}.local,DNS:${DEFAULT_DNAME}.local,IP:${DEFAULT_AP_IP} \

echo "cert file"
ls -l $TEMP_CSR

echo "write .h"
echo "" >  $OUTPUT_H
########################################

cat <<EOT >> $OUTPUT_H
#ifndef _certificate_H_
#define _certificate_H_

namespace certificate {
    const char dname[] = "$INPUT_DNAME";

    const char serverKey[] PROGMEM = R"EOT(
$(cat $TEMP_KEY)
)EOT";
    const char serverCert[] PROGMEM = R"EOT(
$(cat $TEMP_CSR)
)EOT";
}

#endif // _certificate_H_
EOT