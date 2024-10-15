import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'validators.dart';
import 'BMIservice.dart';
import 'BMImodel.dart';
import 'BMIresult.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BMI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FormBodyInfoPage(),
    );
  }
}

class FormBodyInfoPage extends StatefulWidget {
  const FormBodyInfoPage({Key? key}) : super(key: key);

  @override
  State<FormBodyInfoPage> createState() => _FormBodyInfoPageState();
}

class _FormBodyInfoPageState extends State<FormBodyInfoPage> {
  double _weight = 0, _height = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your BMI Information'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(22, 10, 20, 0),
                alignment: Alignment.topLeft,
                child: const Text('Your Weight(Kg.)'),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.-]')),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Weight(Kg.)',
                      hintText: 'input your weight for calculate BMI',
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {
                      _weight = double.parse(value);
                    },
                    validator: Validators.compose([
                      Validators.required('required number [0-9]'),
                      Validators.min(0, 'required number more than zero!')
                    ])),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(22, 5, 20, 0),
                alignment: Alignment.topLeft,
                child: const Text('Your Height(Cm.)'),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.-]')),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Height(Cm.)',
                      hintText: 'input your height in centimeter',
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {
                      _height = double.parse(value);
                    },
                    validator: Validators.compose([
                      Validators.required('required number [0-9]'),
                      Validators.min(100, 'required number more than 100 CM!')
                    ])),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // call method to calculate BMR and show the result
                            doProcess();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  doProcess() {
    BMIservice.calculateBMI(_weight, _height).then((value) {
      var bmrData = Bmidata(
          weight: _weight.toString(),
          height: _height.toString(),
          bmi: value.bmidata!.bmi,
          interpretation: value.bmidata!.interpretation);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BMIresultPage(bmidata: bmrData),
        ),
      );
    }).onError((error, stackTrace) {
      _showMessageDialog(context, 'ERROR: Calling API', error.toString());
    });
  }

  Future<dynamic> _showMessageDialog(
      BuildContext context, String headerMsg, String msg) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                headerMsg,
                style: const TextStyle(fontSize: 16),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(msg),
                  ],
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              actions: [
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ]);
        });
  }
}
