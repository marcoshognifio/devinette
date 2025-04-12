import 'dart:math';
import 'package:flutter/material.dart';
import '../components/appbar.dart';
import '../components/button.dart';
import '../components/components.dart';
import '../components/data_class.dart';

class SearchMode extends StatefulWidget {
  SearchMode({super.key,required this.contextParent,
    required this.typeSearch,required this.list});

  BuildContext contextParent;
  String typeSearch;
  List<int> list;

  @override
  State<SearchMode> createState() => _SearchModeState();
}

class _SearchModeState extends State<SearchMode> {

  List<List<Map>> groupTree = [];
  List<List<Map>> _items = [];
  final bool _isSearchVisible = true;
  final bool _isLoading = false;
  final form = GlobalKey<FormState>();
  final controller = TextEditingController();

  Future searchAction() async{
    if (form.currentState!.validate()) {
      await DatabaseHelper().searchSign(controller.text);
    }
  }

  Future<List<dynamic>> getSignsBasedOnSearchType() async {
    switch (widget.typeSearch) {
      case 'typeSign':
        return await DatabaseHelper().searchSign2(widget.list);
      default:
        return await DatabaseHelper().getSignsAll();  // Valeur par défaut si aucun type spécifique
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarWidget('Mode Recherche',context),
      body: PopScope(
        canPop: true,
        child: FutureBuilder<List<dynamic>>(
          future:  getSignsBasedOnSearchType(),
          builder: (context, snapshot) {

            if(snapshot.hasData){

              return ValueListenableBuilder(
                  valueListenable: listSignsNotifier,
                  builder: (context,list, child){

                    if(listSigns.isNotEmpty){
                      groupTree = Group().getGroupList(listSigns);

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
                                    EntrySearch(text: 'Rechecher un signe',control: controller,formKey: form, onTap: searchAction),
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
                      return emptyPage("Aucun Signe n'est disponible pour le moment", Container());
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
        )
      )
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
                    Navigator.pushNamed( context,'/infoSigne',arguments: divinity);
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


