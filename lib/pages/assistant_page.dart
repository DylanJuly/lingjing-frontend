import 'package:flutter/material.dart';
import '../models/post.dart';
import '../models/ai_message.dart';
import '../services/mock_service.dart';
import 'post_detail_page.dart';
import 'ai_chat_page.dart';

/// 灵境智能助手页面 - 包含社区帖子流和AI对话
class AssistantPage extends StatefulWidget {
  const AssistantPage({Key? key}) : super(key: key);

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Post> _posts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadPosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// TODO: 后端接口完成后，替换MockService调用
  Future<void> _loadPosts() async {
    setState(() => _isLoading = true);
    try {
      final posts = await MockService.getPosts();
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('灵境智能助手'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '社区', icon: Icon(Icons.people)),
            Tab(text: 'AI对话', icon: Icon(Icons.chat)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 社区帖子流
          _buildCommunityFeed(),
          // AI对话
          const AIChatPage(),
        ],
      ),
    );
  }

  /// 社区帖子流
  Widget _buildCommunityFeed() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_posts.isEmpty) {
      return const Center(child: Text('暂无帖子'));
    }

    return RefreshIndicator(
      onRefresh: _loadPosts,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return _buildPostCard(_posts[index]);
        },
      ),
    );
  }

  /// 帖子卡片
  Widget _buildPostCard(Post post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PostDetailPage(post: post),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 作者信息
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
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
              const SizedBox(height: 12),
              // 标题
              Text(
                post.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // 内容
              Text(
                post.content,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              // 图片
              if (post.images.isNotEmpty) ...[
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: post.images.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 200,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                        child: const Icon(Icons.image, size: 50),
                      );
                    },
                  ),
                ),
              ],
              // 标签
              if (post.tags.isNotEmpty) ...[
                const SizedBox(height: 12),
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
              const SizedBox(height: 12),
              // 互动按钮
              Row(
                children: [
                  _buildActionButton(
                    icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                    label: '${post.likes}',
                    color: post.isLiked ? Colors.red : Colors.grey,
                    onTap: () {
                      // TODO: 调用点赞接口
                    },
                  ),
                  const SizedBox(width: 24),
                  _buildActionButton(
                    icon: Icons.comment,
                    label: '${post.comments}',
                    onTap: () {
                      // TODO: 跳转到评论页面
                    },
                  ),
                  const SizedBox(width: 24),
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
      child: Row(
        children: [
          Icon(icon, color: color ?? Colors.grey, size: 20),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: color ?? Colors.grey, fontSize: 14),
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


