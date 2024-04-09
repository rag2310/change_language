import 'package:bloc/bloc.dart';
import 'package:change_language/repository/change_language_repository.dart';

part 'change_language_event.dart';

part 'change_language_state.dart';

class ChangeLanguageBloc
    extends Bloc<ChangeLanguageEvent, ChangeLanguageState> {
  ChangeLanguageBloc(
      {required ChangeLanguageRepository changeLanguageRepository})
      : _changeLanguageRepository = changeLanguageRepository,
        super(ChangeLanguageState()) {
    on<ChangeLanguageEventInit>(_onChangeLanguageEventInit);
    on<ChangeLanguageEventOnChangeEnglish>(
        _onChangeLanguageEventOnChangeEnglish);
    on<ChangeLanguageEventOnChangeSpanish>(
        _onChangeLanguageEventOnChangeSpanish);
  }

  final ChangeLanguageRepository _changeLanguageRepository;

  Future<void> _onChangeLanguageEventInit(
      ChangeLanguageEventInit event, Emitter<ChangeLanguageState> emit) async {
    String lang = await _changeLanguageRepository.getLanguage();
    emit(state.copyWith(currentLanguage: lang));
  }

  Future<void> _onChangeLanguageEventOnChangeEnglish(
      ChangeLanguageEventOnChangeEnglish event,
      Emitter<ChangeLanguageState> emit) async {
    await _changeLanguageRepository.changeLanguageEnglish();
    emit(state.copyWith(currentLanguage: "en"));
  }

  Future<void> _onChangeLanguageEventOnChangeSpanish(
      ChangeLanguageEventOnChangeSpanish event,
      Emitter<ChangeLanguageState> emit) async {
    await _changeLanguageRepository.changeLanguageSpanish();
    emit(state.copyWith(currentLanguage: "es"));
  }
}
