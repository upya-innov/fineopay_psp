class Recipient {
  final String phoneNumber;
  final String? name;

  Recipient({
    required this.phoneNumber,
    this.name,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) {
    return Recipient(
      phoneNumber: (json['phoneNumber'] ?? '').toString(),
      name: json['name']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'phoneNumber': phoneNumber,
    };
    if (name != null) data['name'] = name;
    return data;
  }
}
