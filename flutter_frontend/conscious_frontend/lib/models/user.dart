import 's_acts.dart';
class User{
  String? name;
  String? email;
  List<SActs>? s_acts;

  User({
    this.name,
    this.email,
    this.s_acts,
  });
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      's_acts': s_acts?.map((s_act) => {
        'category': s_act.category,
        'description': s_act.description,
        'severity': switch(s_act.severity){
          SeverityLevel.low => 'low',
          SeverityLevel.medium => 'medium',
          SeverityLevel.high => 'high',
          null => null
        }
      }).toList(),
    };
  }
  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    if (json['s_acts'] != null) {
      s_acts = <SActs>[];
      json['s_acts'].forEach((v) {
        s_acts!.add(SActs.fromJson(v));
      });
    }
  }
}