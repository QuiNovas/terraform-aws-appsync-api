resource "aws_iam_role" "appsync_api" {
  name = var.name

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "appsync.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "appsync_api" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppSyncPushToCloudWatchLogs"
  role       = aws_iam_role.appsync_api.name
}

resource "aws_appsync_graphql_api" "appsync_api" {
  authentication_type = var.authentication_type
  name                = var.name

  dynamic "openid_connect_config" {
    for_each = var.openid_connect_config
    content {
      issuer    = openid_connect_config.value.issuer
      auth_ttl  = openid_connect_config.value.auth_ttl == "" ? null : openid_connect_config.value.auth_ttl
      client_id = openid_connect_config.value.client_id == "" ? null : openid_connect_config.value.client_id
      iat_ttl   = openid_connect_config.value.iat_ttl == "" ? null : openid_connect_config.value.iat_ttl
    }
  }

  dynamic "user_pool_config" {
    for_each = var.user_pool_config
    content {
      app_id_client_regex = user_pool_config.value.app_id_client_regex == "" ? null : user_pool_config.value.app_id_client_regex
      aws_region          = user_pool_config.value.aws_region == "" ? null : user_pool_config.value.aws_region
      default_action      = user_pool_config.value.default_action == "" ? null : user_pool_config.value.default_action
      user_pool_id        = user_pool_config.value.user_pool_id == "" ? null : user_pool_config.value.user_pool_id
    }
  }

  log_config {
    cloudwatch_logs_role_arn = aws_iam_role.appsync_api.arn
    field_log_level          = var.field_log_level
  }
}