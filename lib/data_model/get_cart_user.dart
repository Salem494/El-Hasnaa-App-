class getCartUser {
  String? id;
  String? ip;
  String? userId;
  String? prodId;
  String? prodNo;
  String? prodPrice;
  String? total;
  String? addDate;
  String? basketSet;
  String? orderId;
  String? prodColor;
  String? prodSize;
  String? userMac;
  String? coinId;
  String? vendorId;

  getCartUser(
      {
        this.id,
        this.ip,
        this.userId,
        this.prodId,
        this.prodNo,
        this.prodPrice,
        this.total,
        this.addDate,
        this.basketSet,
        this.orderId,
        this.prodColor,
        this.prodSize,
        this.userMac,
        this.coinId,
        this.vendorId});

  getCartUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ip = json['ip'];
    userId = json['user_id'];
    prodId = json['prod_id'];
    prodNo = json['prod_no'];
    prodPrice = json['prod_price'];
    total = json['total'];
    addDate = json['add_date'];
    basketSet = json['basket_set'];
    orderId = json['order_id'];
    prodColor = json['prod_color'];
    prodSize = json['prod_size'];
    userMac = json['user_mac'];
    coinId = json['coin_id'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ip'] = this.ip;
    data['user_id'] = this.userId;
    data['prod_id'] = this.prodId;
    data['prod_no'] = this.prodNo;
    data['prod_price'] = this.prodPrice;
    data['total'] = this.total;
    data['add_date'] = this.addDate;
    data['basket_set'] = this.basketSet;
    data['order_id'] = this.orderId;
    data['prod_color'] = this.prodColor;
    data['prod_size'] = this.prodSize;
    data['user_mac'] = this.userMac;
    data['coin_id'] = this.coinId;
    data['vendor_id'] = this.vendorId;
    return data;
  }
}