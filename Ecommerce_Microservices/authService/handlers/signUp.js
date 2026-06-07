//Import the required AWS Cognito SDK Classes
//CognitoIdentityProviderClient: Used to communicate with Cognito
//SignUpCommand: used to send sign-up request to Cognito to create a new user
const {CognitoIdentityProviderClient, SignUpCommand} = require('@aws-sdk/client-cognito-identity-provider');
const UserModel = require("../models/userModel");
const client = new CognitoIdentityProviderClient({region:'ap-south-1'});

//Specify the cognito app client id
// the app client id tells cognito which app is making the request

const CLIENT_ID = process.env.CLIENT_ID;

//define a lambda function to send sign-up requests

exports.signUp = async (event) => {
    const {email, fullName, password} = JSON.parse(event.body);

    //prepare parameter required by Cognito's SignupCommand
    const params = {
        ClientId : CLIENT_ID,
        Username: email,
        Password: password,
        UserAttributes:[
            {Name:'email',Value:email},
            {Name:'name', Value:fullName},
        ]
    };
    try {
        //Create the signupCommand object with the prepared parameters
        const command = new SignUpCommand(params);
        await client.send(command);

        const newUser = new UserModel(email, fullName);
        await newUser.save();

        return{
            statusCode:200,
            body: JSON.stringify({msg:'USer Successfully Signed Up!'}),
        };
    } catch (error) {
        return {
            statusCode:500,
            body: JSON.stringify({message:'unexpected error', detail:error.message}),
        }
    }
}