import 'package:e_shop/src/features/checkout/presentation/payment/payment_button_controller.dart';
import 'package:e_shop/src/localization/string_hardcoded.dart';
import 'package:e_shop/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/src/common_widgets/primary_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Button used to initiate the payment flow.
class PaymentButton extends ConsumerWidget {
  const PaymentButton({super.key});

  Future<void> _pay(BuildContext context, WidgetRef ref) async {
    ref.read(paymentButtonControllerProvider.notifier).pay();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      paymentButtonControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(paymentButtonControllerProvider);
    return PrimaryButton(
      text: 'Pay'.hardcoded,
      isLoading: state.isLoading,
      onPressed: state.isLoading ? null : () => _pay(context, ref),
    );
  }
}
