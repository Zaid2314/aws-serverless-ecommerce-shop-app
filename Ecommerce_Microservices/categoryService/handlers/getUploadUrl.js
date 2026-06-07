const { S3Client, PutObjectCommand } = require('@aws-sdk/client-s3');
const { getSignedUrl } = require('@aws-sdk/s3-request-presigner');
const { DynamoDBClient, PutItemCommand } = require("@aws-sdk/client-dynamodb");

const s3Client = new S3Client({ region: "ap-south-1" });
const dynamoDB = new DynamoDBClient({ region: "ap-south-1" });

exports.getUploadUrl = async (event) => {
    try {
        const bucketName = process.env.BUCKET_NAME;
        const { fileName, fileType, categoryName } = JSON.parse(event.body);

        if (!fileName || !fileType || !categoryName?.trim()) {
            return {
                statusCode: 400,
                body: JSON.stringify({ error: "fileName, fileType and categoryName are required" }),
            };
        }

        const command = new PutObjectCommand({
            Bucket: bucketName,
            Key: fileName,
            ContentType: fileType,
        });

        const signedUrl = await getSignedUrl(s3Client, command, { expiresIn: 3600 });

        const putCommand = new PutItemCommand({
            TableName: process.env.DYNAMO_TABLE,
            Item: {
                fileName: { S: fileName },
                categoryName: { S: categoryName },
                createdAt: { S: new Date().toISOString() },
            }
        });

        await dynamoDB.send(putCommand);

        return {
            statusCode: 200,
            body: JSON.stringify({ uploadUrl: signedUrl }),
        };

    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({ error: error.message }),
        };
    }
};