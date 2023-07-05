import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://api.example.com';

  Future<dynamic> fetchData(String endpoint) async {
    final url = Uri.parse('$_baseUrl/$endpoint');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Successful response
      return response.body;
    } else {
      // Error handling
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> postData(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/$endpoint');

    final response = await http.post(
      url,
      body: data,
    );

    if (response.statusCode != 201) {
      // Error handling
      throw Exception('Failed to post data');
    }
  }
}
