/// 命理分析结果模型
class FortuneAnalysis {
  final String id;
  final DateTime analysisDate;
  final String analysisType; // 面相、手相、八字、综合
  final Map<String, dynamic> faceAnalysis; // 面相分析结果
  final Map<String, dynamic> palmAnalysis; // 手相分析结果
  final Map<String, dynamic> baziAnalysis; // 八字分析结果
  final Map<String, int> fortuneScores; // 各项运势分数
  final String summary; // 综合分析总结
  final List<String> suggestions; // 建议列表
  
  FortuneAnalysis({
    required this.id,
    required this.analysisDate,
    required this.analysisType,
    required this.faceAnalysis,
    required this.palmAnalysis,
    required this.baziAnalysis,
    required this.fortuneScores,
    required this.summary,
    required this.suggestions,
  });
  
  factory FortuneAnalysis.fromJson(Map<String, dynamic> json) {
    return FortuneAnalysis(
      id: json['id'] as String,
      analysisDate: DateTime.parse(json['analysisDate'] as String),
      analysisType: json['analysisType'] as String,
      faceAnalysis: Map<String, dynamic>.from(json['faceAnalysis'] as Map),
      palmAnalysis: Map<String, dynamic>.from(json['palmAnalysis'] as Map),
      baziAnalysis: Map<String, dynamic>.from(json['baziAnalysis'] as Map),
      fortuneScores: Map<String, int>.from(
        (json['fortuneScores'] as Map).map(
          (key, value) => MapEntry(key as String, value as int),
        ),
      ),
      summary: json['summary'] as String,
      suggestions: List<String>.from(json['suggestions'] as List),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'analysisDate': analysisDate.toIso8601String(),
      'analysisType': analysisType,
      'faceAnalysis': faceAnalysis,
      'palmAnalysis': palmAnalysis,
      'baziAnalysis': baziAnalysis,
      'fortuneScores': fortuneScores,
      'summary': summary,
      'suggestions': suggestions,
    };
  }
}




