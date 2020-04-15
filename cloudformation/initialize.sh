#!/bin/bash

Prefix=$1
StackName="${Prefix}-s3-for-cfn-templates"
Profile="dnpoc"

aws cloudformation create-stack --stack-name ${StackName} \
  --template-body file://s3-for-cfn-templates.yml \
  --parameters \
  ParameterKey=ResourcePrefix,ParameterValue=${Prefix} \
  --profile ${Profile}

aws cloudformation wait stack-create-complete --stack-name ${StackName}

$(aws cloudformation describe-stacks --stack-name ${StackName} --query 'Stacks[0].Outputs[].[join(``,[`export `,OutputKey,`=`,OutputValue])]' --output text --profile ${Profile})

env

aws s3 sync --delete ./ s3://${BucketName} --profile ${Profile}

./cicd/create-cicd-base.sh ${Prefix} ${BucketDomain}
