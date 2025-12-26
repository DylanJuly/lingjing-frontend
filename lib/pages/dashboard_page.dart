import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// 灵境看板 - 生活节律与玄学时令的智能规划看板
class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateFormat = DateFormat('yyyy年MM月dd日 EEEE', 'zh_CN');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('灵境看板'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // TODO: 设置页面
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 日期和节气信息卡片
            _buildDateCard(now, dateFormat),
            const SizedBox(height: 16),
            
            // 今日运势概览
            _buildFortuneOverview(),
            const SizedBox(height: 16),
            
            // 健康状态卡片
            _buildHealthStatusCard(),
            const SizedBox(height: 16),
            
            // 今日建议
            _buildTodaySuggestions(),
            const SizedBox(height: 16),
            
            // 本周节律
            _buildWeeklyRhythm(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateCard(DateTime now, DateFormat dateFormat) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dateFormat.format(now),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '今日节气：立春（示例）', // TODO: 接入真实节气计算
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '干支历：甲子年 丙寅月 戊午日', // TODO: 接入真实干支历计算
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFortuneOverview() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '今日运势概览',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildFortuneItem('事业', Icons.work_outline, Colors.blue, 85),
                _buildFortuneItem('健康', Icons.favorite_outline, Colors.red, 78),
                _buildFortuneItem('财运', Icons.attach_money, Colors.amber, 92),
                _buildFortuneItem('感情', Icons.favorite, Colors.pink, 80),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFortuneItem(String label, IconData icon, Color color, int score) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          '$score',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildHealthStatusCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '健康状态',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildHealthMetric('心率', '72', 'bpm', Colors.red),
                ),
                Expanded(
                  child: _buildHealthMetric('睡眠', '7.5', '小时', Colors.blue),
                ),
                Expanded(
                  child: _buildHealthMetric('步数', '8523', '步', Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              '体质：平和质（建议保持）', // TODO: 接入真实健康数据
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthMetric(String label, String value, String unit, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(width: 2),
            Text(
              unit,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTodaySuggestions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '今日建议',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildSuggestionItem(
              Icons.wb_sunny,
              '适宜时间',
              '上午9-11点适合重要决策',
              Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildSuggestionItem(
              Icons.restaurant,
              '饮食建议',
              '今日宜温补，推荐红枣枸杞茶',
              Colors.red,
            ),
            const SizedBox(height: 12),
            _buildSuggestionItem(
              Icons.self_improvement,
              '情绪调节',
              '运势波动期，建议进行冥想放松',
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionItem(IconData icon, String title, String content, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyRhythm() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '本周节律',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // TODO: 添加周视图图表
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  '周节律图表（待实现）',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



