import 'package:crud/signin_signup/viewmodel/firbase_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class OauthIconsWidget extends StatelessWidget {
  const OauthIconsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFF4285f0),
            radius: 30,
            child: FaIcon(
              FontAwesomeIcons.facebookF,
              color: Colors.white,
            ),
          ),
          const CircleAvatar(
            backgroundColor: Color(0xFF00c2f0),
            radius: 30,
            child: FaIcon(
              FontAwesomeIcons.twitter,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<OauthPov>().googleSignin();
            },
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFFd24836),
              child: FaIcon(
                FontAwesomeIcons.google,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
