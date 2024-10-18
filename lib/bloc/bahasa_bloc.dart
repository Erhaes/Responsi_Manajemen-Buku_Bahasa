import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/bahasa.dart';

class BahasaBloc {
  static Future<List<Bahasa>> getBahasas() async {
    String apiUrl = ApiUrl.listBahasa;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listBahasa = (jsonObj as Map<String, dynamic>)['data'];
    List<Bahasa> bahasas = [];
    for (int i = 0; i < listBahasa.length; i++) {
      bahasas.add(Bahasa.fromJson(listBahasa[i]));
    }
    return bahasas;
  }

  static Future addBahasa({Bahasa? bahasa}) async {
    String apiUrl = ApiUrl.tambahBahasa;

    var body = {
      "original_language": bahasa!.bahasaAsli,
      "translated_language": bahasa.bahasaTerjemah,
      "translator_name": bahasa.namaTranslator,
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateBahasa({required Bahasa bahasa}) async {
    String apiUrl = ApiUrl.updateBahasa(bahasa.id!);
    print(apiUrl);

    var body = {
      "original_language": bahasa.bahasaAsli,
      "translated_language": bahasa.bahasaTerjemah,
      "translator_name": bahasa.namaTranslator,
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteBahasa({int? id}) async {
    String apiUrl = ApiUrl.deleteBahasa(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
