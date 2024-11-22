import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:enricoui/enricoui.dart';
import 'package:flutter/foundation.dart';

class EHttpUtil {
  // 单例实例
  static final EHttpUtil _instance = EHttpUtil._internal();

  factory EHttpUtil() {
    return _instance;
  }

  EHttpUtil._internal();

  // Dio 实例
  late Dio _dio;

  // 初始化
  void init({
    String? baseUrl,
    String? proxyUrl, // 添加代理 URL 参数
    int connectTimeout = 10,
    int receiveTimeout = 10,
  }) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl ?? '',
      connectTimeout: Duration(seconds: connectTimeout),
      receiveTimeout: Duration(seconds: receiveTimeout),
    ));

    // 添加代理配置
    if (proxyUrl != null && !kIsWeb) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.findProxy = (uri) {
          return "PROXY $proxyUrl";
        };
        // 忽略证书错误
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }

    // 添加拦截器
    _addInterceptors();
  }

  void _addInterceptors() {
    // 请求拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 添加 Token
        String? token = await EStorage.getString("token");
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // 处理响应数据
        return handler.next(response);
      },
      onError: (error, handler) {
        // 统一错误处理
        return handler.next(error);
      },
    ));
  }

  // 设置请求头
  void setHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }

// 设置 baseUrl
  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  // GET 请求
  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(url, queryParameters: queryParameters);
  }

// POST 请求
  Future<Response> post(String url,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.post(url, data: data, queryParameters: queryParameters);
  }

// DELETE 请求
  Future<Response> delete(String url,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.delete(url, data: data, queryParameters: queryParameters);
  }

// PUT 请求
  Future<Response> put(String url,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.put(url, data: data, queryParameters: queryParameters);
  }

  // 下载文件
  Future<Response> downloadFile(String url, String savePath,
      {ProgressCallback? onReceiveProgress}) async {
    return await _dio.download(url, savePath,
        onReceiveProgress: onReceiveProgress);
  }

  // 上传文件
  Future<Response> uploadFile(String url, List<File> files,
      {Map<String, dynamic>? data}) async {
    List<MultipartFile> multipartFiles = files.map((file) {
      return MultipartFile.fromFileSync(file.path);
    }).toList();

    return await _dio.post(url,
        data: FormData.fromMap({
          'files': multipartFiles,
          ...?data,
        }));
  }
}
