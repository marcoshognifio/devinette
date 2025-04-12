import 'dart:math';

import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';
import 'detail_divinity.dart';

class Divinity extends StatefulWidget {
  Divinity({super.key,required this.contextParent});
  BuildContext contextParent;

  @override
  State<Divinity> createState() => _DivinityState();
}

class _DivinityState extends State<Divinity> {

  List<List<Map>> groupTree = [];
  List<List<Map>> _items = [];
  final bool _isSearchVisible = true;
  final bool _isLoading = false;
  final form = GlobalKey<FormState>();
  final divinityController = TextEditingController();

  Future searchAction() async{
    if (form.currentState!.validate()) {
      await DatabaseHelper().searchDivinity(divinityController.text);
    }
  }


  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: true,
      child: Navigator(

          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(
                builder: (context){
                  return FutureBuilder<List<dynamic>>(
                    future: DatabaseHelper().getDivinitiesAll(),
                    builder: (context, snapshot) {

                      if(snapshot.hasData){

                        return ValueListenableBuilder(
                            valueListenable: listDivinitiesNotifier,
                            builder: (context,list, child){

                              if(listDivinities.isNotEmpty){
                                groupTree = Group().getGroupList(listDivinities);

                                _items = groupTree.take(5).toList();
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(milliseconds: 00),
                                        height: _isSearchVisible ? 80.0 : 0.0,
                                        curve: Curves.easeInOut,
                                        child: _isSearchVisible
                                            ? Padding(
                                          padding: const EdgeInsets.only(bottom: 15.0,top: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              EntrySearch(text: 'Rechecher une plante',control: divinityController,formKey: form, onTap: searchAction),
                                            ],
                                          ),
                                        ): null,
                                      ),
                                      SizedBox(
                                        child: Column(
                                          children: columnItemWidget(_items, context),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              else {
                                return emptyPage("Aucune transaction vers un sous projet n'a été ajoutée", Container());
                              }

                            }
                        );
                      }
                      else {
                        return const SizedBox(
                            width: 100,
                            height: 100,
                            child: Center(child: CircularProgressIndicator()));
                      }
                    },
                  );
                }
            );
          }
      ),
    );
  }

  List<Widget> columnItemWidget(List list,BuildContext context){
    List<Widget> result =[];

    for(int i=0,c=list.length;i<c;i++){

      result.add(
          lisTreeWidget(list[i],context)
      );
    }

    result.add(

        _isLoading ?const Center(child: CircularProgressIndicator()
        ):Container()
    );

    return result;
  }

  Widget lisTreeWidget(List list,BuildContext context){

    return Container(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index)=>Column(
          children: [
            divinityWidget(list[index],context)
          ],
        ),
        separatorBuilder: (context,index)=>const SizedBox(width: 5,),
        itemCount: list.length,
      ),
    );
  }

  Widget divinityWidget(Map<dynamic,dynamic> divinity , BuildContext context){

    Random random = Random();
    int randomIndex = random.nextInt(3)+1;
    divinity['image'] = '$url/image/${divinity['image$randomIndex']}';
    return Container(
      margin: const EdgeInsets.all(5),
      height: 200,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 3,
                blurRadius: 8,
                offset: const Offset(-3,-3)
            ),

            BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 3,
                blurRadius: 8,
                offset: const Offset(4,4)
            )
          ]
      ),
      child: Column(
        children: [
          Container(
            height: 130,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                    image: NetworkImage(divinity['image']),
                    fit: BoxFit.cover
                )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top:20,left: 10,bottom: 10,right: 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        scrollDirection:Axis.horizontal,
                        child: Text(divinity['name'],style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),),
                      ),
                    ],
                  ),
                ),
                ButtonIcon(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                    print(divinity);
                    Navigator.of(widget.contextParent).pushNamed('/infoDivinity',arguments: divinity);
                  },
                  icon:  const Icon(Icons.arrow_forward,color: Colors.white,),
                  size: 40,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
