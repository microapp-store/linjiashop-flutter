import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = EventBus();

class UserLoggedInEvent {
  String text;
  UserLoggedInEvent(String text){
    this.text = text;
  }
}
class UserNumInEvent{
  String num;
  UserNumInEvent(String text){
    this.num=text;
  }
}
class GoodsNumInEvent{
  String  event;
  GoodsNumInEvent(String text){
    this.event=text;
  }
}
class IndexInEvent{
  String  index;
  IndexInEvent(String text){
    this.index=text;
  }
}
class OrderInEvent {
  String text;
  OrderInEvent(String text){
    this.text = text;
  }
}
class UserInfoInEvent {
  String text;
  UserInfoInEvent(String text){
    this.text = text;
  }
}
class SpecEvent{
  String  code;
  SpecEvent(String text){
    this.code=text;
  }
}
