#!/bin/bash

Prefix=$1
StackName="${Prefix}-s3-for-cfn-templates"
Profile="dnpoc"

$(aws cloudformation describe-stacks --stack-name ${StackName} --query 'Stacks[0].Outputs[].[join(``,[`export `,OutputKey,`=`,OutputValue])]' --output text --profile ${Profile})

env | grep Bucket

aws s3 sync --delete ./ s3://${BucketName} --profile ${Profile}

./cicd/create-cicd-base.sh ${Prefix} ${BucketDomain}
