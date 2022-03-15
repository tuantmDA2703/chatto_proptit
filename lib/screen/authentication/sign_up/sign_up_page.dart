import 'package:chatto_app/base/base_page.dart';
import 'package:chatto_app/screen/authentication/sign_up/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utils/status.dart';

class SignUpPage extends BasePage<SignUpBloc> {
  late Size size;
  TextEditingController userNameCtrl = TextEditingController(),
      passwordCtrl = TextEditingController(),
      confirmPassCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    BuildContext pageContext = context;
    return Scaffold(
      body: Stack(
        children: [
          _content(),
          StreamBuilder(
              stream: bloc.signUpStatusStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                return (snapshot.data as Status<String>).when(
                    onIdle: () => Container(),
                    onLoading: () {
                      return Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Color.fromRGBO(80, 80, 80,0.8),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                    onSuccess: (data) {
                      return Container();
                    },
                    onError: (message) {
                      //   ScaffoldMessenger.of(pageContext)
                      //       .showSnackBar(SnackBar(content: Text(message)));
                      return Container();
                    });
              }),
        ],
      ),
    );
  }

  Widget _content() {
    double space = size.height / 20;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign Up",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: space,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: "Username",
              border: OutlineInputBorder(),
            ),
            controller: userNameCtrl,
          ),
          SizedBox(
            height: space,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
            controller: passwordCtrl,
          ),
          SizedBox(
            height: space,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: "Confirm password",
              border: OutlineInputBorder(),
            ),
            controller: confirmPassCtrl,
          ),
          SizedBox(
            height: space,
          ),
          ElevatedButton(
              onPressed: () {
                bloc.onSignUpClick(
                    userNameCtrl.text, passwordCtrl.text, confirmPassCtrl.text);
              },
              child: Text("Sign up")),
        ],
      ),
    );
  }
}
