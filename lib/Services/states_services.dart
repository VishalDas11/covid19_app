
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/WorldStateModel.dart';
import 'Utilities/app_url.dart';

class StatesServices{
  Future<WorldStateModel> fetchWorldStateData () async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);

        return WorldStateModel.fromJson(data);
    }
    else{
      throw Exception('Error');
    }
  }


  Future<List<dynamic>> CountriesListApi () async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception('Error');
    }
  }
}