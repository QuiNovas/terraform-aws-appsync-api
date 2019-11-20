variable "auth_ttl" {
  type        = string
  description = "Number of milliseconds a token is valid after being authenticated."
  default     = ""
}

variable "authentication_type" {
  type        = string
  description = "The authentication type. Valid values: API_KEY, AWS_IAM, AMAZON_COGNITO_USER_POOLS, OPENID_CONNECT"
}

variable "client_id" {
  type        = string
  description = "Client identifier of the Relying party at the OpenID identity provider. This identifier is typically obtained when the Relying party is registered with the OpenID identity provider. You can specify a regular expression so the AWS AppSync can validate against multiple client identifiers at a time"
  default     = ""
}

variable "default_action" {
  type        = string
  description = "The action that you want your GraphQL API to take when a request that uses Amazon Cognito User Pool authentication doesn't match the Amazon Cognito User Pool configuration. Valid: ALLOW and DENY"
  default     = "DENY"
}

variable "field_log_level" {
  type        = string
  description = "Field logging level. Valid values: ALL, ERROR, NONE."
  default     = "ERROR"
}

variable "iat_ttl" {
  type        = string
  description = "Number of milliseconds a token is valid after being issued to a user."
  default     = ""
}

variable "issuer" {
  type        = string
  description = "Issuer for the OpenID Connect configuration. The issuer returned by discovery MUST exactly match the value of iss in the ID Token. Required if auth is OpenID Connect"
  default     = ""
}

variable "name" {
  type        = string
  description = "A user-supplied name for the GraphqlApi."
}

variable "tags" {
  type        = map(string)
  description = "Key-value pair tags to be applied to resource that are launched in the compute environment"
  default     = {}
}

variable "userpool_aws_region" {
  type        = string
  description = "The AWS region in which the user pool was created, required if Cognito is the auth type"
  default     = ""
}

variable "userpool_id" {
  type        = string
  description = "The Cognito user pool ID, required if Cognito is the auth type"
  default     = ""
}