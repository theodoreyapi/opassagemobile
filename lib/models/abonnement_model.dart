class AbonnementModel {
  int? idSubscriptionPlan;
  String? name;
  String? price;
  String? durationType;

  AbonnementModel({
    this.idSubscriptionPlan,
    this.name,
    this.price,
    this.durationType,
  });

  AbonnementModel.fromJson(Map<String, dynamic> json) {
    idSubscriptionPlan = json['id_subscription_plan'];
    name = json['name'];
    price = json['price'];
    durationType = json['duration_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_subscription_plan'] = idSubscriptionPlan;
    data['name'] = name;
    data['price'] = price;
    data['duration_type'] = durationType;
     return data;
  }
}
