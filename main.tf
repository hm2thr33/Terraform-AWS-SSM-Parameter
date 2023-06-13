terraform {
  backend "s3" {
    bucket         = var.bucket
    key            = var.key
    region         = var.region
    encrypt        = var.encrypt
  }
}

resource "aws_ssm_parameter" "default" {
  for_each = var.parameters

  name        = format("%s/%s/%s", var.prefix, var.name, each.key)
  type        = lookup(each.value, "type", "SecureString")
  value       = lookup(each.value, "value", "fake value")
  description = lookup(each.value, "description", "fake description")
  tags        = merge({ "Name" = var.name }, var.tags)

  lifecycle {
    # Never update the value of an existing SSM parameter.
    # ignore_changes = [value]

    # Protect against destruction of persistent resource.
    # prevent_destroy = true
    prevent_destroy = false
  }
}
