// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import '../models/global/global.dart';

// class WebSocketApi {
//   late String baseUrl = "";
//   WebSocket? _socket;
//   StreamController<Response>? _controller; // 使用 nullable，避免多次初始化
//   bool isConnected = false;

//   Stream<Response> get stream {
//     if (_controller == null || _controller!.isClosed) {
//       _controller = StreamController<Response>.broadcast(); // 每次取用前確保重置
//     }
//     return _controller!.stream;
//   }

//   WebSocketApi() {
//     _initializeBaseUrl();
//   }

//   Future<void> ensureInitialized() async {
//     if (baseUrl.isEmpty) {
//       debugPrint("尚未初始化 baseUrl，開始初始化...");
//       await _initializeBaseUrl();
//     }
//   }

//   Future<void> _initializeBaseUrl() async {
//     final storage = const FlutterSecureStorage();
//     final String? plantID = await storage.read(key: "plantID");

//     if (plantID != null && Plant.plants.containsKey(plantID)) {
//       baseUrl = Plant.plants[plantID]!.wsUrl;
//       debugPrint('已設定 BaseUrl: $baseUrl');
//     } else {
//       throw Exception("無法取得有效的 plantID 或對應的 Plant 配置");
//     }
//   }

//   Future<void> connect(String endpoint, Map<String, dynamic> queryParams,
//       Map<String, String> header) async {
//     await disconnect(); // 確保先斷開現有連接

//     try {
//       await ensureInitialized();
//       String fullUrl =
//           baseUrl + endpoint + '?' + Uri(queryParameters: queryParams).query;
//       debugPrint("當前網址：$fullUrl");

//       _socket = await WebSocket.connect(fullUrl, headers: header);
//       isConnected = true;

//       _socket!.listen(
//         _handleMessage,
//         onDone: _handleDone,
//         onError: _handleError,
//       );
//     } catch (e) {
//       _controller?.addError(e);
//       print('無法連接到 WebSocket: $e');
//     }
//   }

//   void _handleMessage(dynamic message) {
//     try {
//       var res = Response.fromJson(jsonDecode(message));
//       _controller?.add(res);
//     } catch (e) {
//       print('JSON parsing error: $e');
//     }
//   }

//   void _handleDone() {
//     isConnected = false;
//     _controller?.close();
//     print('WebSocket 連線關閉');
//   }

//   void _handleError(dynamic error) {
//     isConnected = false;
//     _controller?.addError(error);
//     print('WebSocket 錯誤: $error');
//   }

//   Future<void> disconnect() async {
//     if (_socket != null) {
//       await _socket!.close();
//       _socket = null;
//       isConnected = false;
//       print('WebSocket 已關閉');
//     }
//     _controller?.close(); // 正確關閉 StreamController
//     _controller = null; // 重置 Controller
//   }
// }
