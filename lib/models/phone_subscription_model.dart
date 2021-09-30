class PhoneSubscription {
  int? id;
  String? month;
  String? networkTechnology;
  String? planType;
  int? subscriptions;

  PhoneSubscription(
      {this.id,
        this.month,
        this.networkTechnology,
        this.planType,
        this.subscriptions});

  PhoneSubscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    month = json['month'];
    networkTechnology = json['network_technology'];
    planType = json['plan_type'];
    subscriptions = json['subscriptions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['month'] = this.month;
    data['network_technology'] = this.networkTechnology;
    data['plan_type'] = this.planType;
    data['subscriptions'] = this.subscriptions;
    return data;
  }
}