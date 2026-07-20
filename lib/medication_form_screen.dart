import 'package:flutter/material.dart';

import '../main.dart';
import '../medication.dart';

class MedicationFormScreen extends StatefulWidget {
  final DateTime initialDate;
  final Medication? existing;

  const MedicationFormScreen({super.key, required this.initialDate, this.existing});

  @override
  State<MedicationFormScreen> createState() => _MedicationFormScreenState();
}

class _MedicationFormScreenState extends State<MedicationFormScreen> {
  late TextEditingController _titleController;
  late TextEditingController _freqController;
  late DateTime _date;

  static const List<Color> _colorChoices = [
    Color(0xFF3FBFC7),
    Color(0xFFB09BE0),
    Color(0xFFE1483F),
    Color(0xFFF0A93B),
    Color(0xFF6C8CE0),
  ];
  late Color _color;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existing?.title ?? '');
    _freqController = TextEditingController(text: widget.existing?.frequencyText ?? '1일 1정');
    _date = widget.existing?.date ?? widget.initialDate;
    _color = widget.existing?.colorTag ?? _colorChoices.first;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _freqController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      helpText: '날짜 선택',
      cancelText: '취소',
      confirmText: '확인',
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _save() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('약 이름을 입력해주세요')),
      );
      return;
    }
    final result = Medication(
      id: widget.existing?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      date: _date,
      frequencyText: _freqController.text.trim().isEmpty ? '1일 1정' : _freqController.text.trim(),
      colorTag: _color,
    );
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existing != null;
    return Scaffold(
      backgroundColor: AppColors.scaffoldGray,
      appBar: AppBar(
        backgroundColor: AppColors.appBarGray,
        elevation: 0,
        foregroundColor: AppColors.textDark,
        title: Text(isEditing ? '약 수정' : '약 추가'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('약 이름', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: AppColors.inputFill,
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            const Text('복용법', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 8),
            TextField(
              controller: _freqController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: AppColors.inputFill,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: '예: 1일 2정',
              ),
            ),
            const SizedBox(height: 20),
            const Text('날짜', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('${_date.year}년 ${_date.month}월 ${_date.day}일'),
                const Spacer(),
                OutlinedButton(onPressed: _pickDate, child: const Text('날짜 선택')),
              ],
            ),
            const SizedBox(height: 20),
            const Text('색상 태그', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 8),
            Row(
              children: [
                for (final c in _colorChoices)
                  GestureDetector(
                    onTap: () => setState(() => _color = c),
                    child: Container(
                      width: 32,
                      height: 32,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: c,
                        shape: BoxShape.circle,
                        border: _color == c
                            ? Border.all(color: AppColors.textDark, width: 2)
                            : null,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.fabDark,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('저장'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
