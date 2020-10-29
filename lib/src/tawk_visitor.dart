class TawkVisitor {
  final String name;
  final String email;
  final String hash;

  TawkVisitor({
    this.name,
    this.email,
    this.hash,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (name != null) {
      data['name'] = name;
    }

    if (email != null) {
      data['email'] = email;
    }

    if (hash != null) {
      data['hash'] = hash;
    }

    return data;
  }
}
