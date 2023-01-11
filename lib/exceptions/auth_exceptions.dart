class GenericAuthException implements Exception {}

// Login Exceptions

class InvalidEmailAuthException implements Exception {}

class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

class TooManyRequestsException implements Exception {}

// Register Exceptions

class MissingEmailException implements Exception {}

class NoPasswordProvidedAuthException implements Exception {}

class NoConfirmPasswordProvidedAuthException implements Exception {}

class PasswordsDontMatchAuthException implements Exception {}

class EmailAlreadyExistsAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

class NoFunctionalityException implements Exception {}