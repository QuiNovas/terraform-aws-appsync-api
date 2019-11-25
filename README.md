# terraform-aws-appsync-api
Provides an AppSync GraphQL API with logging enabled

Note: Mulitple Authentication providers is not included in this module

* [Terraform documentation](https://www.terraform.io/docs/providers/aws/r/appsync_graphql_api.html)

## Terraform versions

Terraform 0.12

## Usage

```hcl
module "test" {
  source              = "QuiNovas/appsync-api/aws"
  authentication_type = "OPENID_CONNECT"
  name                = "test"

  openid_connect_config = [{
    issuer    = "https://test.com"
    auth_ttl  = null
    client_id = null
    iat_ttl   = null
  }]
}
```

```hcl
module "test" {
  source              = "QuiNovas/appsync-api/aws"
  authentication_type = "API_KEY"
  name                = "test"
}
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| authentication\_type | The authentication type. Valid values: API\_KEY, AWS\_IAM, AMAZON\_COGNITO\_USER\_POOLS, OPENID\_CONNECTd | string | | yes |
| field\_log\_level | Field logging level. Valid values: ALL, ERROR, NONE. | string | `"ERROR"` | no |
| name | A user-supplied name for the GraphqlApi. | string | | yes |
| openid\_connect\_config | Nested argument containing OpenID Connect configuration | list(object(string)) | `[]`| no |
| user\_pool\_config | The Amazon Cognito User Pool configuration | list(object(string)) | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The arn of the created appsync api |
| id | The API ID |
| uris | Map of URIs associated with the API |

## Authors

Module managed by Quinovas (https://github.com/QuiNovas)

## License

Apache License, Version 2.0, January 2004 (http://www.apache.org/licenses/). See LICENSE for full details.