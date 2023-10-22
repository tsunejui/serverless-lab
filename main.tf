# Specify the provider and access details

provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
}

locals {
  function_name = "aws-hello-world"
  src_path      = "${path.module}/app/${local.function_name}"

  binary_name  = local.function_name
  binary_path  = "${path.module}/bin/${local.binary_name}"
  archive_path = "${path.module}/bin/${local.function_name}.zip"
}


// build the binary for the lambda function in a specified path
resource "null_resource" "function_binary" {
  provisioner "local-exec" {
    command = "GOOS=linux GOARCH=amd64 go build -o ${local.binary_path} ${local.src_path}"
  }
}

// zip the binary, as we can upload only zip files to AWS lambda
data "archive_file" "zip" {
  depends_on = [null_resource.function_binary]

  type        = "zip"
  source_file = local.binary_path
  output_path = local.archive_path
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}

resource "aws_lambda_function" "lambda" {
  function_name = "hello_lambda"

  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256

  role    = aws_iam_role.iam_for_lambda.arn
  handler = "hello_lambda.lambda_handler"
  runtime = "go1.x"

  environment {
    variables = {
      AUTHOR = "Rex"
    }
  }
}
