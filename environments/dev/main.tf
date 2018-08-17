variable "app-name" {
  type    = "string"
  default = "assessments-api"
}

variable "app-env" {
  type    = "string"
  default = "Dev"
}

locals {
  "tags" = {
    Service     = "assessments-api"
    Environment = "${var.app-env}"
  }
}

resource "aws_elastic_beanstalk_application" "app" {
  name        = "${var.app-name}"
  description = "${var.app-name}"
}

resource "aws_elastic_beanstalk_environment" "app-env" {
  name                = "${aws_elastic_beanstalk_application.app.name}-${lower(var.app-env)}"
  application         = "${aws_elastic_beanstalk_application.app.name}"
  solution_stack_name = "${var.elastic-beanstalk-single-docker}"
  tier                = "WebServer"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application"
    name      = "Application Healthcheck URL"
    value     = "/health"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "aws-elasticbeanstalk-service-role"
  }

  # setting {
  #     namespace = "aws:elb:listener:443"
  #     name = "ListenerProtocol"
  #     value = "HTTPS"
  # }
  # setting {
  #     namespace = "aws:elb:listener:443"
  #     name = "SSLCertificateId"
  #     value = "${data.aws_acm_certificate.cert.arn}"
  # }
  # setting {
  #     namespace = "aws:elb:listener:443"
  #     name = "InstancePort"
  #     value = "80"
  # }
  # setting {
  #     namespace = "aws:elb:listener:443"
  #     name = "ListenerProtocol"
  #     value = "HTTPS"
  # }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "ManagedActionsEnabled"
    value     = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "PreferredStartTime"
    value     = "Fri:10:00"
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    name      = "UpdateLevel"
    value     = "minor"
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    name      = "InstanceRefreshEnabled"
    value     = "true"
  }

  tags = "${local.tags}"
}
