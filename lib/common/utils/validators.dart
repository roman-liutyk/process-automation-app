class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  static final RegExp _nameRegExp = RegExp(r'^[a-zA-Z\s-]{2,}$');

  static String? required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? email(String? value) {
    final requiredCheck = required(value, 'Email');
    if (requiredCheck != null) return requiredCheck;

    final String trimmedValue = value!.trim();

    if (trimmedValue.length > 254) {
      return 'Email must not exceed 254 characters';
    }

    if (!_emailRegExp.hasMatch(trimmedValue)) {
      return 'Please enter a valid email address';
    }

    if (trimmedValue.contains('..')) {
      return 'Email cannot contain consecutive dots';
    }

    if (trimmedValue.contains('><\'"();')) {
      return 'Email contains invalid characters';
    }

    return null;
  }

  static String? password(String? value) {
    final requiredCheck = required(value, 'Password');
    if (requiredCheck != null) return requiredCheck;

    final String trimmedValue = value!.trim();

    if (trimmedValue.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (trimmedValue.length > 128) {
      return 'Password must not exceed 128 characters';
    }

    if (!_passwordRegExp.hasMatch(trimmedValue)) {
      return '''
Password must contain:
- At least one uppercase letter
- At least one lowercase letter
- At least one number
- At least one special character (@\$!%*?&)
''';
    }

    final Set<String> uniqueChars = trimmedValue.split('').toSet();
    if (uniqueChars.length < 4) {
      return 'Password must contain at least 4 unique \ncharacters';
    }

    if (_isCommonPassword(trimmedValue)) {
      return 'This password is too common. \nPlease choose a stronger password';
    }

    return null;
  }

  static String? name(String? value, String fieldName) {
    final requiredCheck = required(value, fieldName);
    if (requiredCheck != null) return requiredCheck;

    final String trimmedValue = value!.trim();

    if (trimmedValue.length < 2) {
      return '$fieldName must be at least 2 characters';
    }

    if (trimmedValue.length > 50) {
      return '$fieldName must not exceed 50 characters';
    }

    if (!_nameRegExp.hasMatch(trimmedValue)) {
      return '$fieldName can only contain letters, spaces, \nand hyphens';
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    final requiredCheck = required(value, 'Password confirmation');
    if (requiredCheck != null) return requiredCheck;

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  static bool _isCommonPassword(String password) {
    final List<String> commonPasswords = [
      'Password123!',
      'Qwerty123!',
      'Admin123!',
    ];
    return commonPasswords.contains(password);
  }

  static String sanitizeInput(String value) {
    return value.trim().replaceAll(RegExp(r'[<>"\;&]'), '').replaceAll(RegExp(r'\s+'), ' ');
  }
}
