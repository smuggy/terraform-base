resource aws_iam_group_policy_attachment group_policy {
  group      = var.group_name
  policy_arn = var.policy_arn
}
