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
