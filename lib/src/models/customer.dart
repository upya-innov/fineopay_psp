class Customer {
  final String phoneNumber;
  final String? email;
  final String? name;

  Customer({
    required this.phoneNumber,
    this.email,
    this.name,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      email: json['email']?.toString(),
      name: json['name']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'phoneNumber': phoneNumber,
    };

    if (email != null) data['email'] = email;
    if (name != null) data['name'] = name;

    return data;
  }
}
