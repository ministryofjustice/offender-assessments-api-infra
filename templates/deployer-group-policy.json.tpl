{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "autoscaling:SuspendProcesses",
                "autoscaling:DescribeScalingActivities",
                "autoscaling:ResumeProcesses",
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:UpdateAutoScalingGroup",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeScheduledActions",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:*",
                "elasticbeanstalk:CreateStorageLocation"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Action": [
                "cloudformation:GetTemplate",
                "cloudformation:DescribeStacks",
                "cloudformation:CreateStack",
                "cloudformation:CancelUpdateStack",
                "cloudformation:ListStackResources",
                "cloudformation:DescribeStackResource",
                "cloudformation:DescribeStackResources",
                "cloudformation:DescribeStackEvents",
                "cloudformation:DeleteStack",
                "cloudformation:UpdateStack"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:cloudformation:${aws_region}:${aws_account_id}:*"
            ]
        },
        {
            "Action": [
                "elasticloadbalancing:DescribeInstanceHealth",
                "elasticloadbalancing:DescribeLoadBalancers",
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                "elasticloadbalancing:DeregisterInstancesWithLoadBalancer"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:elasticloadbalancing:${aws_region}:${aws_account_id}:loadbalancer/awseb-*"
            ]
        },
        {
            "Action": [
                "s3:GetObject"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::elasticbeanstalk-*/*"
            ]
        },
        {
            "Action": [
                "s3:CreateBucket",
                "s3:DeleteObject",
                "s3:GetBucketPolicy",
                "s3:GetObjectAcl",
                "s3:ListBucket",
                "s3:PutBucketPolicy",
                "s3:PutObject",
                "s3:PutObjectAcl"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::elasticbeanstalk-${aws_region}-${aws_account_id}",
                "arn:aws:s3:::elasticbeanstalk-${aws_region}-${aws_account_id}/*"
            ]
        },
        {
            "Action": [
                "iam:PassRole"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:iam::${aws_account_id}:role/aws-elasticbeanstalk-ec2-role"
            ]
        }
    ]
}
