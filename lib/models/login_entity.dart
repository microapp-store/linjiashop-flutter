class LoginEntity {
	UserModel  userModel;
	MsgModel msgModel;
	LoginEntity({this.userModel,this.msgModel});
	LoginEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			if(json['data'].isNotEmpty){
				userModel =new UserModel.fromJson(json['data']);
			}else{
				msgModel=new MsgModel.fromJson(json);
			}
		}
	}
}
class UserModel {
	String avatar;
	String mobile;
	String nickName;
	String token;
	String msg;
	UserModel({this.avatar, this.mobile, this.nickName, this.token});

	UserModel.fromJson(Map<String, dynamic> json) {
		avatar = json['user']['avatar'];
		mobile = json['user']['mobile'];
		nickName = json['user']['nickName'];
		token = json['token'];
	}

}
class MsgModel{
	String msg;
	MsgModel({this.msg});
	MsgModel.fromJson(Map<String, dynamic> json){
		msg=json['msg'];
	}

}
