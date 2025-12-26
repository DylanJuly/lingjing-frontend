import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/mock_service.dart';
import '../models/post.dart';

/// 发布帖子页面
class PublishPage extends StatefulWidget {
  const PublishPage({Key? key}) : super(key: key);

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final List<File> _selectedImages = [];
  final List<String> _selectedTags = [];
  bool _isPublic = true;
  bool _isPublishing = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  /// 选择图片
  Future<void> _pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(images.map((x) => File(x.path)));
      });
    }
  }

  /// 发布帖子
  /// TODO: 后端接口完成后，替换MockService调用
  Future<void> _publishPost() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入标题')),
      );
      return;
    }

    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入内容')),
      );
      return;
    }

    setState(() => _isPublishing = true);

    try {
      // TODO: 实际上传图片到服务器，获取图片URL
      final imageUrls = _selectedImages.map((e) => e.path).toList();

      final post = await MockService.publishPost(
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        images: imageUrls,
        tags: _selectedTags,
        isPublic: _isPublic,
      );

      if (mounted) {
        Navigator.pop(context, post);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('发布成功')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('发布失败: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isPublishing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('发布帖子'),
        actions: [
          TextButton(
            onPressed: _isPublishing ? null : _publishPost,
            child: _isPublishing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('发布'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题输入
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: '输入标题...',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // 正文编辑
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                hintText: '分享你的故事...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 10,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // 图片上传
            if (_selectedImages.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedImages.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: FileImage(_selectedImages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.close, size: 20),
                            onPressed: () {
                              setState(() {
                                _selectedImages.removeAt(index);
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),
            // 添加图片按钮
            OutlinedButton.icon(
              onPressed: _pickImages,
              icon: const Icon(Icons.add_photo_alternate),
              label: const Text('添加图片'),
            ),
            const SizedBox(height: 16),
            // 话题标签
            Wrap(
              spacing: 8,
              children: [
                ..._selectedTags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    onDeleted: () {
                      setState(() {
                        _selectedTags.remove(tag);
                      });
                    },
                  );
                }),
                ActionChip(
                  label: const Text('+ 添加标签'),
                  onPressed: () {
                    // TODO: 显示标签选择对话框
                    _showTagDialog();
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            // 发布设置
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('公开'),
                    subtitle: const Text('所有人可见'),
                    value: _isPublic,
                    onChanged: (value) {
                      setState(() => _isPublic = value);
                    },
                  ),
                  // TODO: 会员功能 - 定时发布
                  // ListTile(
                  //   title: const Text('定时发布'),
                  //   subtitle: const Text('设置未来某个时间点发布'),
                  //   trailing: const Icon(Icons.chevron_right),
                  //   onTap: () {
                  //     // TODO: 显示时间选择器
                  //   },
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // 预览按钮
            OutlinedButton(
              onPressed: () {
                // TODO: 显示预览对话框
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('预览功能待实现')),
                );
              },
              child: const Text('预览'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTagDialog() {
    final popularTags = [
      '#节气养生',
      '#我的命理故事',
      '#健康分享',
      '#饮食推荐',
    ];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('选择标签'),
        content: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: popularTags.map((tag) {
            final isSelected = _selectedTags.contains(tag);
            return FilterChip(
              label: Text(tag),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    _selectedTags.add(tag);
                  } else {
                    _selectedTags.remove(tag);
                  }
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}


