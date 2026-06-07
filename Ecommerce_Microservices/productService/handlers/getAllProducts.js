
const {DynamoDBClient, ScanCommand} = require('@aws-sdk/client-dynamodb');

const dynamoDbClient = new DynamoDBClient({region:"ap-south-1"});

exports.getAllProducts = async () =>{
    try {
        const tableName  = process.env.DYNAMO_TABLE;

      const scanCommand =  new ScanCommand({
        TableName: tableName,
      });

   const {Items}  =  await dynamoDbClient.send(scanCommand);
   if(!Items || Items.length ===0){
    return {
        statusCode: 404,
        body: JSON.stringify({msg: "No Products Found"}),
    };
   }

   //Map Dynamodb items to a clean JS Object 
  const products = Items.map(item=>({
   id: item.id.S,
   fileName: item.fileName.S,
   productName: item.productName.S,
   category: item.category.S,
   productPrice: parseFloat(item.productPrice.N),
   imageUrl: item.imageUrl.S,
   description: item.description.S,
   quantity: parseInt(item.quantity.N),
   email : item.email.S,
   isApproved: item.isApproved.BOOL,
   createdAt: item.createdAt.S
   }));

   return {
    statusCode: 200,
    body: JSON.stringify(products),
   };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({error: error.message}),
        };
    }
};