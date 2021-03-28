resource aws_iam_group group {
  name = "${var.name}-${var.label}-group"
  path = "/${var.app}/"
}