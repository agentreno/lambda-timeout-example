variable "region" {
    type = "string"
    default = "eu-west-1"
}

provider "aws" {
    region = "${var.region}"
    profile = "staging"
}

# IAM roles and policies
resource "aws_iam_role_policy" "lambda_timeout_example_policy" {
    name = "lambda_timeout_example_policy"
    role = "${aws_iam_role.lambda_timeout_example_role.id}"

    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DeleteNetworkInterface",
                "xray:PutTelemetryRecords",
                "xray:PutTraceSegments"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
}

resource "aws_iam_role" "lambda_timeout_example_role" {
    name = "lambda_timeout_example_role"

    assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
POLICY
}

# Playback Test
resource "aws_lambda_function" "lambda_timeout_example" {
    description = "A lambda function that monitors itself for an impending timeout"
    function_name = "lambda_timeout_example"
    filename = "lambda_timeout_example.zip"
    handler = "index.lambda_handler"
    memory_size = "128"
    role = "${aws_iam_role.lambda_timeout_example_role.arn}"
    runtime = "python3.6"
    timeout = "10"
}
