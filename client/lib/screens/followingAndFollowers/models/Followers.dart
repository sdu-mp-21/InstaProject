class FollowersModel {
  final List followers;
  final List following;

  FollowersModel({required this.followers, required this.following});

  factory FollowersModel.fromJson(Map<String, dynamic> json) {
    return FollowersModel(
      followers: json['followers'],
      following: json['following'],
    );
  }
}
