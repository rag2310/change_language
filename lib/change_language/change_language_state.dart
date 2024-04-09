part of 'change_language_bloc.dart';

class ChangeLanguageState {
  final String currentLanguage;

  ChangeLanguageState({this.currentLanguage = "en"});

  ChangeLanguageState copyWith({String? currentLanguage}) {
    return ChangeLanguageState(
        currentLanguage: currentLanguage ?? this.currentLanguage);
  }
}
