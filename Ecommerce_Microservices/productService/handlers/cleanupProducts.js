const {DynamoDBClient, ScanCommand, DeleteItemCommand} = require('@aws-sdk/client-dynamodb');
const{SNSClient, PublishCommand} = require('@aws-sdk/client-sns');

const DynamoDbClient = new DynamoDBClient({region:"ap-south-1"});
const snsClient = new SNSClient({region:"ap-south-1"});

//define the cleanup function to remove outdated categories
exports.cleanupProducts = async() =>{
    try {
        //Get the dynamodb table name environment variables
        const tableName = process.env.DYNAMO_TABLE;
        const snsTopicArn = process.env.SNS_TOPIC_ARN;

        // Calculate the timestamp for one hour ago(to filter outdated categories)
        const oneHourAgo = new Date(Date.now() - 60*60*1000).toISOString();

        // Create a scan command to fund categories that are:
        //older than one hour(createdAt < oneHourAgo)
        //do not have an imageUrl field
        const scanCommand = new ScanCommand({
            TableName : tableName,
            FilterExpression:"createdAt < :oneHourAgo AND attribute_not_exists(imageUrl)",
            ExpressionAttributeValues:{
                ":oneHourAgo":{S: oneHourAgo}
            }
        });

        //execute the scan command to retrieve the matching items from the database
        const{Items} = await DynamoDbClient.send(scanCommand);

        //if no items are found, return a success response indicating no cleanup was needed
        if(!Items || Items.length===0){
            return{
                statusCode:200,
                body:JSON.stringify({msg:"No categories found for cleanup"}),
            };
        }
        //initialize a counter to track a number of deleted categories
        let deletedCount = 0;
        //Iterate over each outdated category and delete it from the database
        for(const item of Items){
            //create a delete command using the category's unique identifiers(fileName)
            const deleteItemCommand = new DeleteItemCommand({
                TableName: tableName,
                Key: {id:{S: item.id.S}}
            });

            //execute the delete operation
            await DynamoDbClient.send(deleteItemCommand);
            deletedCount++;//increment the count of deleted items
        }

        //send a SNS notification after deleting categories
        const snsMessage = `Cleanup completed. Deleted ${deletedCount} outdated Products`

        await snsClient.send(new PublishCommand({
            TopicArn : snsTopicArn,
            Message: snsMessage,
            Subject: "Product cleanup Notification",
        }));
        //return a success response with the total number of deleted categories

        return{
            statusCode:200,
            body:JSON.stringify({msg:"cleanup completed", deletedCount}),
        };
    } catch (error) {
        //return error response if something goes wrong
        return{
            statusCode:500,
            body:JSON.stringify({error:error.message}),
        };
    }
};