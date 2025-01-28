import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/core/notifier/default_listener_notifier.dart';
import 'package:cine_log/app/core/ui/theme_extensions.dart';
import 'package:cine_log/app/core/validators/validators.dart';
import 'package:cine_log/app/core/widget/cine_log_field.dart';
import 'package:cine_log/app/core/widget/cine_log_logo.dart';
import 'package:cine_log/app/core/widget/user_message.dart';
import 'package:cine_log/app/modules/auth/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  final _emailFN = FocusNode();
  final _passwordFN = FocusNode();
  final _confirmPasswordFN = FocusNode();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    var defaultListener = DefaultListenerNotifier(
        changeNotifier: context.read<RegisterController>());

    defaultListener.listener(
      context: context,
      successCallback: (notifier, listener) {
        UserMessage.of(context).showInfo(Messages.userCreated);
        listener.dispose();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: ClipOval(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_outlined,
                size: 24,
                color: context.primaryColor,
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Messages.appName,
              style: TextStyle(
                fontSize: 10,
                color: context.primaryColor,
              ),
            ),
            Text(
              Messages.register,
              style: TextStyle(
                fontSize: 18,
                color: context.primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * .5,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: CineLogLogo(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: SizedBox(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CineLogField(
                        label: Messages.email,
                        focusNode: _emailFN,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_passwordFN),
                        controller: _emailEC,
                        validator: Validatorless.multiple([
                          Validatorless.required(Messages.emailRequired),
                          Validatorless.email(Messages.emailInvalidFormat)
                        ]),
                      ),
                      SizedBox(height: 20),
                      CineLogField(
                        label: Messages.password,
                        focusNode: _passwordFN,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(_confirmPasswordFN),
                        obscureText: true,
                        controller: _passwordEC,
                        validator: Validatorless.multiple([
                          Validatorless.required(Messages.passwordRequired),
                          Validatorless.min(
                            6,
                            Messages.minLength(Messages.password, '6'),
                          ),
                        ]),
                      ),
                      SizedBox(height: 20),
                      CineLogField(
                        label: Messages.confirmPassword,
                        obscureText: true,
                        focusNode: _confirmPasswordFN,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        controller: _confirmPasswordEC,
                        validator: Validatorless.multiple([
                          Validatorless.required(
                              Messages.confirmPassWordRequired),
                          Validators.compare(
                              _passwordEC, Messages.confirmPassWordDoesntMatch),
                        ]),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FilledButton(
                          onPressed: () async {
                            final formValid =
                                _formKey.currentState?.validate() ?? false;
                            if (formValid) {
                              await context
                                  .read<RegisterController>()
                                  .registerUser(
                                      _emailEC.text, _passwordEC.text);
                            }
                          },
                          child: Text(Messages.save),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
