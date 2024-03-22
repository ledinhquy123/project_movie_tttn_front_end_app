import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/controllers/user_controller.dart';
import 'package:app_movie/utils/button_back.dart';
import 'package:app_movie/utils/show_snackbar.dart';
import 'package:app_movie/views/screens/sign_in_screen.dart';
import 'package:app_movie/views/widgets/custom_button.dart';
import 'package:app_movie/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  dynamic user;
  bool enableInput = true;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  GlobalKey<FormState> key = GlobalKey<FormState>();
  
  @override
  void initState() {
    super.initState();
    user = SignInScreen.user;
    _nameController.text = user['name'];
    _emailController.text = user['email'];
    enableInput = user['provider_id'] != null ? false : true;
  }

  @override
  Widget build(BuildContext context) {
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
                            'Thông tin cá nhân',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            )
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CircleAvatar(
                            child: Image.network(
                              user['avatar'],
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if(loadingProgress == null) {
                                  return child;
                                }else {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: primaryMain1,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      
                      Form(
                        key: key,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Họ tên',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              CustomTextFormField(
                                enabled: enableInput,
                                hintText: 'Nhập họ tên',
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
                        
                                disabledBorder: const OutlineInputBorder(
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
                                    
                                keyboardType: TextInputType.emailAddress,
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
                                  if(value!.isEmpty){
                                    return 'Tên không được để trống';
                                  }
                                  return null;
                                },
                                controller: _nameController,
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
                                enabled: enableInput,
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
                        
                                disabledBorder: const OutlineInputBorder(
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
                                    
                                keyboardType: TextInputType.emailAddress,
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
                                  if(value!.isEmpty){
                                    return 'Email được để trống';
                                  }
                                  return null;
                                },
                                controller: _emailController,
                              ),
                              const SizedBox(height: 32),
                              
                              Visibility(
                                visible: enableInput,
                                replacement: const Text(''),
                                child: CustomButton(
                                  text: 'Thay đổi',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700
                                  ),
                                  onTap: () async {
                                    if (key.currentState!.validate()) {
                                      showDialog(
                                        context: context, 
                                        builder: (context) => const Center(
                                          child: CircularProgressIndicator(color: primaryMain1,),
                                        )
                                      );
                                      final data = {
                                        'id': user['id'].toString(),
                                        'name': _nameController.text,
                                        'email': _emailController.text
                                      };
                                      bool check = await UserController.checkEmailUpdate(context, data);

                                      if(check) {
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                        // ignore: use_build_context_synchronously
                                        showSnackbar(context, 'Cập nhật thành công', Colors.green);
                                      }else {
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                        // ignore: use_build_context_synchronously
                                        showSnackbar(context, 'Email đã tồn tại trong hệ thống', Colors.red);
                                      }
                                    }
                                  }
                                ),
                              ),
                            ],
                          ),
                        )
                      )
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

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
  }
}