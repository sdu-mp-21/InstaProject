class User {
  final int userId;
  final String login;
  final String name;
  final String surname;
  final String site;
  final String phoneNumber;
  final String email;
  final String aboutMe;
  final String avatar;
  final List publications;
  final List subscriptions;
  final List subscribers;

  User(
      {required this.name,
        required this.surname,
        required this.site,
        required this.phoneNumber,
        required this.email,
        required this.aboutMe,
        required this.avatar,
        required this.userId,
        required this.login,
        required this.publications,
        required this.subscriptions,
        required this.subscribers});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      surname: json['surname'],
      site: json['site'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      aboutMe: json['aboutMe'],
      avatar: json['avatar'],
      login: json['login'],
      publications: json['publications'],
      subscriptions: json['subscriptions'],
      subscribers: json['subscribers'],
    );
  }
}
