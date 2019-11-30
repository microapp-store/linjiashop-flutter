class CartEntity {
  CartModel  cartModel;

  CartEntity({this.cartModel});
  CartEntity.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
        cartModel =new CartModel.fromJson(json);
    }
  }
}
class CartModel {
  String msg;
  int code;

  CartModel({this.msg, this.code});

  CartModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
  }

}
