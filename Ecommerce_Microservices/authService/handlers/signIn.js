const {CognitoIdentityProviderClient, InitiateAuthCommand} = require('@aws-sdk/client-cognito-identity-provider');

const client = new CognitoIdentityProviderClient({region:'ap-south-1'});

//Specify the Cognito app client id
//the app client id tells cognito which app is making the request

const CLIENT_ID = process.env.CLIENT_ID;

exports.signIn = async (event) => {
    const{email, password} = JSON.parse(event.body);

    const params = {
        ClientId: CLIENT_ID,
        AuthFlow:'USER_PASSWORD_AUTH',
        AuthParameters:{
            USERNAME: email,
            PASSWORD: password,
        },
    };

    try {
        const command = new InitiateAuthCommand(params);
        const response = await client.send(command);

        return{
            statusCode: 200,
            body:JSON.stringify({msg:'User Successfully Signed In!',
                tokens:response.AuthenticationResult,
            }),
        };
    }
    catch (error) {
        return{
            statusCode: 400,
            body:JSON.stringify({error:'Sign-In failed',details:error.message}),
        };
    }
};
