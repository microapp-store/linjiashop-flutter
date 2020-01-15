class FileEntity {
  FileModel  msgModel;
  FileEntity({this.msgModel});
  FileEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      msgModel =FileModel.fromJson(json['data'],json['msg']);
    }
  }
}
class FileModel {
  String avatar;
  String nickName;
  String msg;

  FileModel({this.avatar, this.nickName,this.msg});
  FileModel.fromJson(Map<String, dynamic> json,String message) {
    avatar = json['avatar'];
    nickName = json['nickName'];
    msg=message;
  }

}