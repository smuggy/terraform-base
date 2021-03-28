resource aws_iam_user_group_membership belongs {
  user   = var.user_name
  groups = var.group_names
}
