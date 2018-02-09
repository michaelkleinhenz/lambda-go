package main

import (
	//"os"
	//"fmt"
	//"encoding/json"
	//"io/ioutil"

	"github.com/aws/aws-lambda-go/lambda"
	//"github.com/aws/aws-sdk-go/aws"
	//"github.com/aws/aws-sdk-go/aws/session"
	//"github.com/aws/aws-sdk-go/service/dynamodb"
	//"github.com/aws/aws-sdk-go/service/dynamodb/dynamodbattribute"
)

/*
type ItemInfo struct {
	Plot string`json:"plot"`
	Rating float64`json:"rating"`
}

type Item struct {
	Year int`json:"year"`
	Title string`json:"title"`
	Info ItemInfo`json:"info"`
}

func getItems() []Item {

	if err != nil {
			fmt.Println(err.Error())
			os.Exit(1)
	}

	var items []Item
	json.Unmarshal(raw, &items)
	return items
}
*/

func hello() (string, error) {
	return "Hello ƛ!", nil
}

func main() {
	/*
	sess, err := session.NewSession(&aws.Config{
    Region: aws.String("us-east-1")},
	)
	if err != nil {
    fmt.Println("Error creating session:")
    fmt.Println(err.Error())
    os.Exit(1)
}

	// Create DynamoDB client
svc := dynamodb.New(sess)

items := getItems()

// Add each item to Movies table:
for _, item := range items {
    av, err := dynamodbattribute.MarshalMap(item)

    if err != nil {
        fmt.Println("Got error marshalling map:")
        fmt.Println(err.Error())
        os.Exit(1)
    }

    // Create item in table Movies
    input := &dynamodb.PutItemInput {
        Item: av,
        TableName: aws.String("lambda-dynamodb"),
    }

    _, err = svc.PutItem(input)

    if err != nil {
        fmt.Println("Got error calling PutItem:")
        fmt.Println(err.Error())
        os.Exit(1)
    }

    fmt.Println("Successfully added '",item.Title,"' (",item.Year,") to Movies table")
}
*/
	// Make the handler available for Remote Procedure Call by AWS Lambda
	lambda.Start(hello)
}
