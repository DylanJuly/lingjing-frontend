/// 节气/节日模型
class SolarTerm {
  final String id;
  final String name; // 节气/节日名称
  final DateTime date; // 日期
  final String backgroundImage; // 背景图URL
  final String description; // 描述
  final String lunarDate; // 农历日期
  final String? healthAdvice; // 养生建议

  SolarTerm({
    required this.id,
    required this.name,
    required this.date,
    required this.backgroundImage,
    required this.description,
    required this.lunarDate,
    this.healthAdvice,
  });

  factory SolarTerm.fromJson(Map<String, dynamic> json) {
    return SolarTerm(
      id: json['id'] as String,
      name: json['name'] as String,
      date: DateTime.parse(json['date'] as String),
      backgroundImage: json['backgroundImage'] as String,
      description: json['description'] as String,
      lunarDate: json['lunarDate'] as String,
      healthAdvice: json['healthAdvice'] as String?,
    );
  }
}

/// 今日行事准则
class DailyGuidelines {
  final List<String> doList; // 宜做事项
  final List<String> dontList; // 忌做事项
  final String fortuneSummary; // 运势总结

  DailyGuidelines({
    required this.doList,
    required this.dontList,
    required this.fortuneSummary,
  });

  factory DailyGuidelines.fromJson(Map<String, dynamic> json) {
    return DailyGuidelines(
      doList: List<String>.from(json['doList'] as List),
      dontList: List<String>.from(json['dontList'] as List),
      fortuneSummary: json['fortuneSummary'] as String,
    );
  }
}

/// 运势能量分布
class FortuneEnergy {
  final int career; // 事业
  final int health; // 健康
  final int wealth; // 财运
  final int emotion; // 感情

  FortuneEnergy({
    required this.career,
    required this.health,
    required this.wealth,
    required this.emotion,
  });

  factory FortuneEnergy.fromJson(Map<String, dynamic> json) {
    return FortuneEnergy(
      career: json['career'] as int,
      health: json['health'] as int,
      wealth: json['wealth'] as int,
      emotion: json['emotion'] as int,
    );
  }
}


