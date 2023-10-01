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
  bool isloading = false;
  TextEditingController? controller;
  PullToRefreshController? refreshController;

  @override
  void initState() {
    // TODO: implement initState
    // print(widget.url.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("News app"),
        leading: InkWell(
            child: Icon(Icons.arrow_back_ios_new_outlined),
            onTap: () {
              webViewController!.goBack();
            }),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              print("reload");
              webViewController?.reload();
            },
          ),
          Padding(padding: EdgeInsets.only(right: 5))
        ],
      ),
      body: Stack(alignment: Alignment.center, children: [
        InAppWebView(
          onPageCommitVisible: (controller, url) {
            setState(() {
              isloading = false;
            });
          },
          onWebViewCreated: (controller) {
            webViewController = controller;
            setState(() {
              isloading = true;
            });
          },
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
        ),
        Visibility(
          child: CircularProgressIndicator(),
          visible: isloading,
        )
      ]),
    );
  }
}
