
import 'package:flutter_app/models/order_form_entity.dart';

class OrderFormDao{

  static Future<OrderFormEntity> fetch() async{
    Future<OrderFormEntity> result = Future((){
      var itemList = List<OrderFormListItem>.generate(12, (i){
        OrderFormListItem item = AllItem()..id = i;
        switch(i % 4){
          case 0:
            item..status='等待支付'
            ..type = OrderForm.payment;
            break;
          case 1:
            item..status='订单已支付'
              ..type = OrderForm.waitsending;
            break;
          case 2:
            item..status='订单已完成'
              ..type = OrderForm.aftersending;
            break;
          case 3:
            item..status='订单已评价'
              ..type = OrderForm.finished;
            break;
        }
        return item..storeName="香奈儿品牌店"
        ..imgUrl='images/order_form.png'
        ..title='香水女士持久淡香学生清新香水女士持久淡香学生清新香水女士持久淡香学生清新'
        ..price=19.90
        ..amount=2
        ..weight='200g'
        ..total=39.80;
      });
        return OrderFormEntity(itemList);
    });
    return result;
  }

}