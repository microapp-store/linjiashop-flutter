/**
 * 商品详情页面
 */
class DetailsEntity {
	GoodsModelDetail goods;
	DetailsEntity({this.goods});
	DetailsEntity.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			goods=new GoodsModelDetail.fromJson(json['data']);
		}
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
		num = json['num'];
		pic = json['pic'];
		price = json['price'];
		specifications = json['specifications'];
		id=json['id'];
		gallery=json['gallery'];
	}


}
