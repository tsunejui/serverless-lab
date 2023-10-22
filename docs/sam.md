## SAM CLI

The AWS Serverless Application Model (SAM) is an open-source framework for building serverless applications.

### How to create a lambda app

#### Initialize an AWS SAM application.

```
serverless-lab git:(main) ✗ sam init --name aws-sam-hello-world-app --runtime go1.x --output-dir app

Which template source would you like to use?
        1 - AWS Quick Start Templates
        2 - Custom Template Location
Choice: 1

Choose an AWS Quick Start application template
        1 - Hello World Example
        2 - Infrastructure event management
        3 - Multi-step workflow
Template: 1

Based on your selections, the only Package type available is Zip.
We will proceed to selecting the Package type as Zip.

Based on your selections, the only dependency manager available is mod.
We will proceed copying the template using mod.

Would you like to enable X-Ray tracing on the function(s) in your application?  [y/N]: N

Would you like to enable monitoring using CloudWatch Application Insights?
For more info, please view https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch-application-insights.html [y/N]: N

    -----------------------
    Generating application:
    -----------------------
    Name: aws-sam-hello-world-app
    Runtime: go1.x
    Architectures: x86_64
    Dependency Manager: mod
    Application Template: hello-world
    Output Directory: app
    Configuration file: app/aws-sam-hello-world-app/samconfig.toml
    
    Next steps can be found in the README file at app/aws-sam-hello-world-app/README.md
```

#### Build the application

```
cd app/aws-sam-hello-world-app

make build
```

or

```
sam build -t app/aws-sam-hello-world-app/template.yaml
```

#### Test the application locally

> To use the AWS SAM CLI for local testing, you must have Docker installed and configured.

```
sam local invoke
```

The response of invoking lambda function like below:

```
aws-sam-hello-world-app git:(main) ✗ sam local invoke

Invoking hello-world (go1.x)

Local image was not found.

Removing rapid images for repo public.ecr.aws/sam/emulation-go1.x
Building image.....................................................................................................................................................................................................................................................................................................................................................................
Using local image: public.ecr.aws/lambda/go:1-rapid-x86_64.
                                                                                                                                                                                                                    
Mounting /Users/rex/Git/serverless-lab/app/aws-sam-hello-world-app/.aws-sam/build/HelloWorldFunction as /var/task:ro,delegated, inside runtime container

START RequestId: 78b3f9ff-ff4d-463f-a314-8b14b53944bf Version: $LATEST
END RequestId: 78b3f9ff-ff4d-463f-a314-8b14b53944bf
REPORT RequestId: 78b3f9ff-ff4d-463f-a314-8b14b53944bf  Init Duration: 2.31 ms  Duration: 505.69 ms     Billed Duration: 506 ms Memory Size: 128 MB     Max Memory Used: 128 MB

{"statusCode": 200, "headers": null, "multiValueHeaders": null, "body": "Hello, world!\n"}
```

#### To deploy the application

```
sam deploy --guided
```

#### Run the application

**To get the API endpoint value**

```
sam list endpoints --output json
```

**To invoke your function**

```
curl https://<endpoint>/Prod/hello/
```

### Reference

- https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html
- https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-getting-started-hello-world.html