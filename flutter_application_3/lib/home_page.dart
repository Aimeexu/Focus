import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int seconds = 10; // 倒计时秒数
  bool isRunning = false;
  Timer? _timer;

  int todayFocus = 5;
  int streakDays = 3;
  int monthlyStats = 100;

  // 控制 Lottie 动画路径
  String lottiePath = 'assets/lottie/egg.json';

  String get timeString {
    final min = (seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  void startTimer() {
    setState(() {
      isRunning = true;
      lottiePath = 'assets/lottie/egg.json'; // 重置动画为鸡蛋
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0 && isRunning) {
        setState(() {
          seconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          isRunning = false;
          lottiePath = 'assets/lottie/chicken.json';
          seconds = 10; // ⬅️ 恢复初始时间
        });
      }
    });
  }

  void pauseTimer() {
    setState(() {
      isRunning = false;
    });
    _timer?.cancel();
  }

  void resetTimer() {
    setState(() {
      seconds = 10;
      isRunning = false;
      lottiePath = 'assets/lottie/egg.json';
    });
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDEFF9),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),

            // 🥚 Lottie 动画（动态切换）
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: SizedBox(
                width: 425,
                height: 400,
                child: ClipOval(
                  child: Lottie.asset(lottiePath, fit: BoxFit.fill),
                ),
              ),
            ),

            const SizedBox(height: 0),

            // ⏱ 倒计时按钮
            SizedBox(
              width: 120,
              height: 120,
              child: ElevatedButton(
                onPressed: isRunning ? null : startTimer,
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.blue,
                  elevation: 2,
                ),
                child: Text(
                  timeString,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 📊 底部统计
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '每日专注: $todayFocus次',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        '已专注: $streakDays天',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),

            const Spacer(),

            // 底部导航栏
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.egg), label: '首页'),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today),
                    label: '历史记录',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: '设置',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.help_outline),
                    label: '帮助',
                  ),
                ],
                currentIndex: 0,
                onTap: (index) {
                  // TODO: 页面跳转逻辑
                },
                selectedItemColor: Colors.deepPurple,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
