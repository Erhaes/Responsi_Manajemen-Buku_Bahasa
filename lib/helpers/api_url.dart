class ApiUrl {
  static const String baseUrl = 'http://responsi.webwizards.my.id/api'; 

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listBahasa = baseUrl + '/buku/bahasa';
  static const String tambahBahasa = baseUrl + '/buku/bahasa';

  static String updateBahasa(int id) {
    return baseUrl + '/buku/bahasa/' + id.toString(); 
  }

  static String getBahasa(int id) {
    return baseUrl + '/buku/bahasa/' + id.toString(); 
  }

  static String deleteBahasa(int id) {
    return baseUrl + '/buku/bahasa/' + id.toString(); 
  }
}
