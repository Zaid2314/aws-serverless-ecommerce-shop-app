const{DynamoDBClient, UpdateItemCommand} = require('@aws-sdk/client-dynamodb');

const dynamoDbClient = new DynamoDBClient({region:"ap-south-1"});

exports.updateCategoryImage = async(event)=>{
    try {
        const tableName = process.env.DYNAMO_TABLE;
        const record = event.Records[0];

        //get the s3 bucket name from the event record
        const bucketName = record.s3.bucket.name;
        //extract the file name directly from s3 event record
        const fileName = record.s3.object.key;

        //construct a public url on how the uploaded file will be accessed
        const imageUrl = `https://${bucketName}.s3.amazonaws.com/${fileName}`;

        //prepare the dynamoDb update command 
       const updateItemCommand= new UpdateItemCommand({
            TableName: tableName,
            Key:{fileName: {S: fileName}},
            UpdateExpression: "SET imageUrl = :imageUrl",
            ExpressionAttributeValues:{
                ":imageUrl":{S:imageUrl},
            },
        });
        await dynamoDbClient.send(updateItemCommand);

        return{
            statusCode:200,
            body: JSON.stringify({msg: "image url updated successfully"}),
        };
    } catch (error) {
        return{
            statusCode:500,
            body: JSON.stringify({error:error.message}),
        }
    }
};