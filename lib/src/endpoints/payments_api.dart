import '../fineopay_client.dart';
import '../models/payment_models.dart';

class PaymentsApi {
  final FineoPayClient _client;
  PaymentsApi(this._client);

  Future<PaymentInitiateResponse> initiate(PaymentInitiateRequest req) async {
    final json = await _client.post('/payments/initiate', body: req.toJson());
    return PaymentInitiateResponse.fromJson(json);
  }

  Future<Map<String, dynamic>> list({
    int page = 1,
    int limit = 20,
    String? status,
  }) {
    return _client.get('/payments', query: {
      'page': page,
      'limit': limit,
      if (status != null) 'status': status,
    });
  }

  Future<Map<String, dynamic>> status(String transactionId) {
    return _client.get('/payments/$transactionId/status');
  }
  Future<Map<String, dynamic>> validateOtpNoAuth(String validationUrl) {
  return _client.postAbsoluteNoAuth(validationUrl);
}

}
