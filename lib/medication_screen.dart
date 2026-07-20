import 'package:flutter/material.dart';

import '../main.dart';
import '../medication.dart';
import 'medication_form_screen.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({super.key});

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  static const List<String> _weekdayLabels = ['일', '월', '화', '수', '목', '금', '토'];
  static const List<Color> _dotPalette = [
    Color(0xFF3FBFC7), // teal - 타이레놀
    Color(0xFFB09BE0), // purple - 비타민C
    Color(0xFFE1483F),
    Color(0xFFF0A93B),
  ];

  late DateTime _today;
  late DateTime _selectedDate;
  late DateTime _focusedMonth;

  final List<Medication> _medications = [];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _today = DateTime(now.year, now.month, now.day);
    _selectedDate = _today;
    _focusedMonth = DateTime(now.year, now.month, 1);

    _medications.addAll([
      Medication(
        id: 'seed-1',
        title: '타이레놀',
        date: _today,
        frequencyText: '1일 2정',
        colorTag: _dotPalette[0],
      ),
      Medication(
        id: 'seed-2',
        title: '비타민C',
        date: _today,
        frequencyText: '1일 1정',
        colorTag: _dotPalette[1],
      ),
    ]);
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  List<Medication> _medsOn(DateTime day) =>
      _medications.where((m) => _isSameDay(m.date, day)).toList();

  List<DateTime> _buildMonthGridDays() {
    final firstOfMonth = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final firstWeekday = firstOfMonth.weekday % 7;
    final gridStart = firstOfMonth.subtract(Duration(days: firstWeekday));
    final daysInMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0).day;
    final totalCells = firstWeekday + daysInMonth;
    final weeks = (totalCells / 7).ceil();
    return List.generate(weeks * 7, (i) => gridStart.add(Duration(days: i)));
  }

  Future<void> _openAddForm({Medication? existing}) async {
    final result = await Navigator.of(context).push<Medication>(
      MaterialPageRoute(
        builder: (_) => MedicationFormScreen(initialDate: _selectedDate, existing: existing),
      ),
    );
    if (result == null) return;
    setState(() {
      if (existing != null) {
        final index = _medications.indexWhere((m) => m.id == existing.id);
        if (index != -1) _medications[index] = result;
      } else {
        _medications.add(result);
      }
      _selectedDate = DateTime(result.date.year, result.date.month, result.date.day);
      _focusedMonth = DateTime(result.date.year, result.date.month, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final days = _buildMonthGridDays();
    final selectedDayMeds = _medsOn(_selectedDate);

    return Container(
      color: AppColors.scaffoldGray,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                color: AppColors.cardWhite,
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                child: Column(
                  children: [
                    Row(
                      children: _weekdayLabels
                          .map((d) => Expanded(
                                child: Center(
                                  child: Text(
                                    d,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textGray,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    _buildGrid(days),
                  ],
                ),
              ),
              const Divider(height: 1, thickness: 1),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
                  children: [
                    for (final med in selectedDayMeds) ...[
                      _MedicationTile(
                        medication: med,
                        onEdit: () => _openAddForm(existing: med),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (selectedDayMeds.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(
                          child: Text(
                            '이 날짜에 등록된 약이 없어요',
                            style: const TextStyle(color: AppColors.textGray, fontSize: 14),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: () => _openAddForm(),
              backgroundColor: AppColors.fabDark,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(List<DateTime> days) {
    final rows = <Widget>[];
    for (var i = 0; i < days.length; i += 7) {
      final week = days.sublist(i, i + 7 > days.length ? days.length : i + 7);
      rows.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: week.map((day) => Expanded(child: _buildDayCell(day))).toList(),
          ),
        ),
      );
    }
    return Column(children: rows);
  }

  Widget _buildDayCell(DateTime day) {
    final inMonth = day.month == _focusedMonth.month;
    final isSelected = _isSameDay(day, _selectedDate);
    final meds = _medsOn(day);

    return GestureDetector(
      onTap: () => setState(() => _selectedDate = day),
      child: Column(
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.calendarSelectedRed : null,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${day.day}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected
                    ? Colors.white
                    : inMonth
                        ? AppColors.textDark
                        : AppColors.textDark.withOpacity(0.25),
              ),
            ),
          ),
          const SizedBox(height: 3),
          SizedBox(
            height: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final m in meds.take(3))
                  Container(
                    width: 5,
                    height: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(color: m.colorTag, shape: BoxShape.circle),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicationTile extends StatelessWidget {
  final Medication medication;
  final VoidCallback onEdit;

  const _MedicationTile({required this.medication, required this.onEdit});

  String _formatDate(DateTime d) => '${d.year}년 ${d.month}월 ${d.day}일';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(width: 4, height: 40, color: medication.colorTag),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medication.title,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_formatDate(medication.date)} · ${medication.frequencyText}',
                  style: const TextStyle(fontSize: 13, color: AppColors.textGray),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined, color: AppColors.textGray, size: 20),
          ),
        ],
      ),
    );
  }
}
