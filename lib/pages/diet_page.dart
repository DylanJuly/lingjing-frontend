import 'package:flutter/material.dart';

/// 基于"药食同源"与营养学的智能饮食推荐系统
class DietPage extends StatefulWidget {
  const DietPage({Key? key}) : super(key: key);

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  String _selectedMeal = '早餐'; // 早餐、午餐、晚餐、加餐

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('饮食推荐'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: 打开筛选设置
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 餐次选择
          _buildMealSelector(),
          // 推荐内容
          Expanded(
            child: _buildRecommendations(),
          ),
        ],
      ),
    );
  }

  Widget _buildMealSelector() {
    final meals = ['早餐', '午餐', '晚餐', '加餐'];
    return Container(
      height: 60,
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
        children: meals.map((meal) {
          final isSelected = _selectedMeal == meal;
          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedMeal = meal;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? const Color(0xFF6B46C1) : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    meal,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? const Color(0xFF6B46C1) : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRecommendations() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 推荐理由
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '推荐理由',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildReasonChip('平和质', Colors.green),
                      _buildReasonChip('春季温补', Colors.orange),
                      _buildReasonChip('运势平稳期', Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // 今日推荐食谱
          const Text(
            '今日推荐食谱',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          // 食谱卡片列表
          _buildRecipeCard(
            '红枣枸杞粥',
            'https://picsum.photos/400/300?random=1',
            '适合平和质人群，具有滋阴润燥的功效',
            ['红枣', '枸杞', '大米', '冰糖'],
            '1. 将大米洗净，红枣去核\n2. 加水煮至米粒开花\n3. 加入枸杞和冰糖，煮5分钟即可',
            '热量: 280kcal | 蛋白质: 8g | 碳水化合物: 60g',
          ),
          const SizedBox(height: 12),
          _buildRecipeCard(
            '银耳莲子汤',
            'https://picsum.photos/400/300?random=2',
            '清热润肺，适合春季养生',
            ['银耳', '莲子', '冰糖', '枸杞'],
            '1. 银耳提前泡发\n2. 与莲子一同炖煮\n3. 最后加入冰糖和枸杞',
            '热量: 150kcal | 蛋白质: 3g | 碳水化合物: 35g',
          ),
          const SizedBox(height: 12),
          _buildRecipeCard(
            '山药排骨汤',
            'https://picsum.photos/400/300?random=3',
            '补气养血，增强体质',
            ['山药', '排骨', '枸杞', '姜片'],
            '1. 排骨焯水\n2. 与山药一同炖煮\n3. 调味后加入枸杞',
            '热量: 320kcal | 蛋白质: 25g | 脂肪: 15g',
          ),
        ],
      ),
    );
  }

  Widget _buildReasonChip(String label, Color color) {
    return Chip(
      label: Text(label),
      backgroundColor: color.withOpacity(0.1),
      labelStyle: TextStyle(color: color),
      avatar: Icon(Icons.check_circle, size: 16, color: color),
    );
  }

  Widget _buildRecipeCard(
    String name,
    String imageUrl,
    String description,
    List<String> ingredients,
    String steps,
    String nutrition,
  ) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 图片
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.restaurant, size: 48, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题和描述
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                
                // 食材列表
                const Text(
                  '食材',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ingredients.map((ingredient) {
                    return Chip(
                      label: Text(ingredient),
                      backgroundColor: Colors.grey[100],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                
                // 制作方法
                const Text(
                  '制作方法',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  steps,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                
                // 营养成分
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          nutrition,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                
                // 操作按钮
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: 收藏食谱
                        },
                        icon: const Icon(Icons.bookmark_border),
                        label: const Text('收藏'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: 开始制作
                        },
                        icon: const Icon(Icons.restaurant_menu),
                        label: const Text('开始制作'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6B46C1),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




