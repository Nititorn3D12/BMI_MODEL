class BMImodel {
  String? title;
  Bmidata? bmidata;

  BMImodel({this.title, this.bmidata});

  BMImodel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    bmidata =
        json['bmidata'] != null ? new Bmidata.fromJson(json['bmidata']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.bmidata != null) {
      data['bmidata'] = this.bmidata!.toJson();
    }
    return data;
  }
}

class Bmidata {
  String? weight;
  String? height;
  double? bmi;
  String? interpretation;

  Bmidata({this.weight, this.height, this.bmi, this.interpretation});

  Bmidata.fromJson(Map<String, dynamic> json) {
    weight = json['weight'];
    height = json['height'];
    bmi = json['bmi'];
    interpretation = json['interpretation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['bmi'] = this.bmi;
    data['interpretation'] = this.interpretation;
    return data;
  }
}
