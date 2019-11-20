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
    for_each = var.authentication_type == "OPENID_CONNECT" ? ["1"] : []
    content {
      issuer    = var.issuer
      auth_ttl  = var.auth_ttl == "" ? null : var.auth_ttl
      client_id = var.client_id == "" ? null : var.client_id
      iat_ttl   = var.iat_ttl == "" ? null : var.iat_ttl
    }
  }

  dynamic "user_pool_config" {
    for_each = var.authentication_type == "AMAZON_COGNITO_USER_POOLS" ? ["1"] : []
    content {
      app_id_client_regex = var.app_id_client_regex == "" ? null : var.app_id_client_regex
      aws_region          = var.userpool_aws_region == "" ? null : var.userpool_aws_region
      default_action      = var.default_action
      user_pool_id        = var.userpool_id
    }
  }

  log_config {
    cloudwatch_logs_role_arn = aws_iam_role.appsync_api.arn
    field_log_level          = var.field_log_level
  }
}