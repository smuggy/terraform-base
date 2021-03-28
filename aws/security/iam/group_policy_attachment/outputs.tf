output group_name {
  value = aws_iam_group_policy_attachment.group_policy.group
}

output policy_arn {
  value = aws_iam_group_policy_attachment.group_policy.policy_arn
}