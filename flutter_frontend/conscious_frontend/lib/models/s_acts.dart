enum SeverityLevel {
  low,
  medium,
  high,
}

class SActs{
  String? category;
  String? description;
  SeverityLevel? severity;

  SActs({
    this.category,
    this.description,
    this.severity,
  });

  SActs.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    description = json['description'];
    switch(json['severity']){
      case 'low':
        severity = SeverityLevel.low;
        break;
      case 'medium':
        severity = SeverityLevel.medium;
        break;
      case 'high':
        severity = SeverityLevel.high;
        break;
      default:
        severity = null;
    }
  }
}

class Company{
  String? company_name;
  String? description;
  List<SActs>? s_acts;

  Company({
    this.company_name,
    this.description,
    this.s_acts,
  });

  Map<String, dynamic> toJson() {
    return {
      'company_name': company_name,
      'description': description,
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

  Company.fromJson(Map<String, dynamic> json) {
    company_name = json['company_name'];
    description = json['description'];
    if (json['s_acts'] != null) {
      s_acts = <SActs>[];
      json['s_acts'].forEach((v) {
        s_acts!.add(SActs.fromJson(v));
      });
    }
  }
}

