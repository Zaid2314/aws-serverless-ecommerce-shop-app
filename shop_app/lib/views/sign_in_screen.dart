import 'package:flutter/material.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/views/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  bool _isLoading = false;
  late String email;
  late String password;

  void _signInUsers()async{
    if(_formKey.currentState!.validate()){
      setState(() {
        _isLoading=true;
      });

      await _authController.signInUsers(email: email, password: password, context: context);
      setState(() {
        _isLoading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.7,
                  ),
                ),
                TextFormField(
                  onChanged: (value){
                    email=value;
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return 'please enter your email';
                    } else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 20),

                TextFormField(
                  onChanged: (value){
                    password=value;
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return 'please enter your password';
                    } else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _signInUsers();
                  },
                  child: Container(
                    width: 319,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                        colors: [Color(0xFF102DE1), Color(0xCC0D6EFF)],
                      ),
                    ),

                    child: Center(
                      child: _isLoading?CircularProgressIndicator(color: Colors.white,):
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Need a Account?'),
                    TextButton(onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      }));
                    }, child: Text('SignUp')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
