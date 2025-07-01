import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int seconds = 10; // 25:00
  bool isRunning = false;
  Timer? _timer;
  int todayFocus = 5;
  int streakDays = 3;
  int monthlyStats = 100;

  String get timeString {
    final min = (seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  void startTimer() {
    setState(() {
      isRunning = true;
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
      seconds = seconds;
      isRunning = false;
    });
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDEFF9),
      body: SafeArea(
        child: Column(
          children: [
            // 顶部栏
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 18,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '12:30 AM',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.battery_full,
                        color: Colors.lightBlue,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '83%',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // 鸡蛋图标
            Padding(
              padding: const EdgeInsets.only(right: 50), // 向左偏移 20 像素
              child: SizedBox(
                width: 425,
                height: 400,
                child: ClipOval(
                  child: Lottie.asset('lottie/egg.json', fit: BoxFit.fill),
                ),
              ),
            ),
            const SizedBox(height: 0),
            // 开始按钮
            SizedBox(
              width: 100,
              height: 100,
              child: ElevatedButton(
                onPressed: isRunning ? null : startTimer,
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.blue,
                  elevation: 2,
                ),
                child: Text(
                  timeString,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // 底部统计
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
                  // TODO: 跳转页面
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
