class Bahasa {
  int? id;
  String? bahasaAsli;
  String? bahasaTerjemah;
  String? namaTranslator;
  Bahasa({this.id, this.bahasaAsli, this.bahasaTerjemah, this.namaTranslator});
  factory Bahasa.fromJson(Map<String, dynamic> obj) {
    return Bahasa(
        id: obj['id'],
        bahasaAsli: obj['original_language'],
        bahasaTerjemah: obj['translated_language'],
        namaTranslator: obj['translator_name']);
  }
}
