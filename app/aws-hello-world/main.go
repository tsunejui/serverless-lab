package main

import (
	"fmt"
	"os"

	"github.com/aws/aws-lambda-go/lambda"
)

const envAuthor = "AUTHOR"

func hello() (string, error) {

	author := "λ"
	if os.Getenv(envAuthor) != "" {
		author = os.Getenv(envAuthor)
	}

	return fmt.Sprintf("Hello %s!", author), nil
}

func main() {
	lambda.Start(hello)
}
