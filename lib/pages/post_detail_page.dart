import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/mock_service.dart';

/// 帖子详情页面
class PostDetailPage extends StatefulWidget {
  final Post post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  Post? _post;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPostDetail();
  }

  /// TODO: 后端接口完成后，替换MockService调用
  Future<void> _loadPostDetail() async {
    setState(() => _isLoading = true);
    try {
      final post = await MockService.getPostDetail(widget.post.id);
      setState(() {
        _post = post;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final post = _post ?? widget.post;

    return Scaffold(
      appBar: AppBar(
        title: const Text('帖子详情'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 作者信息
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(post.authorAvatar),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.authorName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              _formatTime(post.publishTime),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // 标题
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // 内容
                  Text(
                    post.content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                  // 图片
                  if (post.images.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    ...post.images.map((image) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                        child: const Icon(Icons.image, size: 50),
                      );
                    }),
                  ],
                  // 标签
                  if (post.tags.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      children: post.tags.map((tag) {
                        return Chip(
                          label: Text(tag),
                          backgroundColor: Colors.purple[50],
                          labelStyle: TextStyle(color: Colors.purple[700]),
                        );
                      }).toList(),
                    ),
                  ],
                  const SizedBox(height: 24),
                  // 互动按钮
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton(
                        icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                        label: '${post.likes}',
                        color: post.isLiked ? Colors.red : Colors.grey,
                        onTap: () {
                          // TODO: 调用点赞接口
                        },
                      ),
                      _buildActionButton(
                        icon: Icons.comment,
                        label: '${post.comments}',
                        onTap: () {
                          // TODO: 显示评论列表
                        },
                      ),
                      _buildActionButton(
                        icon: Icons.share,
                        label: '${post.shares}',
                        onTap: () {
                          // TODO: 调用分享接口
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    Color? color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color ?? Colors.grey, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: color ?? Colors.grey),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }
}


