class TawkEventsJs {
  static String get onAgentJoinChat {
    String js = """
    window.Tawk_API.onAgentJoinChat = function(data){
    onAgentJoinChat.postMessage(JSON.stringify(data))
};
    """;
    return js;
  }

  static String get onChatMessageAgent {
    String js = """
    window.Tawk_API.onChatMessageAgent = function(data){
    onChatMessageAgent.postMessage(JSON.stringify(data))
};
    """;
    return js;
  }

  static String get onChatMessageVisitor {
    String js = """
    window.Tawk_API.onChatMessageVisitor = function(data){
    onChatMessageVisitor.postMessage(JSON.stringify(data))
};
    """;
    return js;
  }

  static String get onPrechatSubmit {
    String js = """
    window.Tawk_API.onPrechatSubmit = function(data){
    onPrechatSubmit.postMessage(JSON.stringify(data))
};
    """;
    return js;
  }

  static String get onOfflineSubmit {
    String js = """
    window.Tawk_API.onOfflineSubmit = function(data){
    onOfflineSubmit.postMessage(JSON.stringify(data))
};
    """;
    return js;
  }

  static String get onChatMessageSystem {
    String js = """
    window.Tawk_API.onChatMessageSystem = function(data){
    onChatMessageSystem.postMessage(JSON.stringify(data))
};
    """;
    return js;
  }

  static String get onAgentLeaveChat {
    String js = """
    window.Tawk_API.onAgentLeaveChat = function(data){
    onAgentLeaveChat.postMessage(JSON.stringify(data))
};
    """;
    return js;
  }

  static String get onChatSatisfaction {
    String js = """
    window.Tawk_API.onChatSatisfaction = function(data){
    onChatSatisfaction.postMessage(JSON.stringify(data))
};
    """;
    return js;
  }

  static String get onVisitorNameChanged {
    String js = """
    window.Tawk_API.onVisitorNameChanged = function(data){
    onVisitorNameChanged.postMessage(JSON.stringify(data))
};
    """;
    return js;
  }

  static String get onFileUpload {
    String js = """
    window.Tawk_API.onFileUpload = function(data){
    onFileUpload.postMessage(JSON.stringify(data))
};
    """;
    return js;
  }

  static List<String> get allJS => [
        onAgentJoinChat,
        onChatMessageAgent,
        onChatMessageVisitor,
        onPrechatSubmit,
        onOfflineSubmit,
        onChatMessageSystem,
        onAgentLeaveChat,
        onChatSatisfaction,
        onVisitorNameChanged,
        onFileUpload
      ];
}
