#!/bin/bash

#################################################
# Author: Tejaswini
# Description: List of AWS resources in configured account
# Prerequisite:
# 	- AWS CLI intalled
# 	- AWS CLI configured
#################################################

echo "=========================================================================="
echo "				AWS RESOURCE TRACKER				"
echo "=========================================================================="

echo
echo "----------Current AWS Region----------"
aws configure get region

echo
echo "--------------------------------------"
echo "		EC2 Instances	            "
echo "--------------------------------------"

aws ec2 describe-instances \
	--query "Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,PublicIpAddress]" \
	--output table

echo
echo "-------------------------------------"
echo "		S3 Buckets		   "
echo "-------------------------------------"

aws s3 ls

echo
echo "-------------------------------------"
echo "		Lambda Functions	   "
echo "-------------------------------------"

aws lambda list-functions \
	--query "Functions[*].[FunctionName]" \
	--output table

echo
echo "------------------------------------"
echo "		RDS Databases		  "
echo "------------------------------------"

aws rds describe-db-instances \
	--query "DBInstances[*].[DBInstanceIdentifier,Engine,DBInstanceStatus]" \
	--output table

echo
echo "-------------------------------------"
echo "		EBS Volumes		   "
echo "-------------------------------------"

aws ec2 describe-volumes \
	--query "Volumes[*].[VolumeId,Size,State]" \
	--output table

echo
echo "------------------------------------"
echo "		  VPCs			  "
echo "------------------------------------"

aws ec2 describe-vpcs \
	--query "Vpcs[*].[VpcId,CidrBlock]" \
	--output table

echo
echo "------------------------------------"
echo "           Subnets		  "
echo "------------------------------------"

aws ec2 describe-subnets \
	--query "Subnets[*].[SubnetId,CidrBlock]" \
	--output table

echo 
echo "------------------------------------"
echo "		Security Groups           "
echo "------------------------------------"

aws ec2 describe-security-groups \
	--query "SecurityGroups[*].[GroupName,GroupId]" \
	--output table

echo
echo "================================================"
echo "  AWS Resource Tracking Completed Successfully  "
echo "================================================"
