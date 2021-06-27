import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences _preferences;

  static const _keyTaxaSelic = 'taxa_selic';
  static const _keyPorcentagemCDI = 'porcentagem_cdi';
  static const _keyValorTotal = 'valor_total';
  static const _keyQuantidadeDeMeses = 'quantidade_meses';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future definirTaxaSelic(double taxaSelic) async =>
      await _preferences.setDouble(_keyTaxaSelic, taxaSelic);

  static double obterTaxaSelic() => _preferences.getDouble(_keyTaxaSelic);

  static Future definirPorcentagemCDI(double porcentagemCDI) async =>
      await _preferences.setDouble(_keyPorcentagemCDI, porcentagemCDI);

  static double obterPorcentagemCDI() =>
      _preferences.getDouble(_keyPorcentagemCDI);

  static Future definirValorTotal(int valorTotal) async =>
      await _preferences.setInt(_keyValorTotal, valorTotal);

  static int obterValorTotal() => _preferences.getInt(_keyValorTotal);

  static Future definirQuantidadeDeMeses(int quantidadeDeMeses) async =>
      await _preferences.setInt(_keyQuantidadeDeMeses, quantidadeDeMeses);

  static int obterQuantidadeDeMeses() =>
      _preferences.getInt(_keyQuantidadeDeMeses);

  // Método genérico para definição de Double
  static Future setDouble(String name, double novoDouble) async =>
      await _preferences.setDouble(name, novoDouble);

  // Método genérico para obter Double
  static double getDouble(String name) => _preferences.getDouble(name) ?? 0;

/*
  static String getUsername() => _preferences.getString(_keyUsername);

  static Future setPets(List<String> pets) async =>
      await _preferences.setStringList(_keyPets, pets);

  static List<String> getPets() => _preferences.getStringList(_keyPets);

  static Future setBirthday(DateTime dateOfBirth) async {
    final birthday = dateOfBirth.toIso8601String();

    return await _preferences.setString(_keyBirthday, birthday);
  }

  static DateTime getBirthday() {
    final birthday = _preferences.getString(_keyBirthday);

    return birthday == null ? null : DateTime.tryParse(birthday);
  }

  static Future<void> setBool(String name, bool b) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(name, b);
  }

  static Future<bool> getBool(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(name) ?? true;
  }

  static Future<void> setString(String name, String text) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(name, text);
  }

  static Future<String> getString(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(name);
  }

  static Future<void> setStringList(String name, List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(name, list);
  }

  static Future<List<String>> getStringList(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(name) ?? [];
  }

  static Future<int> getInt(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(name) ?? 0;
  }

  static Future<void> setInt(String name, int newInt) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(name, newInt);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
  */
}
