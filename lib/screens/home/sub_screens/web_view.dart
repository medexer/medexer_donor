// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/social_media_Index.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final SocialMediaIndex socialmedia;

  const WebViewPage({super.key, required this.socialmedia});
  //const WebViewPagek({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  var loadingPercentage = 0;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse(widget.socialmedia.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:15.0),
      child: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}

// class WebViewPage extends StatefulWidget {
//   final Aid aid;
//   const WebViewPage({super.key, required this.aid});

//   @override
//   State<WebViewPage> createState() => _WebViewPageState();
// }

// class _WebViewPageState extends State<WebViewPage> {
//   late final WebViewController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..loadRequest(
//         Uri.parse(widget.aid.url),
//       );
//   }
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WebViewWidget(
//         controller: controller,
//       ),
//     );
//   }
// }