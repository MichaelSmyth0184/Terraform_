package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// An example of how to test the simple Terraform module in examples/terraform-basic-example using Terratest.
func TestTerraformVPC(t *testing.T) {
	t.Parallel()

	expected_vpc_cidr_block := "10.0.0.0/16"
	expected_vpc_tag_project := "TEST"
	expected_vpc_tag_owner := "Michael"
	expected_region := "Belfast"
	expected_vpc_tag_environment := "TEST"
	expected_vpc_tag_name := "TEST-TEST-vpc"
	expected_private_domain_name := "TEST"
	expected_public_subnet_cidr_block := []string{"10.0.0.0/24"}
	expected_aws_region := "eu-west-1"
	expected_public_av_zones := []string{"eu-west-1a"}

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../modules/vpc",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"vpc_cidr_block":         expected_vpc_cidr_block,
			"project":                expected_vpc_tag_project,
			"owner":                  expected_vpc_tag_owner,
			"region":                 expected_region,
			"environment":            expected_vpc_tag_environment,
			"private_domain_name":    expected_private_domain_name,
			"aws_region":             expected_aws_region,
			"public_subnet_cidrs":    expected_public_subnet_cidr_block,
			"public_subnet_av_zones": expected_public_av_zones,
		},

		//              NoColor: true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	actual_vpc_cidr_block := terraform.Output(t, terraformOptions, "vpc_cidr_block")
	actual_vpc_tag_name := terraform.Output(t, terraformOptions, "vpc_tag_name")
	actual_public_subnet_cidr_block := terraform.Output(t, terraformOptions, "public_subnet_cidr_block")

	// Verify we're getting back the variable we expect
	assert.Equal(t, expected_vpc_cidr_block, actual_vpc_cidr_block)
	assert.Equal(t, expected_vpc_tag_name, actual_vpc_tag_name)
	assert.Equal(t, expected_public_subnet_cidr_block, actual_public_subnet_cidr_block)
}
