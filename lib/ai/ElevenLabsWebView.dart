import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:permission_handler/permission_handler.dart';

class ElevenLabsWebView extends StatefulWidget {
  const ElevenLabsWebView({super.key});

  @override
  State<ElevenLabsWebView> createState() => _ElevenLabsWebViewState();
}

class _ElevenLabsWebViewState extends State<ElevenLabsWebView> {
  WebViewController? _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  Future<void> _initWebView() async {
    // 1. طلب إذن الميكروفون من نظام الأندرويد أولاً
    var status = await Permission.microphone.request();
    if (status.isDenied) {
      // تنبيه المستخدم إذا رفض الإذن
      return;
    }

    // 2. إعداد الكنترولر
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            if (mounted) setState(() => _isLoading = false);
          },
        ),
      );

    // 3. إجبار الأندرويد على الموافقة على طلبات الميكروفون من داخل الـ WebView
    if (controller.platform is AndroidWebViewController) {
      final androidController = controller.platform as AndroidWebViewController;

      await androidController.setMediaPlaybackRequiresUserGesture(false);

      await androidController.setOnPlatformPermissionRequest(
            (PlatformWebViewPermissionRequest request) {
          // هاتفياً: الموافقة الإجبارية على طلب الـ JavaScript للوصول للمايك
          request.grant();
        },
      );
    }

    // 4. تحميل الكود مع استخدام baseUrl لخدع المتصفح وتفعيل getUserMedia
    await controller.loadHtmlString('''
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
        <style>
          body { margin: 0; padding: 0; display: flex; justify-content: center; align-items: center; height: 100vh; background-color: white; }
          /* تأكد من أن الـ widget يظهر بشكل صحيح */
          elevenlabs-convai { width: 100%; height: 100%; }
        </style>
      </head>
      <body>
        <elevenlabs-convai agent-id="agent_7001k85skwdre9v91v9sxd50qva9"></elevenlabs-convai>
        <script src="https://elevenlabs.io/convai-widget/index.js" async type="text/javascript"></script>
      </body>
      </html>
    ''',
        baseUrl: "https://elevenlabs.io" // السطر ده هو "كلمة السر" لحل مشكلة undefined
    );

    if (mounted) {
      setState(() {
        _controller = controller;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ElevenLabs AI"),
        centerTitle: true,
      ),
      body: _controller == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          WebViewWidget(controller: _controller!),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}