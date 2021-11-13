import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:propertychowk/utils/colors.dart';

class PropertyStatusView extends StatefulWidget {
  final String propertyType;
  final List<String>? selectedStatus;
  PropertyStatusView(this.propertyType,{this.selectedStatus});

  @override
  _PropertyStatusViewState createState() => _PropertyStatusViewState();
}

class _PropertyStatusViewState extends State<PropertyStatusView> {
  List<String> selectedStatusList=[];
  List<String> allPropertyStatusList=["Direct to Owner", "Bayana","Ndc Applied","Possession","Non-Possession","Army Update","All Paid","File","Others"];
  late List<String> statusList;
  List<String> commercialPropertyStatusList=["Direct to Owner", "Bayana","Possession","Non-Possession","File","Others"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.propertyType=="Home"||widget.propertyType=="Plot"){
      statusList=allPropertyStatusList;
    }
    else {
      statusList=commercialPropertyStatusList;
    }
    if(widget.selectedStatus!=null){
      selectedStatusList=widget.selectedStatus!;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true,title: Text("Select Status"),actions: [
        TextButton(onPressed: (){
          Navigator.pop(context,selectedStatusList);
        }, child: AutoSizeText("Done",presetFontSizes: [18,16,14],style: TextStyle(color: Theme.of(context).primaryColor),),)
      ],),
      body: ListView.separated(
          itemCount: statusList.length,
          separatorBuilder: (BuildContext context,int index){
            return Divider(thickness: 3,);
          },
          itemBuilder: (BuildContext context,int index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(children: [
                AutoSizeText(statusList[index],style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w600),presetFontSizes: [18,16],),
                Spacer(),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.red),
                  child: Checkbox(
                      activeColor: primaryColor,
                      value: selectedStatusList.contains(statusList[index]), onChanged:(val){
                    if(selectedStatusList.contains(statusList[index])){
                      setState(() {
                        selectedStatusList.remove(statusList[index]);
                      });
                    }else{
                      setState(() {
                        selectedStatusList.add(statusList[index]);
                      });
                    }
                  }),
                )
              ],),
            );
          }),
    );
  }
}
