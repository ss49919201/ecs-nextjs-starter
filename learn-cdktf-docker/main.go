package main

import (
	"github.com/aws/constructs-go/constructs/v10"
	"github.com/aws/jsii-runtime-go"
	"github.com/cdktf/cdktf-provider-aws-go/aws/v10/ecrrepository"
	awsprovider "github.com/cdktf/cdktf-provider-aws-go/aws/v10/provider"
	"github.com/hashicorp/terraform-cdk-go/cdktf"
)

func NewMyStack(scope constructs.Construct, id string) cdktf.TerraformStack {
	stack := cdktf.NewTerraformStack(scope, &id)

	// プロバイダのリージョン
	awsprovider.NewAwsProvider(stack, jsii.String("AWS"), &awsprovider.AwsProviderConfig{
		Region: jsii.String("ap-northeast-1"),
	})

	// ECR作成
	_ = ecrrepository.NewEcrRepository(
		scope,
		jsii.String("ECRRepository"),
		&ecrrepository.EcrRepositoryConfig{
			Name: jsii.String("winter-camp"),
		},
	)

	return stack
}

func main() {
	app := cdktf.NewApp(nil)

	NewMyStack(app, "winter-camp")

	app.Synth()
}
