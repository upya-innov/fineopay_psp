class PaymentInitiateRequest {
  final String merchantReference;
  final num amount;
  final String currency;
  final String channel;
  final String country;
  final Customer customer;
  final String? description;
  final Map<String, dynamic>? metadata;

  final String workflow; // "otp" | "in_app"
  final String? otp;

  final String? successRedirectUrl;
  final String? failedRedirectUrl;

  PaymentInitiateRequest({
    required this.merchantReference,
    required this.amount,
    required this.currency,
    required this.channel,
    required this.country,
    required this.customer,
    this.description,
    this.metadata,
    required this.workflow,
    this.otp,
    this.successRedirectUrl,
    this.failedRedirectUrl,
  });

  factory PaymentInitiateRequest.otp({
    required String merchantReference,
    required num amount,
    required String currency,
    required String channel,
    required String country,
    required Customer customer,
    String? description,
    Map<String, dynamic>? metadata,
    String? otp,
  }) {
    return PaymentInitiateRequest(
      merchantReference: merchantReference,
      amount: amount,
      currency: currency,
      channel: channel,
      country: country,
      customer: customer,
      description: description,
      metadata: metadata,
      workflow: 'otp',
      otp: otp ?? '',
    );
  }

  factory PaymentInitiateRequest.inApp({
    required String merchantReference,
    required num amount,
    required String currency,
    required String channel,
    required String country,
    required Customer customer,
    required String successRedirectUrl,
    required String failedRedirectUrl,
    String? description,
    Map<String, dynamic>? metadata,
  }) {
    return PaymentInitiateRequest(
      merchantReference: merchantReference,
      amount: amount,
      currency: currency,
      channel: channel,
      country: country,
      customer: customer,
      description: description,
      metadata: metadata,
      workflow: 'in_app',
      successRedirectUrl: successRedirectUrl,
      failedRedirectUrl: failedRedirectUrl,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'merchantReference': merchantReference,
      'amount': amount,
      'currency': currency,
      'channel': channel,
      'country': country,
      'customer': customer.toJson(),
      'workflow': workflow,
    };

    if (description != null) data['description'] = description;
    if (metadata != null) data['metadata'] = metadata;

    if (workflow == 'otp') {
      data['otp'] = otp ?? '';
    }

    if (workflow == 'in_app') {
      if (successRedirectUrl != null) data['successRedirectUrl'] = successRedirectUrl;
      if (failedRedirectUrl != null) data['failedRedirectUrl'] = failedRedirectUrl;
    }

    // ⚠️ callback_url ne se met PAS ici (webhook configuré côté dashboard)
    return data;
  }
}
