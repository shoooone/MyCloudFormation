#!/bin/bash

Prefix=$1
StackName="${Prefix}-cicd-base"
Profile="dnpoc"
TemplateDomain=$2

aws cloudformation create-stack --stack-name ${StackName} \
  --template-url "htts://${TemplateDomain}/cicd/main.yml" \
  --parameters \
  ParameterKey=ResourcePrefix,ParameterValue=${Prefix} \
  ParameterKey=TemplateDomain,ParameterValue=${TemplateDomain} \
  --profile ${Profile}
