/// AI对话消息模型
class AIMessage {
  final String id;
  final bool isUser; // true=用户消息, false=AI消息
  final String content;
  final DateTime timestamp;
  final String? audioUrl; // 语音消息URL（如果有）

  AIMessage({
    required this.id,
    required this.isUser,
    required this.content,
    required this.timestamp,
    this.audioUrl,
  });

  factory AIMessage.fromJson(Map<String, dynamic> json) {
    return AIMessage(
      id: json['id'] as String,
      isUser: json['isUser'] as bool,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      audioUrl: json['audioUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isUser': isUser,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'audioUrl': audioUrl,
    };
  }
}

/// AI角色设定
enum AIDialogueStyle {
  warmEncouragement, // 温暖鼓励型
  professionalAnalysis, // 专业分析型
  // TODO: 后端可扩展更多风格
}

/// AI助手配置
class AIConfig {
  final String roleImage; // 角色形象图片
  final AIDialogueStyle dialogueStyle; // 对话风格
  final bool isMemberOnly; // 是否仅会员可用

  AIConfig({
    required this.roleImage,
    required this.dialogueStyle,
    this.isMemberOnly = false,
  });
}


