import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class QuickGetDeptPage extends StatelessWidget {
  final List<ModelPart> modelParts = [
    ModelPart(
      name: '牙齿',
      modelPath: 'assets/models/tooth.glb',
      symptoms: ['牙痛', '牙龈出血'],
      department: '口腔科',
    ),
    ModelPart(
      name: '舌头',
      modelPath: 'assets/models/tongue.glb',
      symptoms: ['舌头溃疡', '味觉异常'],
      department: '口腔黏膜科',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("快速获取科室")),
     body: SingleChildScrollView(
  child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: modelParts.map((part) {
            return Expanded(
              child: GestureDetector(
                onTap: () => _showSymptoms(context, part),
                child: Column(
                  children: [
                    Text(part.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                      height: 200,
                      child: ModelViewer(
                        src: part.modelPath,
                        alt: "3D model of ${part.name}",
                        ar: false,
                        autoRotate: true,
                        cameraControls: true,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    ],
  ),
),

    );
  }

  void _showSymptoms(BuildContext context, ModelPart part) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("请选择症状"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: part.symptoms.map((symptom) {
            return ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // 关闭弹窗
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DepartmentPage(
                      department: part.department,
                      symptom: symptom,
                    ),
                  ),
                );
              },
              child: Text(symptom),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DepartmentPage extends StatelessWidget {
  final String department;
  final String symptom;

  const DepartmentPage({required this.department, required this.symptom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("推荐科室")),
      body: Center(
        child: Text("症状：$symptom\n推荐科室：$department",
            style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
      ),
    );
  }
}

class ModelPart {
  final String name;
  final String modelPath;
  final List<String> symptoms;
  final String department;

  ModelPart({
    required this.name,
    required this.modelPath,
    required this.symptoms,
    required this.department,
  });
}
