import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/mock_service.dart';
import '../models/solar_term.dart';
import '../models/recipe.dart';
import 'diet_page.dart';

/// 首页 - 包含所有功能模块入口
class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  SolarTerm? _solarTerm;
  List<Recipe> _todayRecipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /// TODO: 后端接口完成后，替换MockService调用
  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final solarTerm = await MockService.getTodaySolarTerm();
      final recipes = await MockService.getTodayRecipes();
      setState(() {
        _solarTerm = solarTerm;
        _todayRecipes = recipes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // 搜索栏
                    _buildSearchBar(),
                    
                    // 节气/节日展示
                    if (_solarTerm != null) _buildSolarTermSection(_solarTerm!),
                    
                    // 命理分析与心理抚慰
                    _buildFortuneSection(),
                    
                    // 动态健康画像
                    _buildHealthSection(),
                    
                    // 智能饮食推荐
                    _buildDietSection(),
                    
                    // 灵境智能规划看板
                    _buildDashboardSection(),
                  ],
                ),
              ),
      ),
    );
  }

  /// 搜索栏
  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          // TODO: 跳转到搜索页面
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('搜索功能待实现')),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: const [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 8),
              Text(
                '搜索帖子、食谱、健康知识',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 节气/节日展示
  Widget _buildSolarTermSection(SolarTerm solarTerm) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(solarTerm.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              DateFormat('yyyy年MM月dd日').format(solarTerm.date),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${solarTerm.lunarDate} · ${solarTerm.name}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              solarTerm.description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// 命理分析与心理抚慰
  Widget _buildFortuneSection() {
    return _buildSectionCard(
      title: '命理分析与心理抚慰',
      children: [
        _buildFeatureItem(
          icon: Icons.face,
          title: '面部/手相分析',
          onTap: () {
            // TODO: 跳转到出生信息填写页面
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('出生信息填写功能待实现')),
            );
          },
        ),
        _buildFeatureItem(
          icon: Icons.calendar_today,
          title: '出生信息命理分析',
          onTap: () {
            // TODO: 跳转到出生信息填写页面
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('出生信息填写功能待实现')),
            );
          },
        ),
        _buildFeatureItem(
          icon: Icons.psychology,
          title: '心理状态自评',
          onTap: () {
            // TODO: 跳转到心理自评页面
          },
        ),
        _buildFeatureItem(
          icon: Icons.history,
          title: '查看历史报告',
          onTap: () {
            // TODO: 跳转到历史报告页面
          },
        ),
      ],
    );
  }

  /// 动态健康画像
  Widget _buildHealthSection() {
    return _buildSectionCard(
      title: '动态健康画像',
      children: [
        _buildFeatureItem(
          icon: Icons.watch,
          title: '连接智能设备',
          onTap: () {
            // TODO: 跳转到健康页面
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('健康功能待实现')),
            );
          },
        ),
        _buildFeatureItem(
          icon: Icons.camera_alt,
          title: '舌象照片上传',
          onTap: () {
            // TODO: 跳转到健康页面
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('健康功能待实现')),
            );
          },
        ),
        _buildFeatureItem(
          icon: Icons.quiz,
          title: '健康问卷填写',
          onTap: () {
            // TODO: 跳转到健康页面
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('健康功能待实现')),
            );
          },
        ),
        _buildFeatureItem(
          icon: Icons.analytics,
          title: '查看健康画像',
          onTap: () {
            // TODO: 跳转到健康页面
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('健康功能待实现')),
            );
          },
        ),
      ],
    );
  }

  /// 智能饮食推荐
  Widget _buildDietSection() {
    return _buildSectionCard(
      title: '智能饮食推荐',
      children: [
        if (_todayRecipes.isNotEmpty)
          ..._todayRecipes.take(3).map((recipe) => _buildRecipeCard(recipe)),
        _buildFeatureItem(
          icon: Icons.restaurant_menu,
          title: '查看历史推荐',
          onTap: () {
            // TODO: 跳转到饮食推荐页面
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('饮食推荐功能待实现')),
            );
          },
        ),
      ],
    );
  }

  /// 灵境智能规划看板
  Widget _buildDashboardSection() {
    return _buildSectionCard(
      title: '灵境智能规划看板',
      children: [
        _buildFeatureItem(
          icon: Icons.dashboard,
          title: '今日行事准则',
          onTap: () {
            // TODO: 跳转到看板页面
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('看板功能待实现')),
            );
          },
        ),
        _buildFeatureItem(
          icon: Icons.self_improvement,
          title: '冥想/放松引导',
          onTap: () {
            // TODO: 跳转到看板页面
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('看板功能待实现')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF6B46C1)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeCard(Recipe recipe) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DietPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200],
              ),
              child: const Icon(Icons.restaurant, size: 30),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    recipe.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

