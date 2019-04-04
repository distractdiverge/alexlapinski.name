+++
title = "Serverless IAM Policy"
subtitle = "And other issues"

# Add a summary to display on homepage (optional).
summary = "Initial exploration into using serverless, and getting it setup."

date = 2019-04-03T21:34:50-04:00
draft = false

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors = ["Alex Lapinski"]

# Is this a featured post? (true/false)
featured = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.
tags = ["AWS", "NodeJS", "Serverless", "IAM", "CloudFormation", "S3"]
categories = []

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["deep-learning"]` references 
#   `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
# projects = ["internal-project"]

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++



Trying to setup the bare minimum Serverless / NodeJS lambda.

Turns out here is the minimum IAM policy needed for Serverless.


## Minimum IAM Policy
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:AttachInternetGateway",
                "iam:PutRolePolicy",
                "cloudformation:CreateChangeSet",
                "dynamodb:DeleteTable",
                "ec2:DeleteRouteTable",
                "ec2:CreateInternetGateway",
                "cloudformation:UpdateStack",
                "events:RemoveTargets",
                "ec2:DeleteInternetGateway",
                "sns:Subscribe",
                "logs:FilterLogEvents",
                "s3:DeleteObject",
                "iam:GetRole",
                "events:DescribeRule",
                "sns:ListSubscriptionsByTopic",
                "iot:DisableTopicRule",
                "apigateway:*",
                "ec2:CreateTags",
                "sns:CreateTopic",
                "iam:DeleteRole",
                "s3:DeleteBucketPolicy",
                "iot:CreateTopicRule",
                "dynamodb:CreateTable",
                "s3:PutObject",
                "s3:PutBucketNotification",
                "cloudformation:DeleteStack",
                "ec2:CreateSubnet",
                "ec2:DeleteNetworkAclEntry",
                "cloudformation:ValidateTemplate",
                "iot:ReplaceTopicRule",
                "cloudformation:CreateUploadBucket",
                "cloudformation:CancelUpdateStack",
                "events:PutRule",
                "ec2:CreateVpc",
                "sns:ListTopics",
                "cloudformation:UpdateTerminationProtection",
                "s3:ListBucket",
                "cloudformation:EstimateTemplateCost",
                "iam:PassRole",
                "iot:DeleteTopicRule",
                "s3:PutBucketTagging",
                "iam:DeleteRolePolicy",
                "s3:DeleteBucket",
                "ec2:DeleteNetworkAcl",
                "states:CreateStateMachine",
                "sns:GetTopicAttributes",
                "kinesis:DescribeStream",
                "sns:ListSubscriptions",
                "cloudformation:Describe*",
                "events:DeleteRule",
                "ec2:Describe*",
                "s3:ListAllMyBuckets",
                "s3:PutBucketWebsite",
                "s3:GetObjectVersion",
                "cloudformation:Get*",
                "ec2:DeleteSubnet",
                "states:DeleteStateMachine",
                "s3:CreateBucket",
                "iam:CreateRole",
                "sns:Unsubscribe",
                "cloudformation:ContinueUpdateRollback",
                "events:ListRuleNamesByTarget",
                "dynamodb:DescribeTable",
                "logs:GetLogEvents",
                "events:ListRules",
                "cloudformation:List*",
                "events:ListTargetsByRule",
                "cloudformation:ExecuteChangeSet",
                "ec2:CreateRouteTable",
                "kinesis:CreateStream",
                "ec2:DetachInternetGateway",
                "sns:GetSubscriptionAttributes",
                "logs:CreateLogGroup",
                "s3:GetObject",
                "kinesis:DeleteStream",
                "iot:EnableTopicRule",
                "ec2:DeleteVpc",
                "s3:PutAccelerateConfiguration",
                "sns:DeleteTopic",
                "logs:DescribeLogStreams",
                "s3:DeleteObjectVersion",
                "s3:GetAccelerateConfiguration",
                "sns:SetTopicAttributes",
                "s3:PutEncryptionConfiguration",
                "s3:GetEncryptionConfiguration",
                "ec2:CreateSecurityGroup",
                "ec2:CreateNetworkAcl",
                "ec2:ModifyVpcAttribute",
                "logs:DescribeLogGroups",
                "logs:DeleteLogGroup",
                "events:PutTargets",
                "cloudformation:PreviewStackUpdate",
                "sns:SetSubscriptionAttributes",
                "cloudformation:CreateStack",
                "ec2:DeleteSecurityGroup",
                "lambda:*",
                "s3:PutBucketPolicy",
                "ec2:CreateNetworkAclEntry"
            ],
            "Resource": "*"
        }
    ]
}
```

## 'Stuck' Cloudformation
Also, after it failed a few times early on with what Serverless claims as the bare min policy.

the cloud formation stack was in a 'created' state, but when i tried to remove the stack via SLS, I kept getting the error "Bucket Doesn't Exist".

```
gist-tool sls remove --force --aws-profile serverless
Serverless: Getting all objects in S3 bucket...

  Serverless Error ---------------------------------------

  The specified bucket does not exist
```

So I had to go back in to the AWS console and manually delete my CLoudformation Stack, then Re-run the SLS Deployment fresh.

You need to keep in mind (and know somewhat) that serverless + AWS is just a wrapper around cloudformation.

This happens because SLS does remove the S3 bucket, but somehow it doesn't reflect that in the SLS remove tool.