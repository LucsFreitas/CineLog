import 'package:cine_log/app/core/notifier/default_listener_notifier.dart';
import 'package:cine_log/app/core/ui/theme_extensions.dart';
import 'package:cine_log/app/core/validators/validators.dart';
import 'package:cine_log/app/core/widget/cine_log_field.dart';
import 'package:cine_log/app/core/widget/cine_log_logo.dart';
import 'package:cine_log/app/core/widget/messages.dart';
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

  final emailFN = FocusNode();
  final passwordFN = FocusNode();
  final confirmPasswordFN = FocusNode();

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
        Messages.of(context).showInfo('Usuário criado com sucesso.');
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
              'CineLog',
              style: TextStyle(
                fontSize: 10,
                color: context.primaryColor,
              ),
            ),
            Text(
              'Registre-se',
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
                        label: 'Email',
                        focusNode: emailFN,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(passwordFN),
                        controller: _emailEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Email é obrigatório'),
                          Validatorless.email('Deve ser um email válido')
                        ]),
                      ),
                      SizedBox(height: 20),
                      CineLogField(
                        label: 'Senha',
                        focusNode: passwordFN,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(context)
                            .requestFocus(confirmPasswordFN),
                        obscureText: true,
                        controller: _passwordEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha obrigatória'),
                          Validatorless.min(
                              6, "Senha deve ter pelo menos 6 caracteres"),
                        ]),
                      ),
                      SizedBox(height: 20),
                      CineLogField(
                        label: 'Confirme a senha',
                        obscureText: true,
                        focusNode: confirmPasswordFN,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        controller: _confirmPasswordEC,
                        validator: Validatorless.multiple([
                          Validatorless.required(
                              'Confirmação de senha obrigatória'),
                          Validators.compare(
                              _passwordEC, 'Senhas informadas não conferem'),
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
                          child: Text('Salvar'),
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
