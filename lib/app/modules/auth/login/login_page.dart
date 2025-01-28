import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/core/notifier/default_listener_notifier.dart';
import 'package:cine_log/app/core/widget/cine_log_field.dart';
import 'package:cine_log/app/core/widget/cine_log_logo.dart';
import 'package:cine_log/app/core/widget/user_message.dart';
import 'package:cine_log/app/modules/auth/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  final _emailFN = FocusNode();
  final _passwordFN = FocusNode();

  @override
  void initState() {
    super.initState();

    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
            context: context,
            everCallback: (notifier, listenerInstance) {
              if (notifier is LoginController) {
                if (notifier.hasInfo == true) {
                  UserMessage.of(context)
                      .showInfo(Messages.recoverPasswordEmaiLSent);
                }
              }
            },
            successCallback: (notifier, listener) {
              listener.dispose();
              Navigator.of(context).pushReplacementNamed('/');
            });
  }

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: maxHeight * .12),
                      CineLogLogo(),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CineLogField(
                                label: Messages.email,
                                controller: _emailEC,
                                focusNode: _emailFN,
                                autovalidateMode: AutovalidateMode.onUnfocus,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) => FocusScope.of(context)
                                    .requestFocus(_passwordFN),
                                validator: Validatorless.multiple([
                                  Validatorless.required(
                                      Messages.emailRequired),
                                  Validatorless.email(
                                      Messages.emailInvalidFormat)
                                ]),
                              ),
                              SizedBox(height: 20),
                              CineLogField(
                                label: Messages.password,
                                controller: _passwordEC,
                                focusNode: _passwordFN,
                                obscureText: true,
                                autovalidateMode: AutovalidateMode.onUnfocus,
                                textInputAction: TextInputAction.done,
                                validator: Validatorless.required(
                                    Messages.passwordRequired),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      if (_emailEC.text.isNotEmpty) {
                                        await context
                                            .read<LoginController>()
                                            .forgotPassword(_emailEC.text);
                                      } else {
                                        _emailFN.requestFocus();
                                        UserMessage.of(context).showError(
                                            Messages
                                                .typeAnEmailToRecoverPassword);
                                      }
                                    },
                                    child: Text(Messages.forgotPassword),
                                  ),
                                  FilledButton(
                                    onPressed: () async {
                                      final formValid =
                                          _formKey.currentState?.validate();
                                      if (formValid == true) {
                                        await context
                                            .read<LoginController>()
                                            .login(_emailEC.text,
                                                _passwordEC.text);
                                      }
                                    },
                                    child: Text(Messages.login),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            border: Border(
                              top: BorderSide(
                                width: 2,
                                color: Colors.grey.withAlpha(50),
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                                width: constraints.maxWidth,
                              ),
                              SignInButton(
                                Buttons.google,
                                text: Messages.continueWithGoogle,
                                padding: EdgeInsets.all(5),
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                onPressed: () {},
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(Messages.hasNotAccount),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/register');
                                    },
                                    child: Text(Messages.registerNow),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
