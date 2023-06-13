output "parameters" {
  description = "The list of parameters created by the module"
  value = { for parameters in keys(var.parameters) :
    parameters => {
      "type"        = aws_ssm_parameter.default[parameters].type
      "name"        = aws_ssm_parameter.default[parameters].name
      "arn"         = aws_ssm_parameter.default[parameters].arn
      "description" = aws_ssm_parameter.default[parameters].description
    }
  }
}
