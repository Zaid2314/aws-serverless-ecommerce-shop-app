const {DynamoDBClient, ScanCommand} = require('@aws-sdk/client-dynamodb');

const dynamoDbClient = new DynamoDBClient({region:"ap-south-1"});

exports.getAllBanners = async ()=>{
    try {
       const tableName  = process.env.DYNAMODB_TABLE;
       
     const scanCommand =  new ScanCommand({
        TableName: tableName,
       });
    const {Items}  =   await dynamoDbClient.send(scanCommand);
    if(!Items || Items.length==0){
        return {
            statusCode: 404,
            body: JSON.stringify({msg:"No Banners found"}),
        };
    }
    const banners = Items.map(item =>({
    imageUrl: item.imageUrl.S
    }));
    return {
        statusCode: 200,
        body: JSON.stringify(banners),
    };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({error:error.message}),
        };
    }
};




