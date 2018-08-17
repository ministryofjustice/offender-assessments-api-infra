data "template_file" "deployer_policy" {
  template = "${file("../../templates/deployer-policy.json.tpl")}"

  vars {
    aws_region         = "${var.aws_region}"
    aws_account_id     = "${var.aws_account_id}"
    aws_eb_application = "${aws_elastic_beanstalk_application.app.name}"
  }
}

data "template_file" "deployer_group_policy" {
  template = "${file("../../templates/deployer-group-policy.json.tpl")}"

  vars {
    aws_region         = "${var.aws_region}"
    aws_account_id     = "${var.aws_account_id}"
    aws_eb_application = "${aws_elastic_beanstalk_application.app.name}"
  }
}

resource "aws_iam_user" "deployer" {
  name = "${var.app-name}-deployer"
}

resource "aws_iam_group_membership" "ci" {
  name  = "${aws_iam_user.deployer.name}"
  users = ["${aws_iam_user.deployer.name}"]
  group = "${aws_elastic_beanstalk_application.app.name}-ElasticbeanstalkDeployers"
}

resource "aws_iam_user_policy" "deployer" {
  name = "${aws_iam_user.deployer.name}"
  user = ["${aws_iam_user.deployer.name}"]

  # Based on https://gist.github.com/magnetikonline/5034bdbb049181a96ac9
  # and https://gist.github.com/jakubholynet/0055cf69b5b2a9554af67a11828209a5
  policy = "${data.template_file.deployer_policy.rendered}"
}

resource "aws_iam_group" "deployers" {
  name = "${var.app-name}-ElasticbeanstalkDeployers"
}

resource "aws_iam_group_policy" "deployers" {
  name  = "elasticbeanstalk-deployment"
  group = "${aws_iam_group.deployers.name}"

  # Based on https://gist.github.com/magnetikonline/5034bdbb049181a96ac9
  # and https://gist.github.com/jakubholynet/0055cf69b5b2a9554af67a11828209a5
  #
  # all the bits non-specific to this app bits go in
  policy = "${data.template_file.deployer_group_policy.rendered}"
}

resource "aws_iam_access_key" "deployer" {
  user = "${aws_iam_user.deployer.name}"
}
