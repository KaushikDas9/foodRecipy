import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class webViewDesign extends StatefulWidget {
  final String url;
  const webViewDesign(this.url, {super.key});

  @override
  State<webViewDesign> createState() => _webViewDesignState();
}

class _webViewDesignState extends State<webViewDesign> {
  late String a;
  InAppWebViewController? webViewController;

  TextEditingController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    a = widget.url;
    if (a.contains("http")) {
      a.replaceAll("http", "https");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("News app"),
      ),
      body: InAppWebView(
        onWebViewCreated: (controller) => {webViewController = controller},
        initialUrlRequest: URLRequest(url: Uri.parse(a)),
      ),
    );
  }
}
