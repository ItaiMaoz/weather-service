locals {
  default_environment_variables = {
    NODE_ENV: var.env,
    WEATHER_SRV_URL: "http://api.openweathermap.org/data/2.5/weather",
    QUEUE_URL: aws_sqs_queue.weather_usage_queue.id
    BACKEND_BUCKET: aws_s3_bucket.api_bucket.id
    OPENWEATHERMAP_KEY: aws_secretsmanager_secret.openweathermap.name
  }

  environment_variables = merge(local.default_environment_variables, var.environment_variables)
  resource_name_prefix = "com.benamotz.${var.env}.${var.name}"
  function_name = replace(local.resource_name_prefix, ".", "-")

  sub_domain = var.env == "dev" ? "${var.sub_domain}.${var.env}" : var.sub_domain
  domain_name = "${local.sub_domain}.${var.root_domain_name}"
}
