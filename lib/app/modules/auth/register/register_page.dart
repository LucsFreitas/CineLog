import 'package:cine_log/app/core/ui/theme_extensions.dart';
import 'package:cine_log/app/core/widget/cine_log_field.dart';
import 'package:cine_log/app/core/widget/cine_log_logo.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
      body: ListView(
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
                child: Column(
                  children: [
                    CineLogField(label: 'Email'),
                    SizedBox(height: 20),
                    CineLogField(
                      label: 'Senha',
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    CineLogField(
                      label: 'Confirme a senha',
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FilledButton(
                        onPressed: () => Navigator.pop(context),
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
    );
  }
}
