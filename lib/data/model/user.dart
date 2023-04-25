class User {
  int id;
  String username;
  String email;
  String phone;

  User(this.id, this.username, this.email, this.phone);

  User.fromJson(Map json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        phone = json['phone'];

  Map toJson() {
    return {'id': id, 'name': username, 'email': email, 'phone': phone};
  }
}
