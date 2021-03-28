resource aws_iam_user user {
  name = "${var.name}-${var.label}-user"
  path = "/${var.app}/"
}