+++
title = "IAM Configuration for Pulumi Service User"

summary = "Basic IAM Policies for use with the Pulumi DevOps tool"
date = 2019-10-25T22:53:35-04:00
draft = false

authors = ["alexlapinski"]

tags = ['AWS', 'IAM', 'IaC', 'Pulumi', 'Security']
categories = ['AWS', 'DevOps']
+++

## Overview
I'm starting to make use of Pulumi for my own personal infrastructure of my hobby projects.

Part of this means that I need to put together a proper IAM permission scheme for the service user, as well as create the service user and group.

## User
The first thing I did was to create two things.
1. A service user, which can only use the AWS API (```pulumi.service```)
2. A group for this user to belong to (```devops```)

Since I tend to play around with various different frameworks, for really, pretty much everything, I decided to make an entire ```DevOps``` group. This way, I attach the permissions to this group, and can reuse it for other service users.

## Permissions
I like to take the approach of only adding in the bare minimum of required permissions. So I start with a blank policy.

### S3 Resources
The first resource I am using is S3, this was pretty easy, I just made use of the existing Policies that AWS has for creating S3 resources.

I attached the policy named ```AmazonS3FullAccess```. This lets me create, update and delete S3 resources.

The full policy is below:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
```

As I learn more, I will probably create my own policy that is even more restrictive than this.

### RDS Resources
The next thing I added to my project was an RDS database, so again, I attached the built-in policy named ```AmazonRDSFullAccess```.

The full policy is below:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "rds:*",
        "application-autoscaling:DeleteScalingPolicy",
        "application-autoscaling:DeregisterScalableTarget",
        "application-autoscaling:DescribeScalableTargets",
        "application-autoscaling:DescribeScalingActivities",
        "application-autoscaling:DescribeScalingPolicies",
        "application-autoscaling:PutScalingPolicy",
        "application-autoscaling:RegisterScalableTarget",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:GetMetricStatistics",
        "cloudwatch:PutMetricAlarm",
        "cloudwatch:DeleteAlarms",
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeInternetGateways",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcAttribute",
        "ec2:DescribeVpcs",
        "sns:ListSubscriptions",
        "sns:ListTopics",
        "sns:Publish",
        "logs:DescribeLogStreams",
        "logs:GetLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": "pi:*",
      "Effect": "Allow",
      "Resource": "arn:aws:pi:*:*:metrics/rds/*"
    },
    {
      "Action": "iam:CreateServiceLinkedRole",
      "Effect": "Allow",
      "Resource": "*",
      "Condition": {
        "StringLike": {
          "iam:AWSServiceName": [
            "rds.amazonaws.com",
            "rds.application-autoscaling.amazonaws.com"
          ]
        }
      }
    }
  ]
}
```

### KMS / Encryption
Now that I have both an S3 resource and an RDS instance, I want to update them both to make use of the KMS encryption that AWS has. For this, I had to create my own policy, since I could not find one that would let me create my own key.

New Policy Name ```KMS.CreateKey```. Now, keep in mind this is not the same as a 'Key Policy'.

The full policy is below:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "kms:CreateKey",
                "kms:DescribeKey",
                "kms:ListResourceTags",
                "kms:GetKeyPolicy",
                "kms:GetKeyRotationStatus",
                "kms:ScheduleKeyDeletion"
            ],
            "Resource": "*"
        }
    ]
}
```

Security Groups (to allow access to the Instance)
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:RevokeSecurityGroupIngress",
                "ec2:AuthorizeSecurityGroupEgress",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
                "ec2:DescribeSecurityGroupReferences",
                "ec2:CreateSecurityGroup",
                "ec2:RevokeSecurityGroupEgress",
                "ec2:DeleteSecurityGroup",
                "ec2:DescribeSecurityGroups",
                "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
                "ec2:DescribeStaleSecurityGroups"
            ],
            "Resource": "*"
        }
    ]
}
```

That's it, these are the 3 IAM Policies that I currently have attached to my group ```devops```. As I learn more, I'll keep this page updated with the minimal policy required by ```Pulumi``` to create the resources I require.

I like to keep the policies separate, and well documented as it will help to ensure they can be reused by various different IaC tools, or frameworks.

Eventually, I'll combine this all together into it's own little Pulumi stack that I can use to bootstrap a Service User with the correct permissions.