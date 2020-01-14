class TopicGoodsQueryEntity {
  List<TopicGoodsListModel> topicGoods;
  TopicGoodsQueryEntity({this.topicGoods});
  TopicGoodsQueryEntity.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      topicGoods = new List<TopicGoodsListModel>();
//			print(goods.runtimeType);
      (json['data'] as List).forEach((v) {
        topicGoods.add(new TopicGoodsListModel.fromJson(v));
//				print(goods.length);
      });
    }
  }
}

class TopicGoodsListModel {
  TopicGoodsModel topicGoodsModel;

//	"createBy": "1",
//	"createTime": "2020-01-08 21:25:53",
//	"disabled": false,
//	"goodsList": [],
//	"id": "1",
//	"idArticle": "1",
//	"idGoodsList": "1,5,10,12",
//	"modifyBy": "1",
//	"modifyTime": "2020-01-08 21:25:53",
//	"pv": "10000",
//	"title": "智能新品好物"
  String createBy;
  String createTime;
  bool disabled;
  String id;
  String idArticle;
  String idGoodsList;
  String modifyBy;
  String modifyTime;
  String pv;
  String title;

  TopicGoodsListModel(
      {this.createBy,
      this.createTime,
      this.disabled,
      this.id,
      this.idArticle,
      this.idGoodsList,
      this.modifyBy,
      this.modifyTime,
      this.pv,
      this.title,
      this.topicGoodsModel});

  TopicGoodsListModel.fromJson(Map<String, dynamic> json) {
    createBy = json['createBy'];
    createTime = json['createTime'];
    disabled = json['disabled'];
    id = json['id'];
    idArticle = json['idArticle'];
    idGoodsList = json['idGoodsList'];
    modifyBy = json['modifyBy'];
    modifyTime = json['modifyTime'];
    pv = json['pv'];
    title = json['title'];

    if (json['article'] != null) {
      topicGoodsModel = new TopicGoodsModel.fromJson(json['article']);
    }
  }
}

class TopicGoodsModel {
  String author;
  String content;
  String createBy;
  String id;
  String idChannel;
  String img;
  String createTime;
  String modifyBy;
  String modifyTime;
  String title;

  TopicGoodsModel(
      {this.author,
      this.content,
      this.createTime,
      this.id,
      this.idChannel,
      this.img,
      this.modifyBy,
      this.modifyTime,
      this.title});

  TopicGoodsModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    content = json['content'];
    createBy = json['createBy'];
    id = json['id'];
    idChannel = json['idChannel'];
    img = json['img'];
    createTime = json['createTime'];
    modifyBy = json['modifyBy'];
    modifyTime = json['modifyTime'];
    title = json['title'];
  }
}
