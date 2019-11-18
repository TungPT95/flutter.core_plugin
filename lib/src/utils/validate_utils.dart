///validate email
bool validateEmail(String email) =>
    RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);

///validate phone number
bool validatePhoneNumber(String phoneNo) =>
    RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(phoneNo);

bool isNullOrEmptyString(String input) => input == null || input.isEmpty;

bool isNotNullString(String input) => !isNullOrEmptyString(input);

bool isNullOrEmptyList(List input) => input == null || input.isEmpty;

bool isNotEmptyList(List input) => !isNullOrEmptyList(input);
