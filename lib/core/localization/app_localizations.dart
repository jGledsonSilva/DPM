// Arquivo para gerenciar as strings do aplicativo
import 'package:flutter/material.dart';
import 'app_strings_interface.dart';
import 'pt_br_strings.dart';
import 'en_us_strings.dart';
import 'es_es_strings.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppStrings getStrings(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return EnUsAppStrings();
      case 'es':
        return EsEsAppStrings();
      case 'pt':
      default:
        return PtBrAppStrings();
    }
  }

  static AppStrings of(BuildContext context) {
    // Primeiro, tenta obter o Locale do contexto.
    final locale = Localizations.localeOf(context);
    // Se não houver um Locale no contexto (o que é improvável em um MaterialApp bem configurado),
    // você pode retornar um idioma padrão ou lançar um erro.
    // Aqui, retornaremos o português como padrão se nenhum locale for encontrado.
    return getStrings(locale);
  }
}

// Delegate para ser usado no MaterialApp
class AppLocalizationsDelegate extends LocalizationsDelegate<AppStrings> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  Future<AppStrings> load(Locale locale) async {
    return AppLocalizations.getStrings(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
