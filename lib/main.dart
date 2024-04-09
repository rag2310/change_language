import 'package:change_language/app_localizations.dart';
import 'package:change_language/app_localizations_delegate.dart';
import 'package:change_language/change_language/change_language_bloc.dart';
import 'package:change_language/repository/change_language_repository.dart';
import 'package:change_language/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _selectedLocale = const Locale("es");
  late final ChangeLanguageRepository _changeLanguageRepository;

  @override
  void initState() {
    super.initState();
    _changeLanguageRepository = ChangeLanguageRepository();
    //TODO se carga el lenguaje del sharedpreferences en caso de q no existe se pasa "en"
    _changeLanguageRepository
        .getLanguage()
        .then((value) => changeLanguage(Locale(value)));
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _changeLanguageRepository,
      child: BlocProvider(
        create: (context) => ChangeLanguageBloc(
            changeLanguageRepository: _changeLanguageRepository),
        //TODO Creamos el wiget blocListener para escuchar el cambio de lenguaje y modificar las demas pantallas
        child: BlocListener<ChangeLanguageBloc, ChangeLanguageState>(
          listener: (context, state) {
            changeLanguage(Locale(state.currentLanguage));
          },
          child: MaterialApp(
            initialRoute: "/home",
            routes: routes,
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: const [
              Locale("en", ""),
              Locale("es", ""),
            ],
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            builder: (context, child) {
              return Container(
                child: child,
              );
            },
            locale: _selectedLocale,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }

  void changeLanguage(Locale newLocale) {
    setState(() {
      _selectedLocale = newLocale;
    });
  }
}

class _AppChangeLanguage extends StatefulWidget {
  const _AppChangeLanguage({super.key});

  @override
  State<_AppChangeLanguage> createState() => _AppChangeLanguageState();
}

class _AppChangeLanguageState extends State<_AppChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ChangeLanguageBloc, ChangeLanguageState>(
          builder: (context, state) {
            return Center(
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        context
                            .read<ChangeLanguageBloc>()
                            .add(ChangeLanguageEventOnChangeSpanish());
                      },
                      child: Text(context.getString("spanish"))),
                  ElevatedButton(
                      onPressed: () {
                        context
                            .read<ChangeLanguageBloc>()
                            .add(ChangeLanguageEventOnChangeEnglish());
                      },
                      child: Text(context.getString("english"))),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/a");
                      },
                      child: Text(context.getString("nav_another_screen"))),
                  Text(context.getString("hello"))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

//TODO esta pantalla como se puede observar se puede ver el cambio de lenguaje aplicado
class _AnotherPage extends StatelessWidget {
  const _AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(context.getString("hello")),
            Text(context.getString("welcome")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(context.getString("back")))
          ],
        ),
      ),
    );
  }
}

Map<String, WidgetBuilder> routes = {
  "/home": (context) => const _AppChangeLanguage(),
  "/a": (context) => const _AnotherPage()
};
