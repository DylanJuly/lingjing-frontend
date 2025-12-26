import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

/// 中西医结合的动态健康画像库
class HealthPage extends StatefulWidget {
  const HealthPage({Key? key}) : super(key: key);

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  int _selectedTab = 0; // 0: 实时数据, 1: 历史趋势, 2: 体质分析

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('健康画像'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              // TODO: 添加健康数据
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 标签页
          _buildTabBar(),
          // 内容区域
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
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
          Expanded(
            child: _buildTabItem('实时数据', 0, Icons.favorite),
          ),
          Expanded(
            child: _buildTabItem('历史趋势', 1, Icons.trending_up),
          ),
          Expanded(
            child: _buildTabItem('体质分析', 2, Icons.analytics),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, int index, IconData icon) {
    final isSelected = _selectedTab == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? const Color(0xFF6B46C1) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF6B46C1) : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF6B46C1) : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return _buildRealTimeData();
      case 1:
        return _buildHistoryTrend();
      case 2:
        return _buildConstitutionAnalysis();
      default:
        return const SizedBox();
    }
  }

  Widget _buildRealTimeData() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 健康数据卡片网格
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
            children: [
              _buildHealthMetricCard('心率', '72', 'bpm', Icons.favorite, Colors.red),
              _buildHealthMetricCard('睡眠', '7.5', '小时', Icons.bedtime, Colors.blue),
              _buildHealthMetricCard('步数', '8523', '步', Icons.directions_walk, Colors.green),
              _buildHealthMetricCard('血氧', '98', '%', Icons.air, Colors.orange),
            ],
          ),
          const SizedBox(height: 16),
          
          // 智能穿戴设备连接
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '智能设备',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: const Icon(Icons.watch, size: 32),
                    title: const Text('智能手表'),
                    subtitle: const Text('已连接 - 实时同步数据'),
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {
                        // TODO: 处理设备连接
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // 自主填报
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '自主填报',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildReportButton('舌苔拍照识别', Icons.camera_alt),
                  const SizedBox(height: 8),
                  _buildReportButton('日常状态问诊', Icons.quiz),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthMetricCard(String label, String value, String unit, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
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
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(width: 2),
                Text(
                  unit,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportButton(String label, IconData icon) {
    return OutlinedButton.icon(
      onPressed: () {
        // TODO: 打开填报页面
      },
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        minimumSize: const Size(double.infinity, 48),
      ),
    );
  }

  Widget _buildHistoryTrend() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '心率趋势（近7天）',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              const FlSpot(0, 70),
                              const FlSpot(1, 72),
                              const FlSpot(2, 75),
                              const FlSpot(3, 73),
                              const FlSpot(4, 71),
                              const FlSpot(5, 74),
                              const FlSpot(6, 72),
                            ],
                            isCurved: true,
                            color: Colors.red,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '睡眠质量（近7天）',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        barGroups: [
                          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 7.5)]),
                          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 8.0)]),
                          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 7.0)]),
                          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 7.8)]),
                          BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 8.2)]),
                          BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 7.3)]),
                          BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 7.6)]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConstitutionAnalysis() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '中医体质辨识',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildConstitutionItem('平和质', 85, Colors.green),
                  const SizedBox(height: 12),
                  _buildConstitutionItem('气虚质', 45, Colors.orange),
                  const SizedBox(height: 12),
                  _buildConstitutionItem('湿热质', 30, Colors.red),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '西医生理指标',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildPhysiologicalIndicator('血压', '120/80', 'mmHg', '正常'),
                  const Divider(),
                  _buildPhysiologicalIndicator('血糖', '5.5', 'mmol/L', '正常'),
                  const Divider(),
                  _buildPhysiologicalIndicator('胆固醇', '4.8', 'mmol/L', '正常'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConstitutionItem(String name, int score, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$score%',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: score / 100,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  Widget _buildPhysiologicalIndicator(String name, String value, String unit, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$value $unit',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}




