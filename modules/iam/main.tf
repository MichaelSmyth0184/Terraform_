resource "aws_iam_user" "iam_users" {
  count         = "${length(var.iam_users)}"
  name          = "${element(var.iam_users, count.index)}"
  path          = "/"
  force_destroy = "true"
}

resource "aws_iam_group" "iam_user_group" {
  name = "${var.iam_user_group_name}"
  path = "/"
}

resource "aws_iam_group_membership" "iam_user_group_membership" {
  name  = "${aws_iam_group.iam_user_group.name}"
  group = "${aws_iam_group.iam_user_group.name}"
  users = ["${aws_iam_user.iam_users.*.id}"]
}

