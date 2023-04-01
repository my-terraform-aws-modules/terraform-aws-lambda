resource "aws_iam_role" "iam_for_lambdaa" {
  count = var.create_role ? 1 : 0
  name = "iam_for_lambdaa"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "policy" {
  name = "lambda_policyy"
  role = aws_iam_role.iam_for_lambdaa[0].id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "sqs:*",
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "sns:*",
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "logs:*", 
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "dynamodb:*", 
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })

}


