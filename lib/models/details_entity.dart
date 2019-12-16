/**
 * 商品详情页面
 */
class DetailsEntity {
	GoodsModelAndSku goods;
	DetailsEntity({this.goods});
	DetailsEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			if(json['data']['sku'] !=null) {
				goods = GoodsModelAndSku.fromJson(
						json['data']['goods'], json['data']['sku']);
			}else{
				goods = GoodsModelAndSku.fromJson(
						json['data']['goods'], null);
			}
		}
	}
}
class GoodsModelAndSku{
	GoodsModelDetail goodsModelDetail;
	SkuModel skuModel;
	GoodsModelAndSku({this.goodsModelDetail,this.skuModel});
	GoodsModelAndSku.fromJson(Map<String, dynamic> jsonGoods,Map<String, dynamic> jsonSku){
		goodsModelDetail =new GoodsModelDetail.fromJson(jsonGoods);
		if(null==jsonSku){
			skuModel=null;
		}else {
			skuModel = SkuModel.fromJson(jsonSku);
		}
	}

}
class SkuModel{
  bool hide_stock;
  bool none_sku;
  int price;
	List<TreeModel> treeModel;
	List<listModel> listModels;
	SkuModel({this.hide_stock,this.none_sku,this.price,this.treeModel,this.listModels});
	SkuModel.fromJson(Map<String, dynamic> json){
		hide_stock=json['hide_stock'];
		none_sku=json['none_sku'];
		price=json['price'];
		List<Map> dataListTree= (json['tree'] as List).cast();
		List<Map> dataListTreeList= (json['list'] as List).cast();

		dataListTree.forEach((t) {
			treeModel.add(TreeModel.fromJson(t));
		});

		dataListTreeList.forEach((l) {
			listModels.add(listModel.fromJson(l,treeModel));
		});
	}
}
class TreeModel{
	String k_s;
	String k;
	List<vModel> vModels;

	TreeModel({this.k,this.k_s,this.vModels});
	TreeModel.fromJson(Map<String, dynamic> json){
		k_s=json['k_s'];
		k= json['k'];
		List<Map> dataList= (json['v'] as List).cast();
		dataList.forEach((v) {
			vModels.add(vModel.fromJson(v));
		});
	}

}
class vModel{
	String id;
	String name;
	vModel({this.id,this.name});
	vModel.fromJson(Map<String, dynamic> json){
		id = json['id'];
		name=json['name'];
	}
}
class listModel{
//	"price": 69900,
//	"id": "1",
//	"s1": "1",
//	"s2": "3",
//	"stock_num": 100
   String price;
   String id;
   int stock_num;
   Map<String,String> map;
	 listModel({this.price,this.id,this.stock_num,this.map});
	 listModel.fromJson(Map<String, dynamic> json,List<TreeModel> trModel){
		 id = json['id'];
		 price=json['price'];
		 stock_num=json['stock_num'];
		 trModel.forEach((e){
			 map[e.k_s] = json[e.k_s];
		 });

	 }

}



class GoodsModelDetail {
	String createBy;
	String createTime;
	String descript;
	String gallery;
	String detail;
	String idCategory;
	String id;
	bool isDelete;
	bool isOnSale;
	String modifyBy;
	String modifyTime;
	String name;
	int  num;
	String pic;
	 int price;
	String specifications;


	GoodsModelDetail({this.createBy, this.createTime, this.descript, this.detail,
		this.idCategory,this.isDelete,this.isOnSale,this.modifyBy,this.modifyTime,
		this.name,this.num,this.pic,this.price,this.specifications,this.id,this.gallery});

	GoodsModelDetail.fromJson(Map<String, dynamic> json) {
		createBy = json['createBy'];
		createTime = json['createTime'];
		descript = json['descript'];
		detail = json['detail'];
		idCategory = json['idCategory'];
		isDelete = json['isDelete'];
		isOnSale=json['isOnSale'];
		modifyBy=json['modifyBy'];
		modifyTime=json['modifyTime'];
		name = json['name'];
		num = json['stock'];
		pic = json['pic'];
		price = json['price'];
		specifications = json['specifications'];
		id=json['id'];
		gallery=json['gallery'];
	}


}
