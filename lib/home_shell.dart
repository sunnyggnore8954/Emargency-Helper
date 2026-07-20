import 'package:flutter/material.dart';
import '../main.dart';
import '../app_bars.dart';
import 'guide_screen.dart';
import 'medication_screen.dart';
import 'placeholder_screen.dart';

class HomeShell extends StatefulWidget {
  final bool showSignupSuccess;

  const HomeShell({super.key, this.showSignupSuccess = false});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tabIndex = 0;

  final List<Widget> _tabs = const [
    GuideScreen(),
    PlaceholderScreen(
      icon: Icons.post_add,
      title: '응급 신고 작성',
      description: '응급 상황을 기록하고 119에 전달할\n신고 내용을 작성하는 화면입니다.',
    ),
    MedicationScreen(),
    PlaceholderScreen(
      icon: Icons.location_on_outlined,
      title: '주변 병원 찾기',
      description: '현재 위치 기준으로 가까운\n응급실/병원을 찾아주는 화면입니다.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.showSignupSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('가입 성공!'),
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Color(0xFF2B2B2B),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldGray,
      appBar: const LogoTopBar(),
      body: IndexedStack(index: _tabIndex, children: _tabs),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    final icons = [
      Icons.fact_check_outlined,
      Icons.post_add,
      Icons.event_note,
      Icons.location_on_outlined,
    ];
    return Container(
      color: const Color(0xFF2B2B2B),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: List.generate(icons.length, (i) {
              final selected = i == _tabIndex;
              return Expanded(
                child: InkWell(
                  onTap: () => setState(() => _tabIndex = i),
                  child: Icon(
                    icons[i],
                    color: selected ? AppColors.teal : Colors.white70,
                    size: 24,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
