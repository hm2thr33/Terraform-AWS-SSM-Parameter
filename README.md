# AWS Systems Manager Parameter Store

[Partial Configuration](https://developer.hashicorp.com/terraform/language/settings/backends/configuration)
-----------------
With a partial configuration, the remaining configuration arguments must be provided as part of the initialization process.

1. Create file with name `s3backend.tfvars`.

A backend configuration file has the contents of the backend block as top-level attributes, without the need to wrap it in another terraform or backend block:

```hcl
bucket          = "backet-name"
key             = "file-name"
region          = "eu-central-1"
encrypt         = "true"
```

2. Then apply configuration:

```console
$ terraform init -backend-config=s3backend.tfvars
```

Example Usage
-----------------

```hcl
module "aws-ssm-parameter" {
  source = "path-to-module"

  name       = "example"
  prefix     = "/dev"
  bucket     = "backet-name"
  key        = "file-name"
  region     = "eu-central-1"
  encrypt    = "true"

  tags = {
    ManagedBy = "Terraform"
    Team      = "DevOps"
  }

  parameters = {
    "foo_os_endpoint" = {
      description = "Endpoint URL for foo opensearch"
      type        = "SecureString"
      value       = "https://localhost:9200"
    },

    "foo_os_user" = {
      description = "Engine for foo opensearch"
      type        = "SecureString"
    },

    "foo_os_password" = {
      description = "Password for foo opensearch"
      type        = "SecureString"
    },
  }
}

terraform {
  backend "s3" {}
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

Argument Reference
-----------------

The following arguments are supported:

* `name` - (Required) The name of the service to which this parameter list belongs, e.g., `example`. The value is appended to the `prefix`.

* `parameter` - (Required) A [parameter](#parameter) block. Parameter blocks are documented below.

* `prefix` - (Optional) Prefix prepended to parameter name, and used to produce a hierarchical layout of parameters. Default: `/service`.

* `tags` - (Optional) A map of tags to be applied to resources where supported.

parameter
---------

A parameter block consists of a map of maps. Each map's key represents
a parameter name. The value stored under this key consists of another
map that may contain the following keys:

* `description` – (Optional) A description of the parameter. If not specified, a default value is assigned that draws attention to the need to provide a meaningful description.

* `type` – (Optional) The parameter's type. The values `String` and
`SecureString` are permissible, with `SecureString` being the default.

* `prefix` – (Optional) A string prepended to the parameter name to allow hierarchical organization of SSM parameters. The default prefix is `/service`, which is sufficient for most use.

* `value` – (Optional) The initial value for the parameter. **Note that
the value is used only on creation of the parameter. The parameter value is never overwritten by Terraform.**

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_parameters"></a> [parameters](#output\_parameters) | The list of parameters created by the module |
