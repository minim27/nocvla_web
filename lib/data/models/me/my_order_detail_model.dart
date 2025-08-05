class MyOrderDetailModel {
  dynamic id,
      date,
      statusId,
      statusName,
      invoiceNo,
      payment,
      shippingId,
      noResi,
      address,
      items,
      subTotal,
      shippingFee,
      totalAmount;

  MyOrderDetailModel({
    this.id,
    this.date,
    this.statusId,
    this.statusName,
    this.invoiceNo,
    this.payment,
    this.shippingId,
    this.noResi,
    this.address,
    this.items,
    this.subTotal,
    this.shippingFee,
    this.totalAmount,
  });

  MyOrderDetailModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    date = json["date"];
    statusId = json["status_id"];
    statusName = json["status_name"];
    invoiceNo = json["invoice_no"];
    payment = json["payment"];
    shippingId = json["shipping_id"];
    noResi = json["no_resi"];
    address = json["address"];
    items = json["items"];
    subTotal = json["sub_total"];
    shippingFee = json["shipping_fee"];
    totalAmount = json["total_amount"];
  }
}
