import 'dart:convert';
import 'package:http/http.dart' ;
class Network{
  Network(this.url);
  final url;
  Future<dynamic> getConnection() async {
    Response response = await get(Uri.parse(url));
    if(response.statusCode==200)
    {
      String data = response.body;
      var decodeData = jsonDecode(data);
      print(decodeData);
      return decodeData;
    }
    else
    {
      return null;
    }
  }
}

