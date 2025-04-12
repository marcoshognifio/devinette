import 'package:flutter/material.dart';
import '../components/appbar.dart';
import '../components/data_class.dart';

class DetailDivinity extends StatefulWidget {
  const DetailDivinity({super.key,required this.divinity});
  final Map<String,dynamic> divinity;

  @override
  State<DetailDivinity> createState() => _DetailDivinityState();
}

class _DetailDivinityState extends State<DetailDivinity> {


  List<String> titles= ['Histoire','Intervention','Invocation','Interdiction'];
  List<Widget> listPagesWidget = [];
  int current = 0;
  TextStyle t = const TextStyle(
      fontFamily: "Roboto-Regular",
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.w500);

  @override
  void initState() {
    listPagesWidget = listPages(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Informations sur la Divinité',context),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: DetailSliver(divinity: widget.divinity,
                expandedHeight: 350,
                roundedContainerHeight: 30,)
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  top: 10, left: 5, right: 5, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: titles.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              current = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: 80,
                              height: 45,
                              decoration: BoxDecoration(
                                border: Border.all(color: colorApp),
                                color: current == index ? colorApp : Colors
                                    .white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0)),
                              ),
                              child: Center(
                                  child: Text(
                                    titles[index],
                                    style: TextStyle(
                                        fontFamily: "Roboto-Regular",
                                        color: current == index
                                            ? Colors.white
                                            : colorApp
                                    ),
                                  )
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  listPagesWidget[current]
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> listPages(BuildContext context) {
    List<Widget> result = [],help =[];

    result.add(
      Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(widget.divinity['history'],style: t,)
          ],
        )
      ),
    );

    List list = widget.divinity['intervention'] as List;
    for (int i = 0, a = list.length; i < a; i++) {
      help.add(
          ListTile(
            leading: Icon(Icons.brightness_1, size: 10, color: colorApp,),
            title: Text(list[i], style: t,),
          )
      );
    }
    result.add(
      Container(
        child: Column(
          children: help,
        ),
      )
    );

    list = widget.divinity['invocation'];
    help = [];
    for (int i = 0, a = list.length; i < a; i++) {
      help.add(
          ListTile(
            leading: Icon(Icons.brightness_1, size: 10, color: colorApp,),
            title: Text(list[i], style: t,),
          )
      );
    }
    result.add(
        Container(
          child: Column(
            children: help,
          ),
        )
    );

    list = widget.divinity["forbidden"] as List;
    help = [];
    for (int i = 0, a = list.length; i < a; i++) {
      help.add(
          ListTile(
            leading: Icon(Icons.brightness_1, size: 10, color: colorApp,),
            title: Text(list[i], style: t,),
          )
      );
    }
    result.add(
        Container(
          child: Column(
            children: help,
          ),
        )
    );

    return result;
  }

}

class DetailSliver extends SliverPersistentHeaderDelegate {

  DetailSliver({required this.divinity,required this.expandedHeight,
    required this.roundedContainerHeight,});
  final Map divinity;
  final double roundedContainerHeight;
  final double expandedHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Hero(
          tag: divinity['name'],
          child: Image.network(
            divinity['image'],
            width: MediaQuery.of(context).size.width,
            height: expandedHeight,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: expandedHeight - roundedContainerHeight - shrinkOffset,
          child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: roundedContainerHeight,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              )
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override

  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}