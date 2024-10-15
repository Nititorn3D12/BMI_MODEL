// ignore_for_file: file_names
import 'package:http/http.dart' as http;
import 'dart:convert';
// TODO: import BMRmodel.dart
import 'BMImodel.dart';


class BMIservice {
  static Future<BMImodel> calculateBMI(double weight, double height) async {
    var parameters = 'weight=$weight&height=$height';
    var api = 'https://pirun.ku.ac.th/~faaspsu/edu/mobile/calculatebmi.php';
    var url = Uri.parse('$api?$parameters');


    // TODO: call API using http library
    //       and keep response message into variable
    var response = await http.get(url); //รอส่งประมวลผลและรอค่ากลับ   // await ต้องมี async


    Map<String, dynamic> jsondata = json.decode(response.body);


    // TODO: map JSON message into BMRModel
     BMImodel result = BMImodel.fromJson(jsondata);


    return result;
  }
}
