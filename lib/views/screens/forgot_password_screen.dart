import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/utils/button_back.dart';
import 'package:app_movie/views/screens/create_new_password_screen.dart';
import 'package:app_movie/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class ForgotPassWordScreen extends StatefulWidget {
  String inpEmail;
  String? code;
  ForgotPassWordScreen({
    super.key,
    required this.inpEmail,
    this.code
  });

  @override
  State<ForgotPassWordScreen> createState() => _ForgotPassWordScreenState();
}

class _ForgotPassWordScreenState extends State<ForgotPassWordScreen> {
  String? inpCode;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [ primaryMain1, primaryMain2 ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
              ),
              color: Colors.grey.withOpacity(.7),
            ),
            child: Stack(
              children: [
                showButtonBack(context, primaryMain2, primaryMain1, Icons.arrow_back, 64, 0),

                Form(
                  key: key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo.png'),
                      const SizedBox(height: 32),
                
                      Text(
                        'Quên mật khẩu',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.white
                        ),
                      ),
                      const SizedBox(height: 16),
                
                      Text(
                        'Mã xác nhận đã được gửi về\n ${widget.inpEmail.substring(0, 3)} ****@gmail.com',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: outline
                        ),
                      ),
                      const SizedBox(height: 16),
                
                      PinCodeTextField(
                        keyboardType: TextInputType.number,
                        appContext: context, 
                        length: 4,
                        onChanged: (value) {
                          setState(() {
                            inpCode = value;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pin code không được rỗng';
                          }
                          if (widget.code != inpCode) {
                            return 'Pin code không hợp lệ';
                          }
                          return null;
                        },

                        animationType: AnimationType.fade,
                        animationDuration: const Duration(milliseconds: 300),
                        textStyle: const TextStyle(color: Colors.white),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          borderWidth: .5,
                          fieldWidth: 75, 
                          fieldHeight: 40,
                          selectedColor: Colors.white,
                          selectedBorderWidth: 2,
                          activeColor: outline,
                          inactiveColor: outline,
                        ),
                        
                      ),
                      const SizedBox(height: 16),
                     
                      Text(
                        'Gửi lại mã xác nhận sau 55 giây',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: outline
                        ),
                      ),
                      const SizedBox(height: 32),
                
                      CustomButton(
                        text: 'Xác Nhận',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700
                        ),
                        onTap: () {
                          if (key.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateNewPasswordScreen(
                                  inpEmail: widget.inpEmail
                                )
                              )
                            );
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}