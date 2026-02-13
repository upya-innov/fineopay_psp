import '../fineopay_client.dart';

class TransactionsApi {
  final FineoPayClient _client;
  TransactionsApi(this._client);

  Future<Map<String, dynamic>> list({
    int page = 1,
    int limit = 20,
    String? status,
    String? transactionType,
  }) {
    return _client.get('/transactions', query: {
      'page': page,
      'limit': limit,
      if (status != null) 'status': status,
      if (transactionType != null) 'transactionType': transactionType,
    });
  }

  Future<Map<String, dynamic>> getById(String transactionId) {
    return _client.get('/transactions/$transactionId');
  }
}
