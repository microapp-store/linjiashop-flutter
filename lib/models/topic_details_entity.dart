
/**
 * 推荐详情页面
 */
class TopicDetailsEntity {
	ArticleModel articleModel;
	List<TopGoods>   goodsList;
	TopicDetailsEntity({this.articleModel,this.goodsList});
	TopicDetailsEntity.fromJson(Map<String, dynamic> json) {
		goodsList = new List<TopGoods>();
		if(json['data']['article'] !=null) {
			articleModel = ArticleModel.fromJson(json['data']['article']);
		}
		List<Map> dataList= (json['data'] ['goodsList'] as List).cast();
		dataList.forEach((v){
			goodsList.add(new TopGoods.fromJson(v));
		});
	}

}
class ArticleModel{
	String title;
	String content;
	ArticleModel.fromJson(Map<String, dynamic> json){
		title=json['title'];
		content=json['content'];
	}

}
class TopGoods {
	String name;
	String pic;
	String id;
	TopGoods.fromJson(Map<String, dynamic> json){
		name = json['name'];
		pic = json['pic'];
		id = json['id'];
	}
}

