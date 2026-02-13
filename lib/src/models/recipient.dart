class Recipient {
  final String phoneNumber; // E.164
  final String? name;

  Recipient({
    required this.phoneNumber,
    this.name,
  });

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        if (name != null) 'name': name,
      };
}
