resource aws_iam_policy policy {
  name   = "${var.name}-${var.label}-policy"
  path   = "/${var.app}/"
  policy = var.policy_json
}
