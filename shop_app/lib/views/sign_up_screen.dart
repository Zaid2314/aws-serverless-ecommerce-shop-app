import 'package:flutter/material.dart';
import 'package:shop_app/controllers/auth_controller.dart';
import 'package:shop_app/views/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  bool _isLoading = false;
  String email = '';
  String fullName = '';
  String password = '';
  void signUpUsers() async{
    FocusScope.of(context).unfocus();
    if(_formKey.currentState != null && _formKey.currentState!.validate()){
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      await _authController.signUpUsers(email: email, fullName: fullName, password: password, context: context);
      setState(() {
        _isLoading = false;
      });
    } else{
      print('all fields are required');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create your Account',
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
                      fullName=value;
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return 'please enter your Full Name';
                      } else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'FullName',
                      prefixIcon: Icon(Icons.person),
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
                      signUpUsers();
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
                        child: _isLoading? CircularProgressIndicator(color: Colors.white,):Text(
                          'Sign up',
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
                      Text('Already have an Account?'),
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (Context){
                          return SignInScreen();
                        }));
                      }, child: Text('Signin')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}