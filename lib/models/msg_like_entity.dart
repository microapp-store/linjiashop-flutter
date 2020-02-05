class MsgLikeEntity {
  MsgLikeModel  msgModel;
  MsgLikeEntity({this.msgModel});
  MsgLikeEntity.fromJson(Map<String, dynamic> json) {
    if (json['code'] != null) {
      msgModel =new MsgLikeModel.fromJson(json);
    }
  }
}
class MsgLikeModel {
  String msg;
  bool data;
  int code;
  MsgLikeModel({this.msg, this.code,this.data});
  MsgLikeModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'];
  }

}