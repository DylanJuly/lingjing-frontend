/// 会员套餐模型
class MembershipPackage {
  final String id;
  final String name; // 月度、季度、年度
  final int durationDays; // 持续天数
  final double price; // 价格
  final double? originalPrice; // 原价（如果有折扣）
  final bool isPopular; // 是否推荐套餐

  MembershipPackage({
    required this.id,
    required this.name,
    required this.durationDays,
    required this.price,
    this.originalPrice,
    this.isPopular = false,
  });

  factory MembershipPackage.fromJson(Map<String, dynamic> json) {
    return MembershipPackage(
      id: json['id'] as String,
      name: json['name'] as String,
      durationDays: json['durationDays'] as int,
      price: (json['price'] as num).toDouble(),
      originalPrice: json['originalPrice'] != null
          ? (json['originalPrice'] as num).toDouble()
          : null,
      isPopular: json['isPopular'] as bool? ?? false,
    );
  }
}

/// 会员状态
class MembershipStatus {
  final bool isMember; // 是否是会员
  final String? memberType; // 会员类型
  final DateTime? expireDate; // 到期时间
  final bool autoRenewal; // 是否自动续费

  MembershipStatus({
    this.isMember = false,
    this.memberType,
    this.expireDate,
    this.autoRenewal = false,
  });

  factory MembershipStatus.fromJson(Map<String, dynamic> json) {
    return MembershipStatus(
      isMember: json['isMember'] as bool? ?? false,
      memberType: json['memberType'] as String?,
      expireDate: json['expireDate'] != null
          ? DateTime.parse(json['expireDate'] as String)
          : null,
      autoRenewal: json['autoRenewal'] as bool? ?? false,
    );
  }
}

/// 会员权益对比
class MembershipBenefit {
  final String feature; // 功能名称
  final bool freeUser; // 免费用户是否有
  final bool memberUser; // 会员用户是否有

  MembershipBenefit({
    required this.feature,
    required this.freeUser,
    required this.memberUser,
  });
}


