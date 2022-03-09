class MyOrders {
  String? id;
  String? userId;
  String? orderSet;
  String? orderDate;
  String? total;
  String? orderTime;
  String? fileUrl;
  String? userMac;
  String? notes;
  String? ip;
  String? orderCurency;

  MyOrders(
      {this.id,
      this.userId,
      this.orderSet,
      this.orderDate,
      this.total,
      this.orderTime,
      this.fileUrl,
      this.userMac,
      this.notes,
      this.ip,
      this.orderCurency});

  MyOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderSet = json['order_set'];
    orderDate = json['order_date'];
    total = json['total'];
    orderTime = json['order_time'];
    fileUrl = json['file_url'];
    userMac = json['user_mac'];
    notes = json['notes'];
    ip = json['ip'];
    orderCurency = json['order_curency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['order_set'] = this.orderSet;
    data['order_date'] = this.orderDate;
    data['total'] = this.total;
    data['order_time'] = this.orderTime;
    data['file_url'] = this.fileUrl;
    data['user_mac'] = this.userMac;
    data['notes'] = this.notes;
    data['ip'] = this.ip;
    data['order_curency'] = this.orderCurency;
    return data;
  }
}
