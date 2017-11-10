# lambda-timeout-example

## Description

It may be desirable to handle a Lambda execution timeout before being forced to
stop by AWS. This repo demonstrates this with a thread.join timeout allowing
one second of finishing actions.

## Getting started

`terraform init`, `terraform plan` and `terraform apply` to create
infrastructure. Run `build.sh` and `deploy.sh` to update it subsesquently.
Ensure the AWS staging profile exists. Run the function and it should exit
successfully after 9 seconds instead of timing out after 10.
