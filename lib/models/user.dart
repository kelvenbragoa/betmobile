class User {
  int id;
  String name;
  String username;
  String email;
  String role;



  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.role,

  });


  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      username: json['user']['username'],
      email: json['user']['email'],
      role: json['user']['role'],
    );
  }
}