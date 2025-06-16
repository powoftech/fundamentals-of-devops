terraform {
  backend "s3" {
    # TODO: fill in your own bucket name here!
    bucket  = "fundamentals-of-devops-tofu-state-593793056386-us-east-1"
    key     = "ch5/tofu/live/lambda-sample/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    # TODO: fill in your own DynamoDB table name here!
    dynamodb_table = "fundamentals-of-devops-tofu-state-593793056386-us-east-1"
  }
}
