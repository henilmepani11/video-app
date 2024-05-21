extension EaxString on String {
  bool isEmailValid() {
    return !RegExp(
            r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
        .hasMatch(this);
  }
}
