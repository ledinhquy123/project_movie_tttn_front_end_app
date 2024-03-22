import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/controllers/user_controller.dart';
import 'package:app_movie/utils/button_back.dart';
import 'package:app_movie/views/widgets/custom_button.dart';
import 'package:app_movie/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

// ignore: must_be_immutable
class CreateNewPasswordScreen extends StatefulWidget {
  String inpEmail;

  CreateNewPasswordScreen({
    super.key,
    required this.inpEmail
  });

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController passwordControler = TextEditingController();

  bool passObscure = true;
  bool againPassObscure = true;
  bool checkLength = false;
  bool checkLetterAndNumber = false;
  bool checkSpecial = false;
  String? inpNewPass;

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
                      const SizedBox(height: 16),
                            
                      Text(
                        'Tạo mật khẩu mới',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.white
                        ),
                      ),
                      const SizedBox(height: 16),
                            
                      Row(
                        children: [
                          Text(
                            'Nhập mật khẩu mới',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                
                      CustomTextFormField(
                        controller: passwordControler,
                        hintText: 'Nhập mật khẩu mới',
                        hintStyle: const TextStyle(
                          color: outline,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30)
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: outline
                          )
                        ),
                            
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30)
                          ),
                          borderSide: BorderSide(
                            width: 2,
                            color: outline,
                          )
                        ),
                            
                        prefixIcon: const Icon(
                          IconlyLight.lock,
                          color: Colors.white,
                        ),
                            
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              againPassObscure = !againPassObscure;
                            });
                          }, 
                          icon: !againPassObscure ? const Icon(
                              IconlyLight.show,
                            color: Colors.white,
                          ) : const Icon(
                            IconlyLight.hide,
                            color: Colors.white,
                          )
                        ),
                            
                        obscureText: againPassObscure,
                        style: const TextStyle(color: Colors.white),

                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30)
                          ),
                          borderSide: BorderSide(
                            width: 2,
                            color: primaryMain1,
                          )
                        ),

                        errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: primaryMain1,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700
                        ),

                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30)
                          ),
                          borderSide: BorderSide(
                            width: 2,
                            color: primaryMain1,
                          )
                        ),
                        validator: (value) {
                          if(value!.isEmpty) {
                            return 'Mật khẩu không được để trống';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            checkLength = value.length >= 8 ? true : false;
                            checkLetterAndNumber = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).*$').hasMatch(value);
                            checkSpecial = RegExp(r'[!@#%^&*(),.?":{}|<>]').hasMatch(value);
                            inpNewPass = value;
                          });
                        },
                      ),
                      const SizedBox(height: 32),
                      
                      Row(
                        children: [
                          Text(
                            'Nhập lại mật khẩu mới',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                
                      CustomTextFormField(
                        hintText: 'Nhập lại mật khẩu mới',
                        hintStyle: const TextStyle(
                          color: outline,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30)
                          ),
                          borderSide: BorderSide(
                            width: 1,
                            color: outline
                          )
                        ),
                            
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30)
                          ),
                          borderSide: BorderSide(
                            width: 2,
                            color: outline,
                          )
                        ),
                            
                        prefixIcon: const Icon(
                          IconlyLight.lock,
                          color: Colors.white,
                        ),
                            
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passObscure = !passObscure;
                            });
                          }, 
                          icon: !passObscure ? const Icon(
                              IconlyLight.show,
                            color: Colors.white,
                          ) : const Icon(
                            IconlyLight.hide,
                            color: Colors.white,
                          )
                        ),
                            
                        obscureText: passObscure,
                        style: const TextStyle(color: Colors.white),

                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30)
                          ),
                          borderSide: BorderSide(
                            width: 2,
                            color: primaryMain1,
                          )
                        ),

                        errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: primaryMain1,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700
                        ),

                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30)
                          ),
                          borderSide: BorderSide(
                            width: 2,
                            color: primaryMain1,
                          )
                        ),
                        validator: (value) {
                          if(value!.isEmpty) {
                            return 'Mật khẩu không được để trống';
                          }
                          if(value != inpNewPass) {
                            return 'Xác nhận mật khẩu chưa chính xác';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 16),
                            
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: outline
                              )
                            ),
                            child: Icon(
                              checkLength ? Icons.check : null,
                              color: Colors.green,
                              size: 16,
                            ) ,
                          ),
                          const SizedBox(width: 8),
                            
                          Text(
                            'Mật khẩu tối thiểu 8 ký tự',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: outline
                              )
                            ),
                            child: Icon(
                              checkLetterAndNumber ? Icons.check : null,
                              color: Colors.green,
                              size: 16,
                            ) ,
                          ),
                          const SizedBox(width: 8),
                            
                          Text(
                            'Bao gồm chữ và số',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: outline
                              )
                            ),
                            child: Icon(
                              checkSpecial ? Icons.check : null,
                              color: Colors.green,
                              size: 16,
                            ) ,
                          ),
                          const SizedBox(width: 8),
                            
                          Text(
                            'Bao gồm kí tự đặc biệt',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      
                      CustomButton(
                        text: 'Hoàn thành',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700
                        ),
                        onTap: () {
                          if (key.currentState!.validate()){
                            UserController.changePass(context, widget.inpEmail, passwordControler.text);
                          }
                        }
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    passwordControler.dispose();
  }
}