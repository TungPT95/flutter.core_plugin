bool validateEmail(String email) =>
    RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);

bool validatePhoneNumber(String phoneNo) =>
    RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(phoneNo);
