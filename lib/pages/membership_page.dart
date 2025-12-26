import 'package:flutter/material.dart';
import '../models/membership.dart';
import '../services/mock_service.dart';

/// 会员页面
class MembershipPage extends StatefulWidget {
  const MembershipPage({Key? key}) : super(key: key);

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  List<MembershipPackage> _packages = [];
  MembershipStatus? _status;
  List<MembershipBenefit> _benefits = [];
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
      final packages = await MockService.getMembershipPackages();
      final status = await MockService.getMembershipStatus();
      setState(() {
        _packages = packages;
        _status = status;
        _benefits = _getBenefits();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  List<MembershipBenefit> _getBenefits() {
    return [
      MembershipBenefit(
        feature: 'AI对话风格切换',
        freeUser: false,
        memberUser: true,
      ),
      MembershipBenefit(
        feature: '定时发布帖子',
        freeUser: false,
        memberUser: true,
      ),
      MembershipBenefit(
        feature: '高级命理分析',
        freeUser: false,
        memberUser: true,
      ),
      MembershipBenefit(
        feature: '专属健康报告',
        freeUser: false,
        memberUser: true,
      ),
      MembershipBenefit(
        feature: '基础功能',
        freeUser: true,
        memberUser: true,
      ),
    ];
  }

  /// TODO: 后端接口完成后，替换MockService调用
  Future<void> _purchaseMembership(MembershipPackage package) async {
    // TODO: 显示支付方式选择对话框
    final paymentMethod = await _showPaymentDialog();
    if (paymentMethod == null) return;

    try {
      final success = await MockService.purchaseMembership(
        packageId: package.id,
        paymentMethod: paymentMethod,
      );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('购买成功')),
        );
        _loadData();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('购买失败: $e')),
        );
      }
    }
  }

  Future<String?> _showPaymentDialog() async {
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('选择支付方式'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.payment, color: Colors.green),
              title: const Text('微信支付'),
              onTap: () => Navigator.pop(context, 'wechat'),
            ),
            ListTile(
              leading: const Icon(Icons.payment, color: Colors.blue),
              title: const Text('支付宝'),
              onTap: () => Navigator.pop(context, 'alipay'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('会员中心'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 当前会员状态
                  if (_status != null) _buildMembershipStatus(_status!),
                  const SizedBox(height: 24),
                  // 权益对比
                  _buildBenefitsComparison(),
                  const SizedBox(height: 24),
                  // 会员套餐
                  _buildPackages(),
                  const SizedBox(height: 24),
                  // 订单记录
                  _buildOrderHistory(),
                ],
              ),
            ),
    );
  }

  Widget _buildMembershipStatus(MembershipStatus status) {
    return Card(
      color: status.isMember ? Colors.purple[50] : Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              status.isMember ? '会员用户' : '免费用户',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (status.isMember && status.expireDate != null) ...[
              const SizedBox(height: 8),
              Text(
                '到期时间: ${_formatDate(status.expireDate!)}',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
            if (status.isMember) ...[
              const SizedBox(height: 8),
              SwitchListTile(
                title: const Text('自动续费'),
                value: status.autoRenewal,
                onChanged: (value) {
                  // TODO: 调用设置自动续费接口
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitsComparison() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '权益对比',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Table(
              children: [
                const TableRow(
                  children: [
                    Text('功能', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('免费用户', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('会员用户', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                ..._benefits.map((benefit) {
                  return TableRow(
                    children: [
                      Text(benefit.feature),
                      Icon(
                        benefit.freeUser ? Icons.check : Icons.close,
                        color: benefit.freeUser ? Colors.green : Colors.red,
                      ),
                      Icon(
                        benefit.memberUser ? Icons.check : Icons.close,
                        color: benefit.memberUser ? Colors.green : Colors.red,
                      ),
                    ],
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '会员套餐',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ..._packages.map((package) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: package.isPopular ? 4 : 2,
            child: InkWell(
              onTap: () => _purchaseMembership(package),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                package.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (package.isPopular) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    '推荐',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${package.durationDays}天',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '¥${package.price.toStringAsFixed(1)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6B46C1),
                          ),
                        ),
                        if (package.originalPrice != null)
                          Text(
                            '¥${package.originalPrice!.toStringAsFixed(1)}',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildOrderHistory() {
    return Card(
      child: ListTile(
        title: const Text('订单记录'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // TODO: 跳转到订单记录页面
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('订单记录功能待实现')),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}


