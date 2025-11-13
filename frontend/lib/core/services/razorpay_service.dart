import 'dart:developer';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:frontend/core/utils/toaster.dart';

class RazorpayService {
  late Razorpay _razorpay;
  Function(String, String, String)? _onPaymentSuccess;
  Function(String)? _onPaymentError;

  RazorpayService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  /// Open Razorpay payment gateway
  ///
  /// [orderId] - Razorpay order ID received from backend
  /// [amount] - Amount in paise (₹1 = 100 paise)
  /// [keyId] - Razorpay key ID from backend
  /// [name] - User's name
  /// [email] - User's email
  /// [contact] - User's contact number
  /// [onSuccess] - Callback function when payment is successful
  /// [onError] - Callback function when payment fails
  void openPaymentGateway({
    required String orderId,
    required int amount,
    required String keyId,
    required String name,
    required String email,
    required String contact,
    required Function(String paymentId, String orderId, String signature) onSuccess,
    required Function(String errorMessage) onError,
  }) {
    _onPaymentSuccess = onSuccess;
    _onPaymentError = onError;

    log('Opening Razorpay with orderId: $orderId, amount: $amount, keyId: $keyId');

    if (keyId.isEmpty) {
      log('Razorpay Key ID is empty');
      onError('Razorpay configuration error');
      return;
    }

    var options = {
      'key': keyId,
      'amount': amount,
      'name': 'FreshCart',
      'order_id': orderId,
      'description': 'Payment for order',
      'timeout': 300, // in seconds (5 minutes)
      'prefill': {'contact': contact, 'email': email, 'name': name},
      'theme': {'color': '#2AB930'},
    };

    log('Razorpay options: $options');

    try {
      _razorpay.open(options);
      log('Razorpay modal opened successfully');
    } catch (e) {
      log('Error opening Razorpay: $e');
      onError('Failed to open payment gateway: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log('Payment Success: ${response.paymentId}');

    if (_onPaymentSuccess != null) {
      _onPaymentSuccess!(
        response.paymentId ?? '',
        response.orderId ?? '',
        response.signature ?? '',
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log('Payment Error: ${response.code} - ${response.message}');

    String errorMessage = 'Payment failed';

    if (response.message != null) {
      errorMessage = response.message!;
    }

    Toaster.showErrorMessage(message: errorMessage);

    if (_onPaymentError != null) {
      _onPaymentError!(errorMessage);
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log('External Wallet: ${response.walletName}');
    Toaster.showErrorMessage(message: 'External wallet not supported: ${response.walletName}');
  }

  /// Dispose Razorpay instance
  void dispose() {
    _razorpay.clear();
  }
}
