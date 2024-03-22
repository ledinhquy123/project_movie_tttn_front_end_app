import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/controllers/user_controller.dart';
import 'package:app_movie/utils/button_back.dart';
import 'package:app_movie/utils/show_dialog.dart';
import 'package:app_movie/views/widgets/custom_button.dart';
import 'package:app_movie/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [ button1, Color(0xFF393939) ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
              ),
              color: Colors.grey.withOpacity(.7),
            ),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height
            ),
            child: Stack(
              children: [
                showButtonBack(context, primaryMain2, primaryMain1, Icons.arrow_back, 64, 0),
                Form(
                  key: key,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 52),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/logo.png'),
                        const SizedBox(height: 16),
                              
                        Text(
                          'Đăng kí',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(height: 16),
                  
                        Row(
                          children: [
                            Text(
                              'Họ và tên',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                                  
                        CustomTextFormField(
                          controller: nameController,
                          hintText: 'Nhập họ và tên',
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
                            Icons.person_2_outlined,
                            color: Colors.white,
                          ),
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
                              return 'Họ và tên không được để trống';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                  
                        Row(
                          children: [
                            Text(
                              'Email',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                                  
                        CustomTextFormField(
                          controller: emailController,
                          hintText: 'Nhập email',
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
                            IconlyLight.message,
                            color: Colors.white,
                          ),
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
                              return 'Email không được để trống';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                  
                        Row(
                          children: [
                            Text(
                              'Nhập mật khẩu',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                                  
                        CustomTextFormField(
                          controller: passwordController,
                          hintText: 'Nhập mật khẩu',
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
                        const SizedBox(height: 16),
                        
                        Row(
                          children: [
                            Text(
                              'Nhập lại mật khẩu',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.white
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                                  
                        CustomTextFormField(
                          hintText: 'Nhập lại mật khẩu',
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
                          text: 'Đăng kí',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                          ),
                          onTap: () async {
                            if (key.currentState!.validate()){
                              showDialog(context: context, builder: (context) => const Center(
                                child: CircularProgressIndicator(
                                  color: primaryMain1,
                                ),
                              ));
                              bool checkSignUp = await UserController.signUpUser(
                                context, 
                                nameController.text,emailController.text, 
                                passwordController.text
                              );
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              if(checkSignUp) {
                                // ignore: use_build_context_synchronously
                                openDialog(
                                  context, 'Thành công', 'Tài khoản của bạn đã được đăng kí thành công'
                                );
                              }else {
                                print('okok');
                              }
                            }
                          }
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}