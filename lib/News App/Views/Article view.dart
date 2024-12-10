import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;


  const ArticleView({required this.blogUrl, Key? key}) : super(key: key);

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Validate the URL before loading
    Uri? uri = Uri.tryParse(widget.blogUrl);
    if (uri == null || !uri.isAbsolute) {
      // Handle invalid URL error (e.g., show error message)
      print('Invalid URL: ${widget.blogUrl}');
      // Optionally show an error UI to the user
      return;
    }
    _controller = WebViewController()
      ..loadRequest(Uri.parse(widget.blogUrl)); // Load the initial URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 60.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('H', style: TextStyle(fontWeight: FontWeight.bold),),
              Text('&', style: TextStyle(fontSize: 12),),
              Text(
                'N',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: WebViewWidget(
        controller: _controller, // Pass the controller to the WebViewWidget
      ),
    );
  }
}
