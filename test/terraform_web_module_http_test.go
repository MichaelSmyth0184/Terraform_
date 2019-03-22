package test

import (
	"fmt"
	"testing"
	"time"

	//"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

// An example of how to test the Terraform module in examples/terraform-http-example using Terratest.
func TestEc2HttpResponse(t *testing.T) {
	t.Parallel()

	// A unique ID we can use to namespace resources so we don't clash with anything already in the AWS account or
	// tests running in parallel
	uniqueID := random.UniqueId()

	// Give this EC2 Instance and other resources in the Terraform code a name with a unique ID so it doesn't clash
	// with anything else in the AWS account.
	expected_instance_name := fmt.Sprintf("terratest-http-example-%s", uniqueID)

	// Specify the text the EC2 Instance will return when we make HTTP requests to it.
	expected_instance_text := fmt.Sprintf("Hello, %s!", uniqueID)

	expected_ec2_component := "TEST"
	expected_owner := "TEST"
	expected_region := "Belfast"
	expected_instance_type := "t2.micro"
	expected_vpcId := "vpc-73e8cd15"
	expected_project := "TEST"
	expected_amiId := "ami-00035f41c82244dab"
	expected_source_security_group := "sg-0a65a4454bdbe47df"
	expected_role := "test"
	//webSecurityGroup := "sg-03ec7942c79fbabb3"

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../modules/ec2_test/",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"aws_region":               expected_region,
			"instance_name":            expected_instance_name,
			"ec2_component":            expected_ec2_component,
			"owner":                    expected_owner,
			"instance_type":            expected_instance_type,
			"vpc_id":                   expected_vpcId,
			"project":                  expected_project,
			"instance_text":            expected_instance_text,
			"ami_id":                   expected_amiId,
			"source_security_group_id": expected_source_security_group,
			"role":                     expected_role,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	instanceURL := terraform.Output(t, terraformOptions, "instance_url")

	// It can take a minute or so for the Instance to boot up, so retry a few times
	maxRetries := 30
	timeBetweenRetries := 5 * time.Second

	// Verify that we get back a 200 OK with the expected instanceText
	http_helper.HttpGetWithRetry(t, instanceURL, 200, expected_instance_text, maxRetries, timeBetweenRetries)
}
