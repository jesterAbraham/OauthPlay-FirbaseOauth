import 'dart:convert';
import 'package:crud/signin_signup/view/widgets/textfield.dart';
import 'package:crud/signin_signup/viewmodel/userimage_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes/routes.dart';
import '../viewmodel/firbase_provider.dart';
import '../viewmodel/signup_provider.dart';
import 'widgets/oauth_icons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(height: size.width / 5),
            Center(
              child: AnimatedTextKit(
                totalRepeatCount: 500,
                isRepeatingAnimation: true,
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Create Account',
                    textStyle: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                    colors: [
                      Colors.white,
                      Colors.grey,
                      Colors.purple,
                      Colors.indigo,
                      Colors.white,
                      Colors.grey,
                      Colors.purple,
                      Colors.indigo,
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size.width / 6),
            const ImageWidget(),
            const SizedBox(height: 40),
            TextFieldWidget(
              size: size,
              contoller: context.read<SigningPov>().nameController,
              hint: 'Name',
              type: TextInputType.emailAddress,
              icon: Icons.person,
              obsecure: false,
            ),
            TextFieldWidget(
              size: size,
              contoller: context.read<SigningPov>().emailController,
              hint: 'Email',
              type: TextInputType.emailAddress,
              icon: Icons.email_outlined,
              obsecure: false,
            ),
            TextFieldWidget(
              size: size,
              contoller: context.read<SigningPov>().passwordController,
              hint: 'Password',
              type: TextInputType.visiblePassword,
              icon: Icons.lock_outline,
              obsecure: true,
            ),
            Consumer<OauthPov>(
              builder: (context, value, child) => Column(
                children: [
                  value.isLoadingUp
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 34,
                            vertical: 8,
                          ),
                          height: 50,
                          child: const Center(
                            child: CupertinoActivityIndicator(
                              radius: 16,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            context.read<SigningPov>().callSignUp(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 8,
                            ),
                            height: 48,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white.withOpacity(.5),
                            ),
                            child: const Center(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 34, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.6),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      context.read<SigningPov>().disposeItems(context);
                      Routes.pop();
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const OauthIconsWidget()
          ],
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserImagePov>(
      builder: (context, value, child) => Center(
        child: SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 60,
                backgroundImage: MemoryImage(
                  const Base64Decoder().convert(value.imageToString),
                ),
              ),
              Positioned(
                bottom: 0,
                right: -30,
                child: RawMaterialButton(
                  onPressed: () {
                    value.pickImage();
                  },
                  elevation: 4,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(8),
                  shape: const CircleBorder(),
                  child: const Icon(Icons.camera_alt_outlined),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
