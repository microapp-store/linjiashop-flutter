import 'cart_goods_query_entity.dart';

class OrderDetailEntry {
  OrderDetailModel orderDetailModel;
  OrderDetailEntry({this.orderDetailModel});

  OrderDetailEntry.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      orderDetailModel= new OrderDetailModel.fromJson(json['data']);
    }
  }
}
class OrderDetailModel {
  String orderSn;
  int realPrice;
  int totalPrice;
  String addressDetail;
  String areaCode;
  String city;
  String district;
  String name;
  String tel;
  int status;
  String statusName;
  String province;
  String createTime;
  List<GoodsListModel> goods;
  OrderDetailModel({this.orderSn, this.realPrice,this.totalPrice,this.statusName,
  this.status,this.goods});
  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    orderSn = json['orderSn'];
    realPrice = json['realPrice'];
    totalPrice = json['totalPrice'];
    statusName = json['statusName'];
    status =json['status'];
    addressDetail =json['address']['addressDetail'];
    areaCode =json['address']['areaCode'];
    city =json['address']['city'];
    district =json['address']['district'];
    name =json['address']['name'];
    tel =json['address']['tel'];
    province =json['address']['province'];
    status =json['status'];
    createTime =json['createTime'];
    goods=List<GoodsListModel> ();
    List<Map> dataList= (json['items'] as List).cast();
    dataList.forEach((v) {
      goods.add(GoodsListModel.fromJson(v));
    });

  }

}
