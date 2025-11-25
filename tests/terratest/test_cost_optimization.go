package test

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestCostOptimization(t *testing.T) {
	// Test After State
	terraformOptions := &terraform.Options{
		TerraformDir: "../../terraform/after",
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Validate ASG exists (Rightsizing)
	asgName := terraform.Output(t, terraformOptions, "asg_name")
	assert.NotEmpty(t, asgName)

	// Validate Single NAT Gateway (Network Optimization)
	natCount := terraform.Output(t, terraformOptions, "nat_gateway_count")
	assert.Equal(t, "1", natCount)
}
