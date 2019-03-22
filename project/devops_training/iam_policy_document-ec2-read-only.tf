data "aws_iam_policy_document" "ec2_read_only" {
    statement {
        sid    = "AllowEC2ReadOnly"
        effect = "Allow"

        actions = [
            "ec2:DescribeInstances",
            "ec2:DescribeImages",
            "ec2:DescribeTags",
            "ec2:DescribeSnapshots",
        ]

        resources = [
            # "${module.web.web_ec2_arns}"
            "*"
        ]
    }
}