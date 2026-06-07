const {DynamoDBClient, PutItemCommand} = require('@aws-sdk/client-dynamodb');
const crypto = require('crypto');

const TABLE_NAME = "Users";

const dynamoClient = new DynamoDBClient({region: process.env.AWS_REGION});

//User Model Class to represent a user and handle database operations

class UserModel{
    constructor(email, fullName){
        this.userId = crypto.randomUUID(); // built in generator for unique user id
        this.email = email;
        this.fullName = fullName;
        this.state = ""; //Default empty string for state
        this.city = "";
        this.locality = "";
        this.createdAt = new Date().toISOString();
    }
    //save user data to dynamoDB
    async save(){
        const params={
            TableName : TABLE_NAME,
            Item:{
                userId:{S: this.userId},
                email:{S: this.email},
                fullName:{S: this.fullName},
                state:{S:this.state},
                city:{S:this.city},
                locality:{S:this.locality},
                createdAt:{S: this.createdAt},
            },
        };
        try {
            await dynamoClient.send(new PutItemCommand(params));
        } catch (error) {
            throw error;
        }
    }
}

module.exports = UserModel;