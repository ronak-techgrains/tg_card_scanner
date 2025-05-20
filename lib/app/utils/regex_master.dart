class RegexMaster {
  static final emailRegex = RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');
  static final websiteRegExp = RegExp(r'\b(https?:\/\/|www\.)[^\s@]+(?<!mailto:[^\s]+)\b');
  static final phoneRegex = RegExp(r'(\+?\d{1,3})?[-.\s]?\(?\d{1,4}?\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,4}');

  static final zipCodeRegExp = RegExp(r'^(?:\d{5}(-\d{4})?|[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d|[A-Za-z]{1,2}\d{1,2}[A-Za-z]?\s?\d[A-Za-z]{2}|\d{4}|\d{6}|\d{3}-\d{4})$');
}
