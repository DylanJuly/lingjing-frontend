import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

/// 多模态AI命理分析页面 - 面相、手相、八字分析
class FortunePage extends StatefulWidget {
  const FortunePage({Key? key}) : super(key: key);

  @override
  State<FortunePage> createState() => _FortunePageState();
}

class _FortunePageState extends State<FortunePage> {
  final ImagePicker _picker = ImagePicker();
  File? _faceImage;
  File? _palmImage;
  DateTime? _birthDate;
  TimeOfDay? _birthTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('命理分析'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 分析类型选择
            _buildAnalysisTypeSelector(),
            const SizedBox(height: 24),
            
            // 面相分析
            _buildFaceAnalysisSection(),
            const SizedBox(height: 24),
            
            // 手相分析
            _buildPalmAnalysisSection(),
            const SizedBox(height: 24),
            
            // 八字信息
            _buildBirthInfoSection(),
            const SizedBox(height: 24),
            
            // 开始分析按钮
            _buildAnalyzeButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisTypeSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '选择分析类型',
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
                _buildAnalysisChip('面相分析', Icons.face),
                _buildAnalysisChip('手相分析', Icons.pan_tool),
                _buildAnalysisChip('八字推演', Icons.calendar_today),
                _buildAnalysisChip('综合分析', Icons.auto_awesome),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisChip(String label, IconData icon) {
    return FilterChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      selected: false,
      onSelected: (selected) {
        // TODO: 处理选择
      },
    );
  }

  Widget _buildFaceAnalysisSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '面相分析',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '上传您的正面照片，AI将分析面部特征点',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _pickFaceImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    style: BorderStyle.solid,
                  ),
                ),
                child: _faceImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _faceImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate, size: 48, color: Colors.grey),
                          SizedBox(height: 8),
                          Text(
                            '点击上传面相照片',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPalmAnalysisSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '手相分析',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '上传您的手掌照片，AI将分析掌纹特征',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _pickPalmImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    style: BorderStyle.solid,
                  ),
                ),
                child: _palmImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _palmImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.pan_tool, size: 48, color: Colors.grey),
                          SizedBox(height: 8),
                          Text(
                            '点击上传手相照片',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBirthInfoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '出生信息（用于八字推演）',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('出生日期'),
              subtitle: Text(
                _birthDate != null
                    ? '${_birthDate!.year}年${_birthDate!.month}月${_birthDate!.day}日'
                    : '请选择出生日期',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _selectBirthDate,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('出生时间'),
              subtitle: Text(
                _birthTime != null
                    ? '${_birthTime!.hour}:${_birthTime!.minute.toString().padLeft(2, '0')}'
                    : '请选择出生时间',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _selectBirthTime,
            ),
            const SizedBox(height: 8),
            const Text(
              '提示：准确的出生时间有助于更精确的八字分析',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyzeButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _startAnalysis,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B46C1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          '开始AI分析',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _pickFaceImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _faceImage = File(image.path);
      });
    }
  }

  Future<void> _pickPalmImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _palmImage = File(image.path);
      });
    }
  }

  Future<void> _selectBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('zh', 'CN'),
    );
    if (picked != null) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  Future<void> _selectBirthTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _birthTime = picked;
      });
    }
  }

  void _startAnalysis() {
    // TODO: 调用AI分析接口
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('分析中'),
        content: const Text('AI正在分析您的信息，请稍候...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}

