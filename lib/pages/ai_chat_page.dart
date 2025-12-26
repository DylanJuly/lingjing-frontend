import 'package:flutter/material.dart';
import '../models/ai_message.dart';
import '../services/mock_service.dart';

/// AI对话页面
class AIChatPage extends StatefulWidget {
  const AIChatPage({Key? key}) : super(key: key);

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<AIMessage> _messages = [];
  bool _isLoading = false;
  AIDialogueStyle _currentStyle = AIDialogueStyle.warmEncouragement;

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// TODO: 后端接口完成后，替换MockService调用
  Future<void> _loadChatHistory() async {
    setState(() => _isLoading = true);
    try {
      final messages = await MockService.getChatHistory();
      setState(() {
        _messages = messages;
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  /// TODO: 后端接口完成后，替换MockService调用
  Future<void> _sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    // 添加用户消息
    final userMessage = AIMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      isUser: true,
      content: content,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
    });
    _textController.clear();
    _scrollToBottom();

    // 发送到服务器并获取AI回复
    setState(() => _isLoading = true);
    try {
      final aiMessage = await MockService.sendAIMessage(content);
      setState(() {
        _messages.add(aiMessage);
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('发送失败: $e')),
      );
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AI角色形象和风格切换（会员功能）
        _buildAIHeader(),
        
        // 消息列表
        Expanded(
          child: _isLoading && _messages.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : _messages.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        return _buildMessageBubble(_messages[index]);
                      },
                    ),
        ),

        // 快捷提问按钮
        _buildQuickQuestions(),

        // 输入框
        _buildInputArea(),
      ],
    );
  }

  /// AI头部（角色形象和风格切换）
  Widget _buildAIHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 角色形象
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.purple[100],
            child: const Icon(Icons.smart_toy, color: Colors.purple),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '灵境AI助手',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _getStyleName(_currentStyle),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // 风格切换（会员功能）
          PopupMenuButton<AIDialogueStyle>(
            icon: const Icon(Icons.settings),
            onSelected: (style) {
              // TODO: 检查会员权限
              setState(() => _currentStyle = style);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: AIDialogueStyle.warmEncouragement,
                child: Text('温暖鼓励型'),
              ),
              const PopupMenuItem(
                value: AIDialogueStyle.professionalAnalysis,
                child: Text('专业分析型'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getStyleName(AIDialogueStyle style) {
    switch (style) {
      case AIDialogueStyle.warmEncouragement:
        return '温暖鼓励型';
      case AIDialogueStyle.professionalAnalysis:
        return '专业分析型';
    }
  }

  /// 空状态
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            '开始与AI助手对话吧',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  /// 消息气泡
  Widget _buildMessageBubble(AIMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isUser ? const Color(0xFF6B46C1) : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message.content,
          style: TextStyle(
            color: message.isUser ? Colors.white : Colors.black87,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  /// 快捷提问按钮
  Widget _buildQuickQuestions() {
    final quickQuestions = [
      '今日运势',
      '我感觉焦虑怎么办',
      '健康建议',
    ];

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: quickQuestions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: OutlinedButton(
              onPressed: () {
                _sendMessage(quickQuestions[index]);
              },
              child: Text(quickQuestions[index]),
            ),
          );
        },
      ),
    );
  }

  /// 输入区域
  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 语音输入按钮
          IconButton(
            icon: const Icon(Icons.mic),
            onPressed: () {
              // TODO: 实现语音输入功能
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('语音输入功能待实现')),
              );
            },
          ),
          // 文本输入框
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: '输入消息...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
              onSubmitted: _sendMessage,
            ),
          ),
          const SizedBox(width: 8),
          // 发送按钮
          IconButton(
            icon: const Icon(Icons.send),
            color: const Color(0xFF6B46C1),
            onPressed: () {
              _sendMessage(_textController.text);
            },
          ),
        ],
      ),
    );
  }
}


