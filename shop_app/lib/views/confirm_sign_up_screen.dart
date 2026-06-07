import 'package:flutter/material.dart';
import 'package:shop_app/controllers/auth_controller.dart';

class ConfirmSignUpScreen extends StatefulWidget {
  final String email;
  const ConfirmSignUpScreen({super.key, required this.email});

  @override
  State<ConfirmSignUpScreen> createState() => _ConfirmSignUpScreenState();
}

class _ConfirmSignUpScreenState extends State<ConfirmSignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  String confirmationCode = ''; // ✅ late hata diya
  bool _isLoading = false;      // ✅ loading add kiya

  void verifyOtp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // ✅ save add kiya
      setState(() { _isLoading = true; });

      await _authController.confirmUserSignUp(
        email: widget.email,
        confirmationCode: confirmationCode,
        context: context,
      );

      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Verify your account',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Enter the otp sent to ${widget.email}',
                  style: TextStyle(fontSize: 13),
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number, // ✅ OTP ke liye number keyboard
                  onChanged: (value) {
                    confirmationCode = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter OTP';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'ENTER OTP',
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: verifyOtp, // ✅ clean function call
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
                      child: _isLoading  // ✅ loading indicator
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                        'Verify',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}