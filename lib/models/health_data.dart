/// 健康数据模型
class HealthData {
  final String id;
  final DateTime timestamp;
  final double? heartRate; // 心率
  final double? sleepHours; // 睡眠时长
  final int? steps; // 步数
  final double? bloodOxygen; // 血氧
  final double? bloodPressureSystolic; // 收缩压
  final double? bloodPressureDiastolic; // 舒张压
  final double? bloodSugar; // 血糖
  final String? constitutionType; // 体质类型
  final Map<String, dynamic>? additionalData; // 其他数据
  
  HealthData({
    required this.id,
    required this.timestamp,
    this.heartRate,
    this.sleepHours,
    this.steps,
    this.bloodOxygen,
    this.bloodPressureSystolic,
    this.bloodPressureDiastolic,
    this.bloodSugar,
    this.constitutionType,
    this.additionalData,
  });
  
  factory HealthData.fromJson(Map<String, dynamic> json) {
    return HealthData(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      heartRate: json['heartRate'] as double?,
      sleepHours: json['sleepHours'] as double?,
      steps: json['steps'] as int?,
      bloodOxygen: json['bloodOxygen'] as double?,
      bloodPressureSystolic: json['bloodPressureSystolic'] as double?,
      bloodPressureDiastolic: json['bloodPressureDiastolic'] as double?,
      bloodSugar: json['bloodSugar'] as double?,
      constitutionType: json['constitutionType'] as String?,
      additionalData: json['additionalData'] as Map<String, dynamic>?,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'heartRate': heartRate,
      'sleepHours': sleepHours,
      'steps': steps,
      'bloodOxygen': bloodOxygen,
      'bloodPressureSystolic': bloodPressureSystolic,
      'bloodPressureDiastolic': bloodPressureDiastolic,
      'bloodSugar': bloodSugar,
      'constitutionType': constitutionType,
      'additionalData': additionalData,
    };
  }
}




