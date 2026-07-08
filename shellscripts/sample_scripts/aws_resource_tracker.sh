#!/bin/bash

#################################################
# Author: Tejaswini
# Date: July 3rd
#
# Version: v1
# 
# This Script will report the AWS resource usage
#################################################

set -x

# AWS S3
echo 'List of S3 Buckets'
aws s3 ls  

# AWS EC2
echo 'List of EC2 instances'
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId' 

# AWS Lambda
echo 'List of Lambda Functions'
aws lambda list-functions

# AWS IAM users
echo 'List of IAM Users'
aws iam list-users 
