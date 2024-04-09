part of 'change_language_bloc.dart';

sealed class ChangeLanguageEvent {}

final class ChangeLanguageEventInit extends ChangeLanguageEvent {}

final class ChangeLanguageEventOnChangeEnglish extends ChangeLanguageEvent {}

final class ChangeLanguageEventOnChangeSpanish extends ChangeLanguageEvent {}
