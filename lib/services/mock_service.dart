import '../models/post.dart';
import '../models/ai_message.dart';
import '../models/membership.dart';
import '../models/solar_term.dart';
import '../models/recipe.dart';
import '../models/health_data.dart';
import '../models/fortune_analysis.dart';

/// Mock数据服务
/// TODO: 后端开发完成后，替换为真实API调用
class MockService {
  // ==================== 首页相关 ====================
  
  /// TODO: 获取当日节气/节日信息
  /// 接口: GET /api/solar-term/today
  static Future<SolarTerm> getTodaySolarTerm() async {
    await Future.delayed(const Duration(milliseconds: 500)); // 模拟网络延迟
    return SolarTerm(
      id: '1',
      name: '立春',
      date: DateTime.now(),
      backgroundImage: 'https://picsum.photos/400/200?random=1',
      description: '立春是二十四节气中的第一个节气，标志着春天的开始。',
      lunarDate: '甲辰年正月初一',
      healthAdvice: '立春时节，宜早睡早起，多食新鲜蔬菜，保持心情愉悦。',
    );
  }

  /// TODO: 获取今日行事准则
  /// 接口: GET /api/guidelines/today
  static Future<DailyGuidelines> getTodayGuidelines() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return DailyGuidelines(
      doList: ['适宜重要决策', '进行运动锻炼', '与朋友交流'],
      dontList: ['避免熬夜', '不宜冲动消费', '避免争吵'],
      fortuneSummary: '今日整体运势平稳，适合规划未来，注意情绪管理。',
    );
  }

  /// TODO: 获取今日运势能量分布
  /// 接口: GET /api/fortune/energy/today
  static Future<FortuneEnergy> getTodayFortuneEnergy() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return FortuneEnergy(
      career: 85,
      health: 78,
      wealth: 92,
      emotion: 80,
    );
  }

  /// TODO: 获取今日推荐食谱
  /// 接口: GET /api/recipes/recommended/today
  static Future<List<Recipe>> getTodayRecipes() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Recipe(
        id: '1',
        name: '红枣枸杞粥',
        description: '适合平和质人群，具有滋阴润燥的功效',
        imageUrl: 'https://picsum.photos/400/300?random=1',
        ingredients: ['红枣', '枸杞', '大米', '冰糖'],
        cookingSteps: '1. 将大米洗净，红枣去核\n2. 加水煮至米粒开花\n3. 加入枸杞和冰糖，煮5分钟即可',
        nutrition: {'calories': 280.0, 'protein': 8.0, 'carbs': 60.0},
        tags: ['药食同源', '温补'],
        mealType: '早餐',
        cookingTime: 30,
        difficulty: 2,
      ),
    ];
  }

  // ==================== 社区帖子相关 ====================
  
  /// TODO: 获取社区帖子列表
  /// 接口: GET /api/posts?page=1&limit=20
  static Future<List<Post>> getPosts({int page = 1, int limit = 20}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return List.generate(10, (index) {
      return Post(
        id: 'post_$index',
        authorId: 'user_$index',
        authorName: '用户${index + 1}',
        authorAvatar: 'https://i.pravatar.cc/150?img=${index + 1}',
        title: '我的命理故事 #${index + 1}',
        content: '这是第${index + 1}个帖子的内容...',
        images: index % 2 == 0 ? ['https://picsum.photos/400/300?random=$index'] : [],
        tags: ['#节气养生', '#我的命理故事'],
        likes: 100 + index * 10,
        comments: 20 + index,
        shares: 5 + index,
        isLiked: index % 3 == 0,
        publishTime: DateTime.now().subtract(Duration(hours: index)),
        isPublic: true,
      );
    });
  }

  /// TODO: 获取帖子详情
  /// 接口: GET /api/posts/:id
  static Future<Post> getPostDetail(String postId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Post(
      id: postId,
      authorId: 'user_1',
      authorName: '用户1',
      authorAvatar: 'https://i.pravatar.cc/150?img=1',
      title: '我的命理故事',
      content: '这是帖子的详细内容...',
      images: ['https://picsum.photos/400/300?random=1'],
      tags: ['#节气养生'],
      likes: 100,
      comments: 20,
      shares: 5,
      isLiked: false,
      publishTime: DateTime.now(),
      isPublic: true,
    );
  }

  /// TODO: 发布帖子
  /// 接口: POST /api/posts
  static Future<Post> publishPost({
    required String title,
    required String content,
    required List<String> images,
    required List<String> tags,
    bool isPublic = true,
    String? scheduledTime,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // TODO: 实际应该返回服务器创建的帖子
    return Post(
      id: 'new_post_${DateTime.now().millisecondsSinceEpoch}',
      authorId: 'current_user',
      authorName: '当前用户',
      authorAvatar: 'https://i.pravatar.cc/150?img=1',
      title: title,
      content: content,
      images: images,
      tags: tags,
      likes: 0,
      comments: 0,
      shares: 0,
      isLiked: false,
      publishTime: DateTime.now(),
      isPublic: isPublic,
      scheduledTime: scheduledTime,
    );
  }

  // ==================== AI对话相关 ====================
  
  /// TODO: 获取AI对话历史
  /// 接口: GET /api/ai/chat/history
  static Future<List<AIMessage>> getChatHistory() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      AIMessage(
        id: '1',
        isUser: true,
        content: '今日运势如何？',
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      AIMessage(
        id: '2',
        isUser: false,
        content: '根据您的命理分析，今日整体运势平稳，事业运较佳，适合重要决策。',
        timestamp: DateTime.now().subtract(const Duration(minutes: 9)),
      ),
    ];
  }

  /// TODO: 发送AI消息
  /// 接口: POST /api/ai/chat/send
  static Future<AIMessage> sendAIMessage(String content) async {
    await Future.delayed(const Duration(milliseconds: 1500)); // 模拟AI响应时间
    return AIMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      isUser: false,
      content: '这是AI的回复：$content',
      timestamp: DateTime.now(),
    );
  }

  // ==================== 会员相关 ====================
  
  /// TODO: 获取会员套餐列表
  /// 接口: GET /api/membership/packages
  static Future<List<MembershipPackage>> getMembershipPackages() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      MembershipPackage(
        id: '1',
        name: '月度会员',
        durationDays: 30,
        price: 29.9,
        originalPrice: 39.9,
        isPopular: false,
      ),
      MembershipPackage(
        id: '2',
        name: '季度会员',
        durationDays: 90,
        price: 79.9,
        originalPrice: 119.7,
        isPopular: true,
      ),
      MembershipPackage(
        id: '3',
        name: '年度会员',
        durationDays: 365,
        price: 299.9,
        originalPrice: 478.8,
        isPopular: false,
      ),
    ];
  }

  /// TODO: 获取当前会员状态
  /// 接口: GET /api/membership/status
  static Future<MembershipStatus> getMembershipStatus() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MembershipStatus(
      isMember: false,
      memberType: null,
      expireDate: null,
      autoRenewal: false,
    );
  }

  /// TODO: 购买会员
  /// 接口: POST /api/membership/purchase
  static Future<bool> purchaseMembership({
    required String packageId,
    required String paymentMethod, // wechat, alipay
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // 模拟支付流程
    // TODO: 实际应该调用支付接口
    return true;
  }

  // ==================== 搜索相关 ====================
  
  /// TODO: 全局搜索
  /// 接口: GET /api/search?keyword=xxx&type=all
  static Future<Map<String, dynamic>> search(String keyword) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return {
      'posts': [],
      'recipes': [],
      'healthKnowledge': [],
    };
  }

  // ==================== 命理分析相关 ====================
  
  /// TODO: 上传面相/手相图片进行分析
  /// 接口: POST /api/fortune/analyze/face
  /// 接口: POST /api/fortune/analyze/palm
  static Future<FortuneAnalysis> analyzeImage({
    required String imagePath,
    required String type, // face, palm
  }) async {
    await Future.delayed(const Duration(seconds: 3)); // 模拟AI分析时间
    // TODO: 实际上传图片到服务器，调用AI分析接口
    return FortuneAnalysis(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      analysisDate: DateTime.now(),
      analysisType: type,
      faceAnalysis: {},
      palmAnalysis: {},
      baziAnalysis: {},
      fortuneScores: {'career': 85, 'health': 78, 'wealth': 92, 'emotion': 80},
      summary: '分析结果总结...',
      suggestions: ['建议1', '建议2'],
    );
  }

  /// TODO: 获取历史分析报告
  /// 接口: GET /api/fortune/analysis/history
  static Future<List<FortuneAnalysis>> getAnalysisHistory() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }

  // ==================== 健康相关 ====================
  
  /// TODO: 连接智能设备
  /// 接口: POST /api/health/device/connect
  static Future<bool> connectHealthDevice({
    required String deviceType, // huawei, xiaomi, apple_watch
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    // TODO: 实际应该调用设备SDK进行连接
    return true;
  }

  /// TODO: 同步健康数据
  /// 接口: GET /api/health/data/sync
  static Future<List<HealthData>> syncHealthData() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return [];
  }

  /// TODO: 上传舌象照片
  /// 接口: POST /api/health/tongue-image
  static Future<HealthData> uploadTongueImage(String imagePath) async {
    await Future.delayed(const Duration(seconds: 2));
    // TODO: 实际上传图片并调用AI识别
    return HealthData(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      timestamp: DateTime.now(),
      constitutionType: '平和质',
    );
  }
}


