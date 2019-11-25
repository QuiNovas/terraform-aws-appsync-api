output "arn" {
  description = "The ARN"
  value       = aws_appsync_graphql_api.appsync_api.arn
}

output "id" {
  description = "API ID"
  value       = aws_appsync_graphql_api.appsync_api.id
}

output "uris" {
  description = "Map of URIs associated with the API. e.g. uris['GRAPHQL'] = https://ID.appsync-api.REGION.amazonaws.com/graphql"
  value       = aws_appsync_graphql_api.appsync_api.uris
}
