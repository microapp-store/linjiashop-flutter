
import 'package:flutter_app/models/address_entity.dart';
import 'package:flutter_app/models/cart_entity.dart';
import 'package:flutter_app/models/details_entity.dart';
import 'package:flutter_app/models/login_entity.dart';
import 'package:flutter_app/models/msg_entity.dart';
import 'package:flutter_app/models/order_detail_entity.dart';
import 'package:flutter_app/models/order_entity.dart';
import 'package:flutter_app/models/shipping_entity.dart';


import 'cart_goods_query_entity.dart';
import 'category_entity.dart';
import 'goods_entity.dart';
import 'hot_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(dynamic json) {
    if (1 == 0) {
      return null;
    }  else if (T.toString() == "GoodsEntity"){
      return GoodsEntity.fromJson(json) as T;
    }else if (T.toString() == "CategoryEntity"){
      return CategoryEntity.fromJson(json) as T;
    }else if (T.toString() == "DetailsEntity"){
      return DetailsEntity.fromJson(json) as T;
    }else if (T.toString() == "LoginEntity"){
      return LoginEntity.fromJson(json) as T;
    }else if (T.toString() == "HotEntity"){
      return HotEntity.fromJson(json) as T;
    }else if (T.toString() == "CartEntity"){
      return CartEntity.fromJson(json) as T;
    }else if (T.toString() == "CartGoodsQueryEntity"){
      return CartGoodsQueryEntity.fromJson(json) as T;
    }else if (T.toString() == "MsgEntity"){
      return MsgEntity.fromJson(json) as T;
    }else if (T.toString() == "OrderEntity"){
      return OrderEntity.fromJson(json) as T;
    }else if (T.toString() == "OrderDetailEntry"){
      return OrderDetailEntry.fromJson(json) as T;
    }else if (T.toString() == "ShippingAddresEntry"){
      return ShippingAddresEntry.fromJson(json) as T;
    }else if (T.toString() == "AddressEditEntity"){
      return AddressEditEntity.fromJson(json) as T;
    }
    else {
      return null;
    }
  }
}