class MsgEntity {
  MsgModel  msgModel;
  MsgEntity({this.msgModel});
  MsgEntity.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      msgModel =new MsgModel.fromJson(json);
    }
  }
}
class MsgModel {
  String msg;
  String data;
  int code;
  MsgModel({this.msg, this.code,this.data});
  MsgModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'];
  }

}