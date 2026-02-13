import 'customer.dart';

enum PaymentWorkflow { otp, inApp }

String _wfToString(PaymentWorkflow wf) =>
    wf == PaymentWorkflow.otp ? 'otp' : 'in_app';

class PaymentInitiateRequest {
  final String merchantReference;
  final num amount;
  final String currency;
  final String channel;
  final String country;
  final Customer customer;
  final String? description;
  final Map<String, dynamic>? metadata;

  final PaymentWorkflow workflow;

  /// OTP workflow
  final String? otp;

  /// IN_APP workflow
  final String? successRedirectUrl;
  final String? failedRedirectUrl;

  PaymentInitiateRequest.otp({
    required this.merchantReference,
    required this.amount,
    required this.currency,
    required this.channel,
    required this.country,
    required this.customer,
    this.description,
    this.metadata,
    this.otp,
  })  : workflow = PaymentWorkflow.otp,
        successRedirectUrl = null,
        failedRedirectUrl = null;

  PaymentInitiateRequest.inApp({
    required this.merchantReference,
    required this.amount,
    required this.currency,
    required this.channel,
    required this.country,
    required this.customer,
    required this.successRedirectUrl,
    required this.failedRedirectUrl,
    this.description,
    this.metadata,
  })  : workflow = PaymentWorkflow.inApp,
        otp = null;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'merchantReference': merchantReference,
      'amount': amount,
      'currency': currency,
      'channel': channel,
      'country': country,
      'customer': customer.toJson(),
      'workflow': _wfToString(workflow),
      if (description != null) 'description': description,
      if (metadata != null) 'metadata': metadata,
    };

    if (workflow == PaymentWorkflow.otp) {
      json['otp'] = otp ?? '';
    } else {
      json['successRedirectUrl'] = successRedirectUrl;
      json['failedRedirectUrl'] = failedRedirectUrl;
    }

    // IMPORTANT:
    // callback_url (webhook) ne se met pas dans cette requête.
    // Il est configuré dans l’espace marchand via la configuration des Webhooks.
    return json;
  }
}

class PaymentInitiateResponse {
  final bool success;
  final String? transactionId;
  final String? reference;
  final String? merchantReference;
  final String? status;
  final num? amount;
  final String? currency;
  final String? environment;
  final String? partner;
  final String? partnerTransactionId;
  final List<dynamic>? validationData;
  final String? createdAt;

  PaymentInitiateResponse({
    required this.success,
    this.transactionId,
    this.reference,
    this.merchantReference,
    this.status,
    this.amount,
    this.currency,
    this.environment,
    this.partner,
    this.partnerTransactionId,
    this.validationData,
    this.createdAt,
  });

  factory PaymentInitiateResponse.fromJson(Map<String, dynamic> json) =>
      PaymentInitiateResponse(
        success: json['success'] == true,
        transactionId: json['transactionId'] as String?,
        reference: json['reference'] as String?,
        merchantReference: json['merchantReference'] as String?,
        status: json['status'] as String?,
        amount: json['amount'] as num?,
        currency: json['currency'] as String?,
        environment: json['environment'] as String?,
        partner: json['partner'] as String?,
        partnerTransactionId: json['partnerTransactionId'] as String?,
        validationData:
            (json['validationData'] as List?) ?? (json['validation_data'] as List?),
        createdAt: (json['createdAt'] as String?) ?? (json['created_at'] as String?),
      );
}
