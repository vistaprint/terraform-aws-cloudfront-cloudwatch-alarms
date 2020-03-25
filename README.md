# Terraform AWS Cloudfront Cloudwatch Alarms

This module creates a set of alarms and attaches them to a cloudfront distribution. Alarms for the following metrics are supported:

* `Requests`
* `BytesDownloaded`
* `BytesUploaded`
* `TotalErrorRate`
* `4xxErrorRate`
* `5xxErrorRate`


See [Amazon CloudFront Metrics and Dimensions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cf-metricscollected.html) for more information about these metrics.

See the `variables.tf` file in the module folder for more information on the module parameters.

# Example

```hcl
module "sample_monitors" {
  source     = "vistaprint/cloudfront-cloudwatch-alarms/aws"
  domain   = "www.example.com"
  distribution_id = "${aws_cloudfront_distribution.example_distribution.id}"

  alarms = {
    "4xxErrorRate" = {
      threshold = 5 #(%)
    }
    "5xxErrorRate" = {
      threshold = 1 #(%)
    }
  }
}
``` 

## Notes

The alarms name is prefixed with the domain name and the distributionid. For example, the `4xxError` alarm will be called `example.com-E12312QH8BVRIY-4xxErrorRate`.

Cloudfront distributions are Global but all metrics and alarms must be set in N. Virginia (us-east-1).

# Testing 

This module uses the terraform-module-testing framework. After making some changes run `rake preflight` from the root of the repository to run all tests for the module. This will require:

* A config file in `test\cloudfront-cloudwatch-monitors\config\config-dev.yml`
```yml
terraform-version: 0.12.24
project-name: cloudfront cloudwatch monitors tests
aws:
  profile: <profile>
  region: <region>

```
* A secrets file in `test\cloudfront-cloudwatch-monitors\secrets.yml`:
```yml
region: <region>
aws_access_key_id: <access_key_id>
aws_secret_access_key: <secret_access_key>
```