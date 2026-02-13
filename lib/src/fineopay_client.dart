import 'dart:convert';
import 'package:http/http.dart' as http;

import 'config.dart';
import 'src_exceptions.dart';

import 'endpoints/payments_api.dart';
import 'endpoints/transfers_api.dart';
import 'endpoints/transactions_api.dart';
import 'endpoints/references_api.dart';

class FineoPayClient {
  final FineoConfig config;
  final String apiKey;
  final http.Client _http;

  late final PaymentsApi payments;
  late final TransfersApi transfers;
  late final TransactionsApi transactions;
  late final ReferencesApi references;

  FineoPayClient({
    required this.config,
    required this.apiKey,
    http.Client? httpClient,
  }) : _http = httpClient ?? http.Client() {
    payments = PaymentsApi(this);
    transfers = TransfersApi(this);
    transactions = TransactionsApi(this);
    references = ReferencesApi(this);
  }

  Uri uri(String path, {Map<String, dynamic>? query}) {
    final cleanBase = config.baseUrl.endsWith('/')
        ? config.baseUrl.substring(0, config.baseUrl.length - 1)
        : config.baseUrl;

    final cleanPath = path.startsWith('/') ? path : '/$path';

    return Uri.parse('$cleanBase$cleanPath').replace(
      queryParameters: query
          ?.entries
          .where((e) => e.value != null && e.value.toString().trim().isNotEmpty)
          .map((e) => MapEntry(e.key, e.value.toString()))
          .fold<Map<String, String>>({}, (acc, e) {
        acc[e.key] = e.value;
        return acc;
      }),
    );
  }

  Map<String, String> _headers({Map<String, String>? extra}) {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-API-Key': apiKey,
      ...?extra,
    };
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    final res = await _http.get(uri(path, query: query), headers: _headers());
    return _decode(res);
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Object? body,
  }) async {
    final res = await _http.post(
      uri(path),
      headers: _headers(),
      body: body == null ? null : jsonEncode(body),
    );
    return _decode(res);
  }

  Map<String, dynamic> _decode(http.Response res) {
    final text = res.body;
    dynamic jsonBody;
    try {
      jsonBody = text.isNotEmpty ? jsonDecode(text) : {};
    } catch (_) {
      jsonBody = {'raw': text};
    }

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw FineoApiException(
        'HTTP ${res.statusCode} ${res.reasonPhrase ?? ''}'.trim(),
        statusCode: res.statusCode,
        data: jsonBody,
      );
    }

    if (jsonBody is Map<String, dynamic>) return jsonBody;
    return {'data': jsonBody};
  }

  void close() => _http.close();
}
