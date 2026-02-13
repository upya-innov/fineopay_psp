class Customer {
  final String phoneNumber; // E.164 e.g. +2250700000000
  final String? email;
  final String? name;

  Customer({
    required this.phoneNumber,
    this.email,
    this.name,
  });

  Map<String, dynamic> toJson() => {
        'phoneNumber': phoneNumber,
        if (email != null) 'email': email,
        if (name != null) 'name': name,
      };
}
