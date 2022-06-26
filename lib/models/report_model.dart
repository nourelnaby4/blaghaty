class ReportModel {
  String ? id;
  String ? senderId;
  String ? vio;
  String ? state;
  String ?city;
  String ? description;
  String ?image;
  String ?reportStatus;
  String ?date;
  int ? reportCode;

  ReportModel({
    this.id,
    required this.senderId,
    required this.vio,
    required this.state,
    required this.city,
    required this.description,
    required this.image,
    required this.reportStatus,
    required this.date,
    required this.reportCode,

  });

  ReportModel.fromJson(Map<String, dynamic> json){
    id =json['id'];
    senderId =json['senderId'];
    vio =json['vio'];
    state =json['state'];
    city =json['city'];
    description =json['description'];
    image =json['image'];
    reportStatus =json['reportStatus'];
    date = json['date'];
    reportCode= json['reportCode'];
  }

  Map<String , dynamic> toMap(){
    return {
      'id':id,
      'senderId':senderId,
      'vio':vio,
      'state':state,
      'city':city,
      'description':description,
      'image':image,
      'reportStatus':reportStatus,
      'date':date,
      'reportCode':reportCode,
    };
  }
}