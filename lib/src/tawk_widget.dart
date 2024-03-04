import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'tawk_visitor.dart';

/// [Tawk] Widget.
class Tawk extends StatefulWidget {
  /// Tawk direct chat link.
  final String directChatLink;

  /// Object used to set the visitor name and email.
  final TawkVisitor? visitor;

  /// Called right after the widget is rendered.
  final Function? onLoad;

  /// Called when a link pressed.
  final Function(String)? onLinkTap;

  /// Render your own loading widget.
  final Widget? placeholder;

  const Tawk({
    super.key,
    required this.directChatLink,
    this.visitor,
    this.onLoad,
    this.onLinkTap,
    this.placeholder,
  });

  @override
  @override
  State<Tawk> createState() => _TawkState();
}

class _TawkState extends State<Tawk> {
  late final WebViewController _controller;
  bool _isLoading = true;

  void _setUser(TawkVisitor visitor) async {
    final json = jsonEncode(visitor);
    String javascriptString;

    if (Platform.isIOS) {
      javascriptString = '''
        Tawk_API = Tawk_API || {};
        Tawk_API.setAttributes($json);
      ''';
    } else {
      javascriptString = '''
        Tawk_API = Tawk_API || {};
        Tawk_API.onLoad = function() {
          Tawk_API.setAttributes($json);
        };
      ''';
    }
    try {
      await _controller.runJavaScript(javascriptString);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    _controller = WebViewController();
    callFunction();
    // TODO: implement initState
    super.initState();
  }

  Future<void> callFunction() async {
    try {
      _controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(widget.directChatLink))
        ..setNavigationDelegate(
          NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) {
              if (request.url == 'about:blank' ||
                  request.url.contains('tawk.to')) {
                return NavigationDecision.navigate;
              }

              if (widget.onLinkTap != null) {
                widget.onLinkTap!(request.url);
              }

              return NavigationDecision.prevent;
            },
            onPageFinished: (_) {
              if (widget.visitor != null) {
                _setUser(widget.visitor!);
              }

              if (widget.onLoad != null) {
                widget.onLoad!();
              }

              setState(() {
                _isLoading = false;
              });
            },
          ),
        );
    } catch (e) {
      log("call function issue $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: _controller,
        ),
        _isLoading
            ? widget.placeholder ??
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
            : Container(),
      ],
    );
  }
}
