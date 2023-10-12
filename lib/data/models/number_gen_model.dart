class NumGenerateModel {
  String? id;
  String? date;
  String? generatedNum;
  String? ipAddress;
  String? location;

  NumGenerateModel({
    this.id,
    this.date,
    this.generatedNum,
    this.ipAddress,
    this.location,
  });

  NumGenerateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    generatedNum = json['generatedNum'];
    ipAddress = json['ipAddress'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['generatedNum'] = generatedNum;
    data['ipAddress'] = ipAddress;
    data['location'] = location;

    return data;
  }
}
