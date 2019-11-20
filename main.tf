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
  role       = "${aws_iam_role.appsync_api.name}"
}

resource "aws_appsync_graphql_api" "appsync_api_key_auth" {
  count               = var.authentication_type == "API_KEY" ? 1 : 0
  authentication_type = "API_KEY"
  name                = var.name

  log_config {
    cloudwatch_logs_role_arn = aws_iam_role.appsync_api.arn
    field_log_level          = var.field_log_level
  }

}

resource "aws_appsync_graphql_api" "appsync_cognito_auth" {
  count               = var.authentication_type == "AMAZON_COGNITO_USER_POOLS" ? 1 : 0
  authentication_type = "AMAZON_COGNITO_USER_POOLS"
  name                = var.name

  user_pool_config {
    aws_region     = var.userpool_aws_region
    default_action = var.default_action
    user_pool_id   = var.userpool_id
  }

  log_config {
    cloudwatch_logs_role_arn = aws_iam_role.appsync_api.arn
    field_log_level          = var.field_log_level
  }
}

resource "aws_appsync_graphql_api" "appsync_iam_auth" {
  count               = var.authentication_type == "AWS_IAM" ? 1 : 0
  authentication_type = "AWS_IAM"
  name                = var.name

  log_config {
    cloudwatch_logs_role_arn = aws_iam_role.appsync_api.arn
    field_log_level          = var.field_log_level
  }
}

resource "aws_appsync_graphql_api" "appsync_openid_connect_auth" {
  count               = var.authentication_type == "OPENID_CONNECT" ? 1 : 0
  authentication_type = "OPENID_CONNECT"
  name                = var.name

  openid_connect_config {
    issuer    = var.issuer
    auth_ttl  = var.auth_ttl == "" ? null : var.auth_ttl
    client_id = var.client_id == "" ? null : var.client_id
    iat_ttl   = var.iat_ttl == "" ? null : var.iat_ttl
  }


  log_config {
    cloudwatch_logs_role_arn = aws_iam_role.appsync_api.arn
    field_log_level          = var.field_log_level
  }
}

resource "aws_appsync_graphql_api" "appsync_mutiple_auth" {
  count               = var.multiple_auth ? 1 : 0
  authentication_type = var.authentication_type
  name                = var.name

  dynamic "additional_authentication_provider" {
    for_each = var.additional_authentication_provider
    content {
      authentication_type = additional_authentication_provider.value.authentication_type

      openid_connect_config {
        issuer    = additional_authentication_provider.value.openid_connect_config.issuer
        auth_ttl  = additional_authentication_provider.value.openid_connect_config.auth_ttl
        client_id = additional_authentication_provider.value.openid_connect_config.client_id
        iat_ttl   = additional_authentication_provider.value.openid_connect_config.iat_ttl
      }

      user_pool_config {
        #default_action      = additional_authentication_provider.value.user_pool_config.default_action
        user_pool_id        = additional_authentication_provider.value.user_pool_config.user_pool_id
        app_id_client_regex = additional_authentication_provider.value.user_pool_config.app_id_client_regex
        aws_region          = additional_authentication_provider.value.user_pool_config.aws_region
      }
    }
  }

  log_config {
    cloudwatch_logs_role_arn = aws_iam_role.appsync_api.arn
    field_log_level          = var.field_log_level
  }
}