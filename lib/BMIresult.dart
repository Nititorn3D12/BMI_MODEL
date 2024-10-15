// ignore: file_names
import 'package:flutter/material.dart';


// TODO: import BMRModel.dart
import 'BMImodel.dart';


// ignore: must_be_immutable
class BMIresultPage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  // BMRresultPage({Key? key});
  // TODO: add new parameter for storing bmrdata from caller
  BMIresultPage({Key? key, required this.bmidata});


  Bmidata bmidata;
  // TODO: declare parameter to keep bmrdata


  @override
  State<BMIresultPage> createState() => _BMIresultPageState();
}


class _BMIresultPageState extends State<BMIresultPage> {
  late var _weight, _height, _bmi, _interpretation;


  @override
  void initState() {
    super.initState();
    // TODO: initialize variables for displaying on listtile
    // move bmrdata into variables for showing ...here...
    _weight = widget.bmidata.weight!;
    _height = widget.bmidata.height!;
    _bmi = widget.bmidata.bmi!;
    _interpretation =widget.bmidata.interpretation!;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Result of Your BMI'),
        ),
        body: ListView(
          children: [
            ListTile(
              title: const Text('Weight:'),
              subtitle: Text('$_weight'),
              leading: const Icon(Icons.scale_outlined),
            ),
            ListTile(
              title: const Text('Height:'),
              subtitle: Text('$_height'),
              leading: const Icon(Icons.arrow_upward),
            ),
              ListTile(
              title: const Text('BMI:'),
              subtitle: Text('$_bmi'),
              leading: const Icon(Icons.receipt_long),
            ),
             ListTile(
              title: const Text('Interpretation:'),
              subtitle: Text('$_interpretation'),
              leading: const Icon(Icons.admin_panel_settings),
            ),
          ],
        ));
  }
}
