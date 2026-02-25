import 'package:booking_system_flutter/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';
import '../model/payment_gateway_response.dart';
import '../utils/common.dart';
import '../utils/configs.dart';

class PayStackService {
  late BuildContext ctx;
  num totalAmount = 0;
  int bookingId = 0;
  late Function(Map<String, dynamic>) onComplete;
  late Function(bool) loderOnOFF;
  PaymentSetting? currentPaymentMethod;

  init({
    required BuildContext context,
    required PaymentSetting currentPaymentMethod,
    required num totalAmount,
    required int bookingId,
    required Function(Map<String, dynamic>) onComplete,
    required Function(bool) loderOnOFF,
  }) {
    ctx = context;
    this.totalAmount = totalAmount;
    this.bookingId = bookingId;
    this.onComplete = onComplete;
    this.loderOnOFF = loderOnOFF;
    this.currentPaymentMethod = currentPaymentMethod;
  }

  Future checkout() async {
    loderOnOFF(true);

    try {
      // Get public key
      String publicKey = currentPaymentMethod!.isTest == 1
          ? currentPaymentMethod!.testValue!.paystackPublicKey.validate()
          : currentPaymentMethod!.liveValue!.paystackPublicKey.validate();

      if (publicKey.isEmpty) {
        throw language.accessDeniedContactYourAdmin;
      }

      // Get currency
      String currency = await isIqonicProduct
          ? PAYSTACK_CURRENCY_CODE
          : '${appConfigurationStore.currencyCode}';

      // Amount in kobo/cents (multiply by 100)
      int amountInKobo = totalAmount.toInt() * 100;

      // Create unique reference
      String reference = 'ref_${DateTime.now().millisecondsSinceEpoch}';
      // Make payment
      // final response = await PayWithPayStack().now(
      //   context: ctx,
      //   secretKey: publicKey,
      //   customerEmail: appStore.userEmail,
      //   reference: reference,
      //   currency: currency,
      //   amount: amountInKobo.toString(),
      //   transactionCompleted: () {
      //     log('Payment successful: $reference');
      //     onComplete.call({
      //       'transaction_id': reference,
      //     });
      //     loderOnOFF(false);
      //   },
      //   transactionNotCompleted: () {
      //     log('Payment not completed');
      //     loderOnOFF(false);
      //     toast('Payment was not completed', print: true);
      //   },
      //   callbackUrl: '', // Optional
      // );

    //   log('Paystack Response: $response');
    //
    } catch (e) {
      loderOnOFF(false);
      log('Paystack Error: $e');
      toast('Payment error: $e', print: true);
    }
  }

    }