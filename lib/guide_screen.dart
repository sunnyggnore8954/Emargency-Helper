import 'package:flutter/material.dart';

import '../main.dart';

class _GuideItem {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;

  const _GuideItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
  });
}

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  static const List<_GuideItem> _items = [
    _GuideItem(
      title: '심정지',
      description: '의식과 호흡을 확인하고, 119 신고 후 즉시 CPR을 시작합니다.',
      icon: Icons.favorite,
      iconColor: AppColors.heartRed,
    ),
    _GuideItem(
      title: '기도 폐쇄',
      description: '기침 유도 후 하임리히법을 시행하세요. 호흡이 멈추면 CPR을 준비합니다.',
      icon: Icons.sentiment_dissatisfied,
      iconColor: AppColors.textDark,
    ),
    _GuideItem(
      title: '출혈',
      description: '깨끗한 천으로 압박하여 출혈 부위를 지혈합니다.',
      icon: Icons.water_drop,
      iconColor: AppColors.heartRed,
    ),
    _GuideItem(
      title: '화상',
      description: '화상 부위를 10분 이상 흐르는 물에 식히고, 감싸거나 터치하지 마세요.',
      icon: Icons.local_fire_department,
      iconColor: AppColors.burnOrange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cardWhite,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        children: [
          const Text(
            '상황을 선택하세요',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 20),
          for (final item in _items) ...[
            _GuideCard(item: item),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  final _GuideItem item;

  const _GuideCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardLavender,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(item.icon, color: item.iconColor, size: 28),
                      const SizedBox(width: 10),
                      Text(
                        item.title,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(item.description, style: const TextStyle(fontSize: 15, height: 1.5)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Icon(item.icon, color: item.iconColor, size: 30),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textGray,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textGray),
            ],
          ),
        ),
      ),
    );
  }
}
