{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "elasticbeanstalk:*"
            ],
            "Effect": "Allow",
            "Resource": [
                "arn:aws:elasticbeanstalk:*::solutionstack/*",
                "arn:aws:elasticbeanstalk:${aws_region}:${aws_account_id}:application/${aws_eb_application}",
                "arn:aws:elasticbeanstalk:${aws_region}:${aws_account_id}:applicationversion/${aws_eb_application}/*",
                "arn:aws:elasticbeanstalk:${aws_region}:${aws_account_id}:environment/${aws_eb_application}/*",
                "arn:aws:elasticbeanstalk:${aws_region}:${aws_account_id}:template/${aws_eb_application}/*"
            ]
        }
    ]
}
