package test

import (
	"testing"
	"time"
    "strings"
	"github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

// An example of how to test the Terraform module in examples/terraform-http-example using Terratest.
func TestHttpSonarQubeResponse(t *testing.T) {
	t.Parallel()

	expected_ec2_component := "sonar"
	expected_owner := "expleo-digital labs"
	expected_region := "eu-central-1"
	expected_instance_type := "t2.large"
	expected_vpcId := "vpc-dcb183b7"
	expected_project := "devopsTraining"
	expected_amiId := "ami-04080ec905d224de6"
    expected_web_security_group_ids := []string{"sg-0c45b1814b2f6bd39"}
	expected_web_subnet_ids := []string{"subnet-0f311642"}
    expected_instance_port := 9000
	expected_environment := "test"
	expected_role := "test"

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../modules/ec2/",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"aws_region":               expected_region,
			"ec2_component":            expected_ec2_component,
			"owner":                    expected_owner,
			"instance_type":            expected_instance_type,
			"vpc_id":                   expected_vpcId,
			"project":                  expected_project,
			"ami_id":                   expected_amiId,
			"ec2_security_group_ids":   expected_web_security_group_ids,
			"subnet_ids":               expected_web_subnet_ids,
			"instance_port":            expected_instance_port,
			"environment":              expected_environment,
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
	http_helper.HttpGetWithRetryWithCustomValidation(t, instanceURL, maxRetries, timeBetweenRetries, func(status int, content string) bool {
	   return status == 200 &&
		//strings.Contains(content, "window.serverStatus = 'UP';") &&
		strings.Contains(content, "BATMAN")
	})
	
}
