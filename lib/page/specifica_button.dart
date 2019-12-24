
import 'package:flutter/material.dart';
import 'package:flutter_app/models/details_entity.dart';
import 'package:flutter_app/receiver/event_bus.dart';
class SpecificaButton extends StatefulWidget {
  final List<TreeModel> treeModel;
  SpecificaButton({this.treeModel});
  @override
  _SpecificaButtonState createState() {
    return _SpecificaButtonState();
  }

}

class _SpecificaButtonState extends State<SpecificaButton> {
  Map<String, int> hmSpecifica = Map();
  @override
  void initState() {
    super.initState();
    if (mounted) {
        widget.treeModel.forEach((e){
        hmSpecifica[e.k_s] = 0;
      });
        specPost();
    }

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(widget.treeModel.length, (i) {
            return _BoxSpecifications(widget.treeModel[i].k,
                widget.treeModel[i].k_s, widget.treeModel[i].vModels);
          })),
    );


  }
  Widget _BoxSpecifications(String name, String k_s, List<vModel> vModel) {

    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 16, bottom: 14),
              child: Text(name, style: TextStyle(fontSize: 14))),
          Wrap(
              alignment: WrapAlignment.start,
              spacing: 16,
              runSpacing: 12,
              children: List<Widget>.generate(vModel.length, (index) {
                return Container(
                  margin: EdgeInsets.only(top: 8),
                  child: FlatButton(
                    child: Text(vModel[index].name, style: TextStyle(fontSize: 12)),
                    onPressed: () {
                      setState(() {
                        hmSpecifica[k_s]=index;
                        specPost();
                      });
                    },
                    color:  hmSpecifica[k_s]== index
                        ? Color(0x1AFF6631)
                        : Color(0xFFF7F7F7),
                    textColor:  hmSpecifica[k_s]== index
                        ? Color(0xFFFF6732)
                        : Color(0xff333333),
                    disabledTextColor: Color(0xff999999),

                    shape: StadiumBorder(
                        side: BorderSide(
                            style: BorderStyle.solid,
                            color:  hmSpecifica[k_s]== index
                                ? Color(0xFFFF6732)
                                : Color(0xFFF7F7F7))),
                  ),
                );

              })
          ),
        ],
      ),
    );
  }

  void specPost() {
     String code="";
    for(int i=0;i< widget.treeModel.length;i++){
      if(i== widget.treeModel.length-1){
        code= code+widget.treeModel[i].vModels[hmSpecifica[widget.treeModel[i].k_s]].id;
      }else{
        code= code+widget.treeModel[i].vModels[hmSpecifica[widget.treeModel[i].k_s]].id+",";
      }
    }
    eventBus.fire(SpecEvent(code));
  }
}