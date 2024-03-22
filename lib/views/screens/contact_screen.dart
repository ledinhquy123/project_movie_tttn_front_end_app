import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/utils/button_back.dart';
import 'package:app_movie/utils/show_snackbar.dart';
import 'package:app_movie/views/screens/sign_in_screen.dart';
import 'package:app_movie/views/widgets/custom_button.dart';
import 'package:app_movie/views/widgets/custom_text_form_field.dart';
import 'package:email_sender/email_sender.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  TextEditingController _contactController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    dynamic user = SignInScreen.user;

    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 32),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [ primaryMain2, primaryMain1 ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
              ),
              color: Colors.grey.withOpacity(.7),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 24
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Liên hệ',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            )
                          )
                        ],
                      ),
                      const SizedBox(height: 32),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Form(
                          key: key,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Gửi tin nhắn đến chúng tôi',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    )
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                      
                              CustomTextFormField(
                                hintText: 'Nhập nội dung',
                                hintStyle: const TextStyle(
                                  color: outline,
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16)
                                  ),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: outline
                                  )
                                ),
                                    
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16)
                                  ),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: outline,
                                  )
                                ),
                                keyboardType: TextInputType.text, 
                                style: const TextStyle(color: Colors.white),
                        
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16)
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
                                    Radius.circular(16)
                                  ),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: primaryMain1,
                                  )
                                ),
                        
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return 'Nhập nội dung trước khi gửi';
                                  }
                                  return null;
                                },
                                maxLines: 10,
                                contentPadding: const EdgeInsets.all(16.0),
                                controller: _contactController,
                              ),
                              const SizedBox(height: 32),
                      
                              CustomButton(
                                text: 'Gửi',
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700
                                ),
                                onTap: () {
                                  if (key.currentState!.validate()) {
                                    sendEmail(_contactController.text, user);
                                    _contactController.text = '';
                                  }
                                }
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                showButtonBack(
                  context, 
                  primaryMain2, 
                  primaryMain1, 
                  Icons.arrow_back,
                  32,
                  24
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

  Future<void> sendEmail(String contact, dynamic user) async {
    try {
      EmailSender emailSender = EmailSender();
      await emailSender.sendMessage(
        '2154810051@vaa.edu.vn',
        'Movie app',
        'Support for user ${user['id']}',
        contact
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      showSnackbar(context, 'Mã gửi về email của bạn', Colors.green);
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _contactController.dispose();
  }
}