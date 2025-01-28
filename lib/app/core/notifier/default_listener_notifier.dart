import 'package:cine_log/app/core/notifier/default_change_notifier.dart';
import 'package:cine_log/app/core/widget/messages.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class DefaultListenerNotifier {
  DefaultListenerNotifier({
    required this.changeNotifier,
  });

  final DefaultChangeNotifier changeNotifier;

  void listener(
      {required BuildContext context,
      required SuccessVoidCallback successCallback,
      ErrorVoidCallback? errorCallback}) {
    changeNotifier.addListener(() {
      if (changeNotifier.loading) {
        context.loaderOverlay.show();
      } else {
        context.loaderOverlay.hide();
      }

      if (changeNotifier.hasError) {
        if (errorCallback != null) {
          errorCallback(changeNotifier, this);
        } else {
          Messages.of(context)
              .showError(changeNotifier.error ?? 'Ocorreu um erro :(');
        }
      } else if (changeNotifier.isSuccess) {
        successCallback(changeNotifier, this);
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SuccessVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance);

typedef ErrorVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance);
