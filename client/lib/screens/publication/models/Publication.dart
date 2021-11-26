class PublicationModel {
  final int publicationId;
  final int userId;
  final List likes;
  final List comments;
  final String description;
  final String src;
  final String login;
  final String avatar;
  final bool isLiked;

  PublicationModel({
    required this.publicationId,
    required this.userId,
    required this.likes,
    required this.comments,
    required this.description,
    required this.src,
    required this.login,
    required this.avatar,
    required this.isLiked,
  });

  factory PublicationModel.fromJson(Map<String, dynamic> json) {
    return PublicationModel(
      publicationId: json['publicationId'],
      userId: json['userId'],
      likes: json['likes'],
      comments: json['comments'],
      description: json['description'],
      login: json['login'],
      src: json['src'],
      avatar: json['avatar'],
      isLiked: json['isLiked'],
    );
  }
}
