import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class INetworkService {
  Future<Map<String, dynamic>?> login(String username, String password);
}

class HttpNetworkService implements INetworkService {
  static final HttpNetworkService _instance = HttpNetworkService._internal();
  factory HttpNetworkService() => _instance;
  HttpNetworkService._internal();

  @override
  Future<Map<String, dynamic>?> login(String username, String password) async {
    final url = Uri.parse("http://127.0.0.1:8000/login");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // 可扩展统一异常处理
        throw Exception('Network error: \${response.statusCode}');
      }
    } catch (e) {
      // 日志与异常上报
      print('Login error: \$e');
      return null;
    }
  }
}