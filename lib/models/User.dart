class User {
  final String id;
  final String username;
  final String email;
  final String phone;
  final String address;
  
  User({this.id,
  this.username,
  this.email,
  this.phone,
  this.address
});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id:json['Id'],
      username:json['UserName'],
      email:json['Email'],
      phone:json['PhoneNumber'],
      address:json['Address'],
    );
  }
}