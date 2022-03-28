/*
  Create by: Tris1702
  Date: 22/03/2022

  [About this file]
    * This code is about UI of Login page, we try to handle
      event from LoginBloc.loginState
  
  [Solution for context conflic when try to call snackbar in StreamBuilder]
    * link: https://medium.com/@gedu07/actions-and-transitions-after-a-streambuilder-event-f805f48214cd
*/


import 'package:chatto_app/components/app_snackbar.dart';
import 'package:chatto_app/config/app_constant.dart';
import 'package:chatto_app/config/app_route.dart';
import 'package:chatto_app/screen/authentication/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginBloc bloc = LoginBloc();
    final TextEditingController emailC = TextEditingController();
    final TextEditingController passwordC = TextEditingController();
    bloc.init();
    _logInActionListener(bloc, context);
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.loginState.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return Column(
              children: [
                TextField(
                  onChanged: (_) {
                    bloc.checkField(
                        emailC.text.toString(), passwordC.text.toString());
                  },
                  controller: emailC,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
                TextField(
                  onChanged: (_) {
                    bloc.checkField(
                        emailC.text.toString(), passwordC.text.toString());
                  },
                  controller: passwordC,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Password"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text("Forgot Password"),
                    ),
                    TextButton(
                      onPressed: () {
                        bloc.navigator.pushed(AppRoute.signUp);
                      },
                      child: const Text("Haven't had account yet?"),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      if (bloc.loginEnable.value) {
                        bloc.login(
                            emailC.text.toString(), passwordC.text.toString());
                      }
                    },
                    child: const Text("Login")),
              ],
            );
          }
        },
      ),
    );
  }

  void _logInActionListener(LoginBloc loginBloc, BuildContext context) {
    onData(state) {
      switch (state) {
        case LoginState.successful:
          print('Sucessful');
          GetIt.I<AppSnackbar>().showSnackBar('Welcome!');
          break;
        case LoginState.failed:
          print('Failed');
          GetIt.I<AppSnackbar>().showSnackBar('Email or password is wrong');
          break;
        case LoginState.tokenFailed:
          print('Token is out of date');
          GetIt.I<AppSnackbar>().showSnackBar('Token is out of date');
          break;
        default:
          print('Loading....');
          GetIt.I<AppSnackbar>().showSnackBar('Loading...');
      }
    }

    loginBloc.loginState.listen(onData);
  }
}
