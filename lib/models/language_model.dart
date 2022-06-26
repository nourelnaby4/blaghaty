class LanguageModel {
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  LanguageModel({required this.id,
    required this.name,
    required this.flag,
    required this.languageCode});

  static List<LanguageModel> languageList() {
    return <LanguageModel>[
      LanguageModel(
          id: 1,
          name: 'English',
          flag: _getCountryFlag('US'),
          languageCode: 'en'),
      LanguageModel(id: 2, name: 'Arabic', flag: _getCountryFlag('EG'), languageCode: 'ar'),
    ];
  }

  static String _getCountryFlag(String code) {
    return code.replaceAllMapped(RegExp(r'[A-Z]'), (match) =>
        String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
  }
}
