import 'package:chatto_app/components/app_snackbar.dart';
import 'package:chatto_app/config/app_constant.dart';
import 'package:chatto_app/screen/authentication/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

//import '../../../services/scaffold_messenger_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginBloc bloc = LoginBloc();
    bloc.init();
     GetIt.I<AppSnackbar>()
                    .showSnackBar();
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.loginState.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            LoginState state = snapshot.data as LoginState;
            //Doan nay clean day tho

            switch (state) {
              case LoginState.successful:
                print('Successful');
                // ScaffoldMessenger.of(context)
                //     .showSnackBar(snackBar("Successful"));
                break;
              case LoginState.failed:
                print('Failed');

                // ScaffoldMessenger.of(context).showSnackBar(snackBar("Failed"));
                break;
              case LoginState.tokenFailed:
                print('Token is out of date');
                // still conflict context ?
                // GetIt.I<AppSnackbar>()
                //     .showSnackBar(); //AppSnackbar.showSnackBar(const Text('Token is out of date'));
                // ScaffoldMessenger.of(context)
                //     .showSnackBar(snackBar("Token is out of date"));
                break;
              default:
                print('Loading....');
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(snackBar("Loading..."));
            }
            return loginArea(bloc);
          }
        },
      ),
    );
  }

  SnackBar snackBar(String text) {
    return SnackBar(content: Text(text));
  }

  Widget loginArea(bloc) {
    TextEditingController emailC = TextEditingController();
    TextEditingController passwordC = TextEditingController();
    return Column(
      children: [
        TextField(
          onChanged: (_) {
            bloc.checkField(emailC.text.toString(), passwordC.text.toString());
          },
          controller: emailC,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Email",
          ),
        ),
        TextField(
          onChanged: (_) {
            bloc.checkField(emailC.text.toString(), passwordC.text.toString());
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
              onPressed: () {},
              child: const Text("Haven't had account yet?"),
            ),
          ],
        ),
        ElevatedButton(
            onPressed: () {
              if (bloc.loginEnable.value) {
                bloc.login(emailC.text.toString(), passwordC.text.toString());
              }
            },
            child: const Text("Login")),
      ],
    );
  }
}
