import '../fineopay_client.dart';

class ReferencesApi {
  final FineoPayClient _client;
  ReferencesApi(this._client);

  Future<Map<String, dynamic>> countries() => _client.get('/countries');
  Future<Map<String, dynamic>> channels() => _client.get('/channels');
  Future<Map<String, dynamic>> currencies() => _client.get('/currencies');
}
