#!/bin/bash

Prefix=$1
StackName="${Prefix}-vpc-stack"

aws cloudformation create-stack --stack-name ${StackName} \
  --template-body file://multi-az-vpc-pub3.yml \
  --parameters \
  ParameterKey=ResourcePrefix,ParameterValue=${Prefix} \
  --profile dnpoc
