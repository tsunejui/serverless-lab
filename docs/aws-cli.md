## AWS CLI

### Configuration and credentials precedence

The credentials and config file are updated when you run the command `aws configure`:

```
aws configure
```

Make use of the authentication on `public.ecr.aws`

```
docker logout public.ecr.aws

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws
```

### Show Lambda functions

```
lambda lambda list-functions
```

### Reference

- https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html