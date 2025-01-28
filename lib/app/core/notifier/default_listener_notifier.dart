import 'package:cine_log/app/core/consts/texts.dart';
import 'package:cine_log/app/core/notifier/default_change_notifier.dart';
import 'package:cine_log/app/core/widget/user_message.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class DefaultListenerNotifier {
  DefaultListenerNotifier({
    required this.changeNotifier,
  });

  final DefaultChangeNotifier changeNotifier;
  late final VoidCallback _listener;

  void listener({
    required BuildContext context,
    required SuccessVoidCallback successCallback,
    ErrorVoidCallback? errorCallback,
    EverCallback? everCallback,
  }) {
    _listener = () {
      if (everCallback != null) {
        everCallback(changeNotifier, this);
      }
      if (changeNotifier.loading) {
        context.loaderOverlay.show();
      } else {
        context.loaderOverlay.hide();
      }

      if (changeNotifier.hasError) {
        if (errorCallback != null) {
          errorCallback(changeNotifier, this);
        } else {
          UserMessage.of(context)
              .showError(changeNotifier.error ?? Messages.unexpectedError);
        }
      } else if (changeNotifier.isSuccess) {
        successCallback(changeNotifier, this);
      }
    };

    changeNotifier.addListener(_listener);
  }

  void dispose() {
    changeNotifier.removeListener(_listener);
  }
}

typedef SuccessVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance);

typedef ErrorVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance);

typedef EverCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance);
