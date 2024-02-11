import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tawk/src/tawk_events_js.dart';
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

  /// onAgentJoinChat
  final ValueChanged? onAgentJoinChat;

  /// onChatMessageAgent
  final ValueChanged? onChatMessageAgent;

  /// onChatMessageVisitor
  final ValueChanged? onChatMessageVisitor;

  /// onPrechatSubmit
  final ValueChanged? onPrechatSubmit;

  /// onOfflineSubmit
  final ValueChanged? onOfflineSubmit;

  /// onChatMessageSystem
  final ValueChanged? onChatMessageSystem;

  /// onAgentLeaveChat
  final ValueChanged? onAgentLeaveChat;

  /// onChatSatisfaction
  final ValueChanged? onChatSatisfaction;

  /// onVisitorNameChanged
  final ValueChanged? onVisitorNameChanged;

  /// onFileUpload
  final ValueChanged? onFileUpload;

  const Tawk(
      {Key? key,
      required this.directChatLink,
      this.visitor,
      this.onLoad,
      this.onLinkTap,
      this.placeholder,
      this.onAgentJoinChat,
      this.onAgentLeaveChat,
      this.onChatMessageAgent,
      this.onChatMessageSystem,
      this.onChatMessageVisitor,
      this.onChatSatisfaction,
      this.onFileUpload,
      this.onOfflineSubmit,
      this.onPrechatSubmit,
      this.onVisitorNameChanged})
      : super(key: key);

  @override
  _TawkState createState() => _TawkState();
}

class _TawkState extends State<Tawk> {
  late WebViewController _controller;
  bool _isLoading = true;

  void _setUser(TawkVisitor visitor) {
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

    _controller.runJavascript(javascriptString);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: widget.directChatLink,
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: {
            JavascriptChannel(
                name: "onAgentJoinChat",
                onMessageReceived: (e) {
                  if (widget.onAgentJoinChat != null) {
                    widget.onAgentJoinChat!(jsonDecode(e.message));
                  }
                }),
            JavascriptChannel(
                name: "onChatMessageAgent",
                onMessageReceived: (e) {
                  if (widget.onChatMessageAgent != null) {
                    widget.onChatMessageAgent!(jsonDecode(e.message));
                  }
                }),
            JavascriptChannel(
                name: "onChatMessageVisitor",
                onMessageReceived: (e) {
                  if (widget.onChatMessageVisitor != null) {
                    widget.onChatMessageVisitor!(jsonDecode(e.message));
                  }
                }),
            JavascriptChannel(
                name: "onPrechatSubmit",
                onMessageReceived: (e) {
                  if (widget.onPrechatSubmit != null) {
                    widget.onPrechatSubmit!(jsonDecode(e.message));
                  }
                }),
            JavascriptChannel(
                name: "onOfflineSubmit",
                onMessageReceived: (e) {
                  if (widget.onOfflineSubmit != null) {
                    widget.onOfflineSubmit!(jsonDecode(e.message));
                  }
                }),
            JavascriptChannel(
                name: "onChatMessageSystem",
                onMessageReceived: (e) {
                  if (widget.onChatMessageSystem != null) {
                    widget.onChatMessageSystem!(jsonDecode(e.message));
                  }
                }),
            JavascriptChannel(
                name: "onAgentLeaveChat",
                onMessageReceived: (e) {
                  if (widget.onAgentLeaveChat != null) {
                    widget.onAgentLeaveChat!(jsonDecode(e.message));
                  }
                }),
            JavascriptChannel(
                name: "onChatSatisfaction",
                onMessageReceived: (e) {
                  if (widget.onChatSatisfaction != null) {
                    widget.onChatSatisfaction!(jsonDecode(e.message));
                  }
                }),
            JavascriptChannel(
                name: "onVisitorNameChanged",
                onMessageReceived: (e) {
                  if (widget.onVisitorNameChanged != null) {
                    widget.onVisitorNameChanged!(jsonDecode(e.message));
                  }
                }),
            JavascriptChannel(
                name: "onFileUpload",
                onMessageReceived: (e) {
                  if (widget.onFileUpload != null) {
                    widget.onFileUpload!(jsonDecode(e.message));
                  }
                })
          },
          onWebViewCreated: (WebViewController webViewController) {
            setState(() {
              _controller = webViewController;
            });
          },
          navigationDelegate: (NavigationRequest request) {
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

            for (var event in TawkEventsJs.allJS) {
              _controller.runJavascript(event);
            }

            setState(() {
              _isLoading = false;
            });
          },
        ),
        _isLoading
            ? widget.placeholder ??
                const Center(
                  child: CircularProgressIndicator(),
                )
            : Container(),
      ],
    );
  }
}
