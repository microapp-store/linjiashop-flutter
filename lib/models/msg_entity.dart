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
  int code;

  MsgModel({this.msg, this.code});

  MsgModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
  }

}