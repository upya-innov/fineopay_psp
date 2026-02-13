import '../fineopay_client.dart';
import '../models/transfer_models.dart';

class TransfersApi {
  final FineoPayClient _client;
  TransfersApi(this._client);

  Future<Map<String, dynamic>> initiate(TransferInitiateRequest req) {
    return _client.post('/transfers/initiate', body: req.toJson());
  }

  Future<Map<String, dynamic>> list({
    int page = 1,
    int limit = 20,
    String? status,
  }) {
    return _client.get('/transfers', query: {
      'page': page,
      'limit': limit,
      if (status != null) 'status': status,
    });
  }

  Future<Map<String, dynamic>> status(String transferId) {
    return _client.get('/transfers/$transferId/status');
  }
}
