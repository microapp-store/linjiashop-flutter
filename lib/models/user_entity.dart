class UserEntity {
	UserInfoModel  userInfoModel;
	MsgModel msgModel;
	UserEntity({this.userInfoModel,this.msgModel});
	UserEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			if(json['data'].isNotEmpty){
				userInfoModel =new UserInfoModel.fromJson(json['data']);
			}else{
				msgModel=new MsgModel.fromJson(json);
			}
		}
	}
}
class UserInfoModel {
	String avatar;
	String mobile;
	String nickName;
	String id;
	String gender;
	Map<String, dynamic> jsonMap;


	UserInfoModel({this.avatar, this.mobile, this.nickName,this.gender});

	UserInfoModel.fromJson(Map<String, dynamic> json) {
		avatar = json['avatar'];
		mobile = json['mobile'];
		nickName = json['nickName'];
		id = json ['id'];
		gender = json ['gender'];
		jsonMap = json;
	}

}
class MsgModel{
	String msg;
	MsgModel({this.msg});
	MsgModel.fromJson(Map<String, dynamic> json){
		msg=json['msg'];
	}

}
