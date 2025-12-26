import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/mock_service.dart';

/// 我的页面
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfile? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  /// TODO: 后端接口完成后，替换MockService调用
  Future<void> _loadProfile() async {
    // TODO: 从服务器加载用户信息
    setState(() {
      _profile = UserProfile(
        id: '1',
        name: '用户',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 个人信息头部
            _buildProfileHeader(),
            // 个人信息管理
            _buildPersonalInfoSection(),
            // 账户与安全
            _buildAccountSecuritySection(),
            // 隐私设置
            _buildPrivacySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.white,
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.purple[100],
            child: const Icon(Icons.person, size: 40),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _profile?.name ?? '未登录',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID: ${_profile?.id ?? "---"}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: 跳转到编辑个人信息页面
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildListTile(
            icon: Icons.person,
            title: '基础信息',
            subtitle: '编辑昵称、头像、性别、生日',
            onTap: () {
              // TODO: 跳转到基础信息编辑页面
            },
          ),
          const Divider(),
          _buildListTile(
            icon: Icons.stars,
            title: '命理信息',
            subtitle: '管理和编辑出生信息（八字）',
            onTap: () {
              // TODO: 跳转到命理信息编辑页面
            },
          ),
          const Divider(),
          _buildListTile(
            icon: Icons.favorite,
            title: '健康档案',
            subtitle: '查看和管理所有健康相关数据与报告',
            onTap: () {
              // TODO: 跳转到健康档案页面
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSecuritySection() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildListTile(
            icon: Icons.phone,
            title: '账号绑定',
            subtitle: '绑定/解绑手机号、第三方账号',
            onTap: () {
              // TODO: 跳转到账号绑定页面
            },
          ),
          const Divider(),
          _buildListTile(
            icon: Icons.lock,
            title: '修改密码',
            subtitle: '修改登录密码',
            onTap: () {
              // TODO: 跳转到修改密码页面
            },
          ),
          const Divider(),
          _buildListTile(
            icon: Icons.delete_outline,
            title: '注销账号',
            subtitle: '永久删除账号及所有数据',
            onTap: () {
              // TODO: 显示注销账号确认对话框
            },
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySection() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildListTile(
            icon: Icons.security,
            title: '数据权限管理',
            subtitle: '管理相机、位置、健康数据等系统权限',
            onTap: () {
              // TODO: 跳转到权限管理页面
            },
          ),
          const Divider(),
          _buildListTile(
            icon: Icons.privacy_tip,
            title: '隐私协议',
            subtitle: '查看完整的隐私政策',
            onTap: () {
              // TODO: 显示隐私协议页面
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(title, style: TextStyle(color: textColor)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}


