#!/bin/bash

usage () {
    echo "Usage: init.sh S3_BUCKET S3_REGION S3_STATE_FILE TERRAFORM_MODULE_PATH"
    echo "S3_BUCKET = S3 Bucket to store Terrafrom state file"
    echo "S3_REGION = S3 region where bucket is located"
    echo "S3_STATE_FILE = File to store Terraform state"
    echo "TERRAFORM_MODULE_PATH = Path where Terraform modules will be located"
}

if [ $# -lt 3 ]
then
    usage
    exit 1
fi

S3_BUCKET=$1
S3_REGION=$2
S3_STATE_FILE=$3
TERRAFORM_MODULE_PATH=$4

terraform init \
        -backend=s3 \
        -backend-config="bucket=${S3_BUCKET}" \
        -backend-config="region=${S3_REGION}" \
        -backend-config="key=${S3_STATE_FILE}" \
        "${TERRAFORM_MODULE_PATH}"

