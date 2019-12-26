class ShippingAddresEntry {
  List<ShippingAddressModel> shippingAddressModels;
  ShippingAddresEntry({this.shippingAddressModels});

  ShippingAddresEntry.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      shippingAddressModels = new List<ShippingAddressModel>();
      (json['data'] as List).forEach((v) {
        shippingAddressModels.add(new ShippingAddressModel.fromJson(v));
      });

    }
  }
}
class ShippingAddressModel {
//  "addressDetail":"人民路12号",
//  "areaCode":"110101",
//  "city":"北京市",
//  "createTime":"",
//  "district":"东城区",
//  "id":"1",
//  "idUser":"1",
//  "isDefault":true,
//  "isDelete":false,
//  "modifyTime":"",
//  "name":"路飞",
//  "postCode":"",
//  "province":"北京市",
//  "tel":"15011113333"
  String addressDetail;
  String areaCode;
  String city;
  String district;
  String name;
  String province;
  String tel;
  String id;
  bool isDefault;

  ShippingAddressModel({this.addressDetail, this.areaCode,this.city,this.district,
    this.name,this.province,this.tel,this.id,this.isDefault});
  ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    addressDetail = json['addressDetail'];
    areaCode = json['areaCode'];
    district = json['district'];
    name = json['name'];
    province =json['province'];
    tel =json['tel'];
    id =json['id'];
    city=json['city'];
    isDefault =json['isDefault'];
  }

}