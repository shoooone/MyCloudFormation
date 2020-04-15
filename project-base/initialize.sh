#!/bin/bash

Prefix=${1:-project-base}
StackName="${Prefix}-project"
TemplateBucket="wata-cfn-templates"
TemplateUrl="https://${TemplateBucket}.s3.amazonaws.com/${Prefix}"
Profile=${2:-default}

aws s3 sync --delete ./ s3://${TemplateBucket}/${Prefix} --profile ${Profile}

echo ${TemplateUrl}

aws cloudformation create-stack --stack-name ${StackName} \
  --template-url "${TemplateUrl}/phase1/main.yml" \
  --parameters \
  ParameterKey=ResourcePrefix,ParameterValue=${Prefix} \
  ParameterKey=TemplatePath,ParameterValue="${TemplateUrl}/phase1" \
  --profile ${Profile} \
  --capabilities CAPABILITY_IAM
