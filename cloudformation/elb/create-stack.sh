#!/bin/bash

Prefix=$1
StackName="${Prefix}-alb-stack"
Profile="dnpoc"

echo "Create CloudFormation Stack for ALB"

aws cloudformation create-stack --stack-name ${StackName} \
  --template-body file://alb.yml \
  --parameters \
  ParameterKey=ResourcePrefix,ParameterValue=${Prefix} \
  --profile ${Profile}
