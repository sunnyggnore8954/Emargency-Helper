import 'package:flutter/material.dart';

import '../main.dart';

const String kAppTitle = '응급 환자 도우미';

/// 로그인 화면 상단바 - 좌측에 4개 아이콘(체크리스트/메시지/캘린더/위치)이
/// 나열되고 옆에 앱 타이틀이 붙는다. (로그인 전이라 탭 기능은 없음)
class PreLoginTopBar extends StatelessWidget implements PreferredSizeWidget {
  const PreLoginTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appBarGray,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              const Icon(Icons.fact_check_outlined, color: AppColors.textDark, size: 24),
              const SizedBox(width: 10),
              const Icon(Icons.post_add, color: AppColors.textDark, size: 24),
              const SizedBox(width: 10),
              const Icon(Icons.event_note, color: AppColors.textDark, size: 24),
              const SizedBox(width: 10),
              const Icon(Icons.location_on_outlined, color: AppColors.textDark, size: 24),
              const SizedBox(width: 14),
              const Text(
                kAppTitle,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 로그인 이후 화면 상단바 - 청록색 + 로고 원 아이콘 + 타이틀
class LogoTopBar extends StatelessWidget implements PreferredSizeWidget {
  const LogoTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appBarGray,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.teal, width: 2.2),
                ),
                child: const Icon(Icons.add, color: AppColors.teal, size: 18),
              ),
              const SizedBox(width: 12),
              const Text(
                kAppTitle,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
