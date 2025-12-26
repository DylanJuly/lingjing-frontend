/// 用户档案模型
class UserProfile {
  final String id;
  final String name;
  final DateTime? birthDate;
  final String? birthTime;
  final String? birthLocation;
  
  // 健康相关
  final String? constitutionType; // 体质类型
  final Map<String, dynamic>? healthMetrics; // 健康指标
  
  // 命理相关
  final Map<String, dynamic>? fortuneData; // 运势数据
  
  UserProfile({
    required this.id,
    required this.name,
    this.birthDate,
    this.birthTime,
    this.birthLocation,
    this.constitutionType,
    this.healthMetrics,
    this.fortuneData,
  });
  
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      birthDate: json['birthDate'] != null 
          ? DateTime.parse(json['birthDate'] as String) 
          : null,
      birthTime: json['birthTime'] as String?,
      birthLocation: json['birthLocation'] as String?,
      constitutionType: json['constitutionType'] as String?,
      healthMetrics: json['healthMetrics'] as Map<String, dynamic>?,
      fortuneData: json['fortuneData'] as Map<String, dynamic>?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'birthDate': birthDate?.toIso8601String(),
      'birthTime': birthTime,
      'birthLocation': birthLocation,
      'constitutionType': constitutionType,
      'healthMetrics': healthMetrics,
      'fortuneData': fortuneData,
    };
  }
}




