# FineoPay PSP SDK (Flutter / Dart)

SDK officiel (non-UI) pour intégrer FineoPay PSP dans une application Flutter :
- Payments (OTP & IN_APP)
- Transfers
- Transactions
- References (Countries / Channels / Currencies)

> Authentification : `X-API-Key` (API Key FineoPay)

---

## Installation

### 1) Ajouter la dépendance

Dans `pubspec.yaml` :

```yaml
dependencies:
  fineopay_psp:
    git:
      url: https://github.com/upya-innov/fineopay_psp.git
      ref: v1.0.0

Puis :

flutter pub get


Initialisation

import 'package:fineopay_psp/fineopay_psp.dart';

final client = FineoPayClient(
  config: FineoConfig.sandbox(), // ou FineoConfig.live()
  apiKey: 'psp_key_xxxxxxxxxxxxxxxxxxxxxxxx',
);



Payments
A) Initier un paiement - Workflow OTP
final res = await client.payments.initiate(
  PaymentInitiateRequest.otp(
    merchantReference: 'order-${DateTime.now().millisecondsSinceEpoch}',
    amount: 2000,
    currency: 'XOF',
    channel: 'orange_money',
    country: 'CI',
    customer: Customer(
      phoneNumber: '+2250700000000',
      email: 'customer@example.com',
      name: 'John Doe',
    ),
    description: 'Payment for order #123',
    metadata: {'orderId': '123'},
    otp: '', // selon votre process (initiation / soumission OTP)
  ),
);

print(res.reference);
print(res.status);



B) Initier un paiement - Workflow IN_APP

final res = await client.payments.initiate(
  PaymentInitiateRequest.inApp(
    merchantReference: 'order-${DateTime.now().millisecondsSinceEpoch}',
    amount: 2000,
    currency: 'XOF',
    channel: 'orange_money',
    country: 'CI',
    customer: Customer(
      phoneNumber: '+2250700000000',
      email: 'customer@example.com',
      name: 'John Doe',
    ),
    description: 'Payment for order #123',
    metadata: {'orderId': '123'},
    successRedirectUrl: 'https://example.com',
    failedRedirectUrl: 'https://example.com',
  ),
);

print(res.validationData); // souvent un lien / instructions de validation


Transfers
Initier un transfert

final res = await client.transfers.initiate(
  TransferInitiateRequest(
    transferId: 'transfer-${DateTime.now().millisecondsSinceEpoch}',
    amount: 1500,
    currency: 'XOF',
    channel: 'orange_money',
    country: 'CI',
    recipient: Recipient(phoneNumber: '+2250759023333'),
    description: 'Payout to supplier',
    metadata: {},
  ),
);

print(res);


Liste des transferts

final list = await client.transfers.list(page: 1, limit: 20);
print(list);


Statut d’un transfert

final status = await client.transfers.status('TRF-123');
print(status);


Transactions
Lister
final tx = await client.transactions.list(
  page: 1,
  limit: 20,
  status: 'completed',
  transactionType: 'payment', // ou 'transfer'
);
print(tx);

Détail
final one = await client.transactions.getById('TX-123');
print(one);

Références

final countries = await client.references.countries();
final channels = await client.references.channels();
final currencies = await client.references.currencies();


Gestion des erreurs
try {
  final res = await client.payments.list();
} on FineoApiException catch (e) {
  print('Erreur API: ${e.statusCode} ${e.message}');
  print('Payload: ${e.data}');
}
