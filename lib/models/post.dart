/// 社区帖子模型
class Post {
  final String id;
  final String authorId;
  final String authorName;
  final String authorAvatar;
  final String title;
  final String content;
  final List<String> images; // 图片URL列表
  final List<String> videos; // 视频URL列表
  final List<String> tags; // 话题标签
  final int likes;
  final int comments;
  final int shares;
  final bool isLiked;
  final DateTime publishTime;
  final bool isPublic; // 是否公开
  final String? scheduledTime; // 定时发布时间（会员功能）

  Post({
    required this.id,
    required this.authorId,
    required this.authorName,
    required this.authorAvatar,
    required this.title,
    required this.content,
    this.images = const [],
    this.videos = const [],
    this.tags = const [],
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.isLiked = false,
    required this.publishTime,
    this.isPublic = true,
    this.scheduledTime,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String,
      authorAvatar: json['authorAvatar'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      images: List<String>.from(json['images'] as List? ?? []),
      videos: List<String>.from(json['videos'] as List? ?? []),
      tags: List<String>.from(json['tags'] as List? ?? []),
      likes: json['likes'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
      shares: json['shares'] as int? ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
      publishTime: DateTime.parse(json['publishTime'] as String),
      isPublic: json['isPublic'] as bool? ?? true,
      scheduledTime: json['scheduledTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorId': authorId,
      'authorName': authorName,
      'authorAvatar': authorAvatar,
      'title': title,
      'content': content,
      'images': images,
      'videos': videos,
      'tags': tags,
      'likes': likes,
      'comments': comments,
      'shares': shares,
      'isLiked': isLiked,
      'publishTime': publishTime.toIso8601String(),
      'isPublic': isPublic,
      'scheduledTime': scheduledTime,
    };
  }
}


