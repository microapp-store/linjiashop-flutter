class CategoryEntity {
	List<CategoryModel> category;
	CategoryEntity({this.category});
	CategoryEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			category = new List<CategoryModel>();(json['data'] as List).forEach((v) { category.add(new CategoryModel.fromJson(v)); });
		}
	}
}
class CategoryModel{

   String name;
   String id;
	 List<CategoryInfoModel> categoryInfoModels;
	 CategoryModel({this.name,this.id,this.categoryInfoModels});
	 factory CategoryModel.fromJson(Map<String, dynamic> parsedJson){
		 var list = parsedJson['bannerList'] as List;

		 List<CategoryInfoModel> categoryInfoList = list.map((i) => CategoryInfoModel.fromJson(i)).toList();
		 return CategoryModel(
				 id: parsedJson['id'],
				 name: parsedJson['name'],
				 categoryInfoModels:categoryInfoList
		 );
	 }
}

class CategoryInfoModel {
	String createBy;
	String createTime;
	String idFile;
	String modifyBy;
	String modifyTime;
	String title;
	String type;
	String url;
	String id;

	CategoryInfoModel({this.createBy, this.createTime, this.idFile, this.modifyBy,this.modifyTime,this.title,this.type,this.url,this.id});

	CategoryInfoModel.fromJson(Map<String, dynamic> json) {
		createBy = json['createBy'];
		createTime = json['createTime'];
		idFile = json['idFile'];
		modifyBy = json['modifyBy'];
		modifyTime = json['modifyTime'];
		title = json['title'];
		type = json['type'];
		url = json['url'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['createBy'] = this.createBy;
		data['createTime'] = this.createTime;
		data['idFile'] = this.idFile;
		data['modifyBy'] = this.modifyBy;
		data['modifyTime'] = this.modifyTime;
		data['title'] = this.title;
		data['type'] = this.type;
		data['url'] = this.url;
		data['id'] = this.id;
		return data;
	}
}
