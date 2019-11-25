variable "authentication_type" {
  type        = string
  description = "The authentication type. Valid values: API_KEY, AWS_IAM, AMAZON_COGNITO_USER_POOLS, OPENID_CONNECT"
}

variable "field_log_level" {
  type        = string
  description = "Field logging level. Valid values: ALL, ERROR, NONE."
  default     = "ERROR"
}

variable "name" {
  type        = string
  description = "A user-supplied name for the GraphqlApi."
}


variable "openid_connect_config" {
  type = list(object({
    issuer    = string
    auth_ttl  = string
    client_id = string
    iat_ttl   = string
  }))
  description = "Nested argument containing OpenID Connect configuration"
  default     = []
}

variable "user_pool_config" {
  type = list(object({
    app_id_client_regex = string
    aws_region          = string
    default_action      = string
    user_pool_id        = string
  }))
  description = "The Amazon Cognito User Pool configuration"
  default     = []
}