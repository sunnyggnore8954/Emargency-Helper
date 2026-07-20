import 'package:flutter/material.dart';

import '../main.dart';

/// 스크린샷에 없어서 아직 디자인이 확정되지 않은 탭을 위한 자리표시 화면.
/// 나중에 실제 화면 캡처를 주면 그대로 맞춰서 교체할 수 있습니다.
class PlaceholderScreen extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const PlaceholderScreen({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cardWhite,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: AppColors.teal),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: AppColors.textGray, height: 1.5),
          ),
          const SizedBox(height: 4),
          const Text(
            '(디자인 스크린샷이 없어 임시로 만든 화면이에요)',
            style: TextStyle(fontSize: 12, color: AppColors.textGray),
          ),
        ],
      ),
    );
  }
}
