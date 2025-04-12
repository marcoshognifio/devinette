import 'package:flutter/material.dart';
import '../components/appbar.dart';
import '../components/button.dart';
import '../components/data_class.dart';

class DetailSign extends StatefulWidget {
  const DetailSign({super.key,required this.sign});
  final Map sign;

  @override
  State<DetailSign> createState() => _DetailSignState();
}

class _DetailSignState extends State<DetailSign> {

  List infoList = [];
  List<Widget> listPagesWidget = [];
  int current = 0;

  @override
  void initState() {
    super.initState();
  }

  actionFunction()async {
    Navigator.pushNamed(context, '/abonnement');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Informations sur le signe',context),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              delegate: DetailSliver(sign: widget.sign, expandedHeight: 350, roundedContainerHeight: 30,)
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top:10,left:20,right: 20,bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: columnWidget(context),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> columnWidget( BuildContext context ){

    TextStyle t = const TextStyle(
        fontFamily: 'Roboto-Regular',
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500);

    List<Widget> result = [];

    result.add(Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(widget.sign['name'],
        style: const TextStyle(
            fontFamily: 'Roboto-Regular',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25
        ),
      ),
    )
    );

    result.add(
        Padding(
          padding: const EdgeInsets.only(left:10, bottom: 10.0),
          child: Text(widget.sign['description'],
              style:t
          ),
        )
    );

    List<String> list = (widget.sign['description'] as String).split('#').where((e) => e.isNotEmpty).toList();
    for(int i=0,a=list.length;i<a;i++){
      result.add(
          ListTile(
            leading: Icon(Icons.brightness_1, size: 10,color: colorApp,),
            title: Text(list[i],style: t,),
          )
      );
    }

    result.add(Center(
      child: Button(
        text: 'En Savoir plus',
        onTap: actionFunction, width: 350,
      ),
    ));

    return result;
  }

}

class DetailSliver extends SliverPersistentHeaderDelegate {

  DetailSliver({required this.sign,required this.expandedHeight,
    required this.roundedContainerHeight,});
  final Map sign;
  final double roundedContainerHeight;
  final double expandedHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Hero(
          tag: sign['name'],
          child: Image.network(
            sign['image'],
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


