import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const SettingsApp());

class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '设置页面',
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const SettingsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool realTimeActivity = true;
  bool hapticFeedback = false;

  void navigateToPage(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("设置"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 8),
          // 个性设置分组
          Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: "个性设置"),
                settingTile("🎉 特别活动：免费获取 Pro", onTap: () => navigateToPage("Pro活动")),
                settingTile("自定义提示音", onTap: () => navigateToPage("提示音设置")),
                settingTile("专注模式", subtitle: "学霸模式", onTap: () => navigateToPage("专注模式")),
                settingTile("桌面图标", onTap: () => navigateToPage("图标设置")),
                settingTile("时间定义", onTap: () => navigateToPage("时间定义")),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // 系统设置分组
          Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[900] : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: "系统设置"),
                settingTile("外观", subtitle: "跟随系统", onTap: () => navigateToPage("外观设置")),
                settingTile("语言", subtitle: "简体中文", onTap: () => navigateToPage("语言设置")),
                settingTile("通知", subtitle: "未开启", onTap: () => navigateToPage("通知设置")),
                settingSwitch("实时活动", realTimeActivity, (val) {
                  setState(() => realTimeActivity = val);
                }),
                settingSwitch("徽章震动反馈", hapticFeedback, (val) {
                  setState(() => hapticFeedback = val);
                }),
                settingTile("iCloud 数据同步", leadingIcon: CupertinoIcons.cloud, onTap: () => navigateToPage("iCloud同步")),
                settingTile("同步到日历和 Apple 健康", leadingIcon: CupertinoIcons.calendar, onTap: () => navigateToPage("同步设置")),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget settingTile(String title,
      {String? subtitle,
      IconData? leadingIcon,
      VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 0),
      leading: leadingIcon != null
          ? Icon(leadingIcon, size: 20, color: Theme.of(context).iconTheme.color)
          : null,
      title: Text(title, style: const TextStyle(fontSize: 16)),
      subtitle: subtitle != null
          ? Text(subtitle, style: const TextStyle(color: Colors.grey))
          : null,
      trailing: Container(
        margin: const EdgeInsets.only(right: 16), // 箭头左移
        child: const Icon(Icons.chevron_right),
      ),
      onTap: onTap,
    );
  }

  Widget settingSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 0),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8, left: 16), // 增加左侧缩进
      child: Text(title,
          style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).textTheme.bodySmall?.color)),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;

  const DetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Center(
        child: Text("这里是 [$title] 的设置页面",
            style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}