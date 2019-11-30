import 'cart_goods_query_entity.dart';

class OrderEntity {
  List<OrderModel>   orderModel;
  OrderEntity({this.orderModel});

  OrderEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      orderModel = new List<OrderModel>();
      (json['data']['records'] as List).forEach((v) {
        orderModel.add(new OrderModel.fromJson(v));
      });

    }
  }
}
class OrderModel {

  String orderSn;
  int realPrice;
  int totalPrice;
  String statusName;
  int status;
  List<GoodsListModel> goods;
  OrderModel({this.orderSn, this.realPrice,this.totalPrice,this.statusName,
  this.status,this.goods});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderSn = json['orderSn'];
    realPrice = json['realPrice'];
    totalPrice = json['totalPrice'];
    statusName = json['statusName'];
    status =json['status'];
    goods=List<GoodsListModel> ();
    (json['items'] as List).forEach((v) {
      goods.add(new GoodsListModel.fromJson(v));
    });

  }

}
