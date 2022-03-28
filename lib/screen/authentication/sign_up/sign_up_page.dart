import 'package:chatto_app/base/base_page.dart';
import 'package:chatto_app/components/primary_button.dart';
import 'package:chatto_app/screen/authentication/sign_up/sign_up_bloc.dart';
import 'package:flutter/material.dart';

import '../../../utils/status.dart';

/*Created by Sudo248

  This is SignUpPage which user type your email and 
  password to create a new account

  
 */

class SignUpPage extends BasePage<SignUpBloc> {
  late Size size;
  final bloc = SignUpBloc();
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          _content(),
          StreamBuilder<Status<String>>(
            stream: bloc.signUpStatusStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox.shrink();
              return snapshot.data!.when<Widget>(
                onIdle: () => const SizedBox.shrink(),
                onLoading: () {
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Color.fromRGBO(80, 80, 80, 0.8),
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                onSuccess: (data) {
                  return const SizedBox.shrink();
                },
                onError: (message) {
                  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(message)));
                  });
                  return Container();
                },
              )!;
            },
          ),
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
          StreamBuilder<Status>(
              stream: bloc.emailStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }
                return TextField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: const OutlineInputBorder(),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: snapshot.data!.when<Widget>(
                        onLoading: () => const UnconstrainedBox(
                          child: SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        onSuccess: (data) => const Icon(
                          Icons.check_circle_outline_outlined,
                          color: Colors.green,
                        ),
                        onError: (message) => const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    errorText: (snapshot.data is Error)
                        ? (snapshot.data as Error).message
                        : null,
                  ),
                  onChanged: (email) => bloc.deboundTimeVerifyEmail(email),
                );
              }),
          SizedBox(
            height: space,
          ),
          StreamBuilder<Status>(
              stream: bloc.passwordStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }
                return TextField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: const OutlineInputBorder(),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: snapshot.data!.when<Widget>(
                        onLoading: () => const CircularProgressIndicator(),
                        onSuccess: (data) => const Icon(
                          Icons.check_circle_outline_outlined,
                          color: Colors.green,
                        ),
                        onError: (message) => const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    errorText: (snapshot.data is Error)
                        ? (snapshot.data as Error).message
                        : null,
                  ),
                  obscureText: true,
                  onChanged: (password) => bloc.verifyPassword(password),
                );
              }),
          SizedBox(
            height: space,
          ),
          StreamBuilder<Status>(
              stream: bloc.confirmPasswordStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox.shrink();
                return TextField(
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: const OutlineInputBorder(),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: snapshot.data!.when<Widget>(
                        onLoading: () => const CircularProgressIndicator(),
                        onSuccess: (data) => const Icon(
                          Icons.check_circle_outline_outlined,
                          color: Colors.green,
                        ),
                        onError: (message) => const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    errorText: (snapshot.data is Error)
                        ? (snapshot.data as Error).message
                        : null,
                  ),
                  obscureText: true,
                  onChanged: (confirmPassword) =>
                      bloc.verifyConfirmPassword(confirmPassword),
                );
              }),
          SizedBox(
            height: space,
          ),
          StreamBuilder<bool>(
            stream: bloc.signUpValid,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              }
              return PrimaryButton(
                onPressed: snapshot.data! ? bloc.onSignUpClick : null,
                child: const Text("Sign up"),
              );
            },
          ),
        ],
      ),
    );
  }
}
