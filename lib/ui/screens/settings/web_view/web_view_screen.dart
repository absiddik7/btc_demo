import 'package:flutter/material.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String webUrl;
  const WebViewScreen({super.key, required this.title, required this.webUrl});
  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          if (mounted) {
            setState(() {
              isLoading = progress < 100;
            });
          }
        },
        onPageStarted: (String url) {
          if (mounted) {
            setState(() {
              isLoading = true;
            });
          }
        },
        onPageFinished: (String url) {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        },
      ))
      ..loadRequest(
        Uri.parse(widget.webUrl),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: widget.title,
          ),
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(controller: controller),
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
