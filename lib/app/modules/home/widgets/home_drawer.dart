import 'package:cine_log/app/core/auth/cinelog_auth_provider.dart';
import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/core/ui/theme_extensions.dart';
import 'package:cine_log/app/services/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<CinelogAuthProvider, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ??
                        'https://images.icon-icons.com/1378/PNG/512/avatardefault_92824.png';
                  },
                  builder: (_, value, __) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(value),
                      radius: 30,
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Selector<CinelogAuthProvider, String>(
                    selector: (context, authProvider) {
                      return authProvider.user?.displayName ?? 'Não informado';
                    },
                    builder: (_, value, __) {
                      return Text(
                        value,
                        style: context.textTheme.titleMedium,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Alterar Nome'),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text('Alterar nome'),
                    content: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _nameController,
                        onChanged: (value) => {nameVN.value = value},
                        validator: Validatorless.required(Messages.doFillName),
                        decoration: InputDecoration(
                          labelText: 'Insira o novo nome',
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final formValid = _formKey.currentState?.validate();
                          if (formValid == true) {
                            final nameValue = nameVN.value;
                            context.loaderOverlay.show();
                            await context
                                .read<UserService>()
                                .updateDisplayName(nameValue);
                            context.loaderOverlay.hide();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Alterar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            title: Text('Sair'),
            onTap: () async =>
                await context.read<CinelogAuthProvider>().logout(),
          ),
        ],
      ),
    );
  }
}
