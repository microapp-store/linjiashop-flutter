import 'package:flutter/material.dart';
import 'package:flutter_app/common.dart';
import 'package:flutter_app/dao/get_order_dao.dart';
import 'package:flutter_app/models/order_entity.dart';
import 'package:flutter_app/page/card_order.dart';
import 'package:flutter_app/utils/constants.dart';
import 'package:flutter_app/utils/dialog_utils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_app/dao/order_form_dao.dart';
import 'package:flutter_app/models/order_form_entity.dart';

import 'package:flutter_app/utils/app_size.dart';
import 'package:flutter_app/view/app_topbar.dart';
import 'package:flutter_app/view/custom_view.dart';
import 'package:flutter_app/view/customize_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'load_state_layout.dart';

///
/// app 订单页
///
class OrderFormPage extends StatefulWidget {

  @override
  _OrderFormPageState createState() => _OrderFormPageState();
}


class _OrderFormPageState extends State<OrderFormPage> with AutomaticKeepAliveClientMixin,
    SingleTickerProviderStateMixin{
  double width=0;
  final List<Tab> myTabs = <Tab>[

    Tab(text: '待付款'),
    Tab(text: '待发货'),
    Tab(text: '已发货'),
    Tab(text: '已完成'),
  ];

  final ValueNotifier<OrderFormEntity> orderFormData
  = ValueNotifier<OrderFormEntity>(null);


  List<Widget> bodys;

  _initTabView(){
    bodys = List<Widget>.generate(myTabs.length, (i){
      return OrderFormTabView(i,orderFormData);
    });
  }


  TabController mController;

  @override
  void initState() {
    _initTabView();
    mController = TabController(
      length: myTabs.length,
      vsync: this,
      initialIndex: AppConfig.orderIndex,
    );
    super.initState();
  }

  void loadData() async{
    orderFormData.value = await OrderFormDao.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppSize.init(context);
    final screenWidth = ScreenUtil.screenWidth;
    if(myTabs.length>0) {
      width=(screenWidth / (myTabs.length*2))  - 65;
    }
    return Scaffold(
      appBar: MyAppBar(
        preferredSize: Size.fromHeight(AppSize.height(160)),
        child:CommonBackTopBar(title: "订单",onBack:()=>Navigator.pop(context)),
      ),
      body: Container(
        color: Color(0xfff5f6f7),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: AppSize.height(120),
              child: Row(
                  children:<Widget>[Expanded(
                    child: TabBar(
                      isScrollable: true,
                      controller: mController,
                      labelColor: Color(0xFFFF7095),
                      indicatorColor:Color(0xFFFF7095),
                      indicatorSize:TabBarIndicatorSize.tab,
                      indicatorWeight:1.0,
                      unselectedLabelColor: Color(0xff333333),
                      labelStyle: TextStyle(fontSize: AppSize.sp(44)),
                      indicatorPadding:EdgeInsets.only(left:AppSize.width(width),right: AppSize.width(width)),
                      labelPadding:EdgeInsets.only(left:AppSize.width(width),right: AppSize.width(width)),
                      tabs: myTabs,
                    ),
                  )]
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: mController,
                children: bodys,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class OrderFormTabView extends StatefulWidget {
  final ValueNotifier<OrderFormEntity> data;
  final int currentIndex;

  OrderFormTabView(this.currentIndex,this.data);

  @override
  _OrderFormTabViewState createState() => _OrderFormTabViewState();
}

class _OrderFormTabViewState extends State<OrderFormTabView> {
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  LoadState _layoutState = LoadState.State_Loading;
  List<OrderModel> listData = List();
  int page=1;

  @override
  void initState() {
    widget.data.addListener(notifyDataChange);
    getOrder();
    super.initState();
  }
  getOrder(){
    switch(widget.currentIndex){
      case 0:
        loadData(1,page,AppConfig.token);
        break;
      case 1:
        loadData(2,page,AppConfig.token);
        break;

      case 2:
        loadData(3,page,AppConfig.token);
        break;
      case 3:
        loadData(4,page,AppConfig.token);
        break;


    }
  }

  @override
  void dispose() {
    widget.data.removeListener(notifyDataChange);
    super.dispose();
  }
  void loadData(int status,int page,String token)async{
    OrderEntity entity= await OrderQueryDao.fetch(status, page, token);

    if(entity?.orderModel != null){
      if(entity.orderModel.length > 0){
        List<OrderModel> orderModelTmp = List();
        entity.orderModel.forEach((el){
          orderModelTmp.add(el);
        });
        if(mounted) {
          setState(() {
            _layoutState = LoadState.State_Success;
            listData.clear();
            listData.addAll(orderModelTmp);
          });
        }
      }else{
        if(mounted) {
          if(page==1) {
            setState(() {
              _layoutState = LoadState.State_Empty;
            });
          }else{
            DialogUtil.buildToast('没有更多数据');
          }
        }

      }
    }else{
      if(mounted) {
        setState(() {
          _layoutState = LoadState.State_Error;
        });
      }
    }

  }

  void notifyDataChange(){
    getOrder();

  }

  @override
  Widget build(BuildContext context) {
    return LoadStateLayout(
        state: _layoutState,
        errorRetry: () {
          setState(() {
            _layoutState = LoadState.State_Loading;
          });
          getOrder();
        }, //错误按钮点击过后进行重新加载
        successWidget:_getContent()
    );

  }
  Widget _getContent(){
    return Container(
      margin: EdgeInsets.only(top: AppSize.height(30)),

      child: EasyRefresh(
          refreshHeader: MaterialHeader(
            key: _headerKey,
          ),
          refreshFooter: MaterialFooter(
            key: _footerKey,
          ),
          onRefresh: () async {
            page=1;
            getOrder();

          },
          loadMore:  () async {
            page++;
            getOrder();
          },

          child:SingleChildScrollView(
            child:  OrderCard(orderModleDataList: listData),
          )

      ),
    );
  }

  void navigate(int id){
//      Routes.instance.navigateTo(context, Routes.ORDER_DETAILS,id.toString());
  }
}







