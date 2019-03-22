resource "aws_iam_policy" "iam_policy" {
  name   = "${var.iam_policy_name}"
  path   = "/"
  policy = "${var.iam_policy_document}"
}

resource "aws_iam_group_policy_attachment" "iam_policy" {
  group      = "${aws_iam_group.iam_user_group.name}"
  policy_arn = "${aws_iam_policy.iam_policy.arn}"
}