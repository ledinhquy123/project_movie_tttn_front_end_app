import 'package:app_movie/constant/colors.dart';
import 'package:app_movie/controllers/user_controller.dart';
import 'package:app_movie/views/screens/contact_screen.dart';
import 'package:app_movie/views/screens/info_screen.dart';
import 'package:app_movie/views/screens/sign_in_screen.dart';
import 'package:app_movie/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProfileTapScreen extends StatefulWidget {
  const ProfileTapScreen({super.key});

  @override
  State<ProfileTapScreen> createState() => _ProfileTapScreenState();
}

class _ProfileTapScreenState extends State<ProfileTapScreen> with AutomaticKeepAliveClientMixin  {
  @override
  bool get wantKeepAlive => true;
  
  dynamic user = SignInScreen.user;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
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
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Trang cá nhân',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                      )
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 10),
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
                const SizedBox(height: 8),

                Text(
                  user['name'],
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 10),

                customInfo(
                  'Thông tin cá nhân',
                  Icons.person,
                  Colors.blue,
                  () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const InfoScreen())
                    );
                  },
                ),

                const SizedBox(height: 16),
                customInfo(
                  'Liên hệ', 
                  Icons.help,
                  const Color(0xFF64FFA2), 
                  () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const ContactScreen())
                    );
                  }
                ),
                const SizedBox(height: 16),

                CustomButton(
                  text: 'Đăng xuất',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600
                  ),
                  onTap: () {
                    if(user['access_token'] != null) {
                      UserController.signOutGoogle();
                    }
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ]
            )
          ),
        ),
      ),
    );
  }

  Widget customInfo(String text, IconData preIcon, Color precolor, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: outline
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(16)
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              preIcon,
              color: precolor,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600
              ),
            ),
            const Icon(
              IconlyBold.arrow_right_2,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}