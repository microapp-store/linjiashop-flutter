class OrderFormEntity {
  List<OrderFormListItem> items;

  OrderFormEntity(this.items);

}

enum OrderForm{
  payment,
  waitsending,
  aftersending,
  finished
}

abstract class OrderFormListItem {
  int id;
  String storeName;
  String imgUrl;
  String status;
  String title;
  double price;
  int amount;
  String weight;
  double total;
  OrderForm type;

}











