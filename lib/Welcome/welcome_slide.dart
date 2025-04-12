import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../components/button.dart';
import '../components/data_class.dart';

//ignore: must_be_immutable

class WelcomeSlide extends StatefulWidget {
  const WelcomeSlide({super.key});

  @override
  State<WelcomeSlide> createState() => _WelcomeSlideState();
}

class _WelcomeSlideState extends State<WelcomeSlide> {

  final controller = PageController();
  int currentPage = 0;
  Widget bottomWidget = Container();

  @override
  void initState() {
    bottomWidget = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(),
        const Spacer(),
        ButtonWelcome(text: 'Suivant',
          chooseType: true,
          onTap: () {
              nextPage();
          },
        ),
      ],
    );
    super.initState();
  }

  void nextPage() {

    currentPage = currentPage + 1; // Changer entre 0 et 1

    if(currentPage == 1){
      setState(() {
        bottomWidget = Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ButtonWelcome(text: 'Précédent', chooseType: false, onTap: previousPage),
            const Spacer(),
            ButtonWelcome(text: 'Suivant',
              chooseType: true,
              onTap: () {
                nextPage();
              },
            ),
          ],
        );
      });
    }
    if(currentPage == 2){

      setState(() {
        bottomWidget = Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: ButtonWelcome(text: "S'inscrire", chooseType: true, onTap: (){
                      Navigator.pushNamed(context, '/inscription');
                    })
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Vous avez un compte ?",style: TextStyle(fontFamily: 'Roboto-Regular',),),
                  TextButton(
                      onPressed: () {Navigator.pushNamed(context, '/login');},
                      child: const Text('Se Connecter',style: TextStyle(fontFamily: 'Roboto-Regular',color: Colors.black,fontWeight: FontWeight.bold),)
                  )
                ],
              ),
            )
          ],
        );
      });

    }

    controller.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    currentPage = currentPage - 1; // Changer entre 0 et 1

    setState(() {
      bottomWidget = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(),
          const Spacer(),
          ButtonWelcome(text: 'Suivant',
            chooseType: true,
            onTap: () {
              nextPage();
            },
          ),
        ],
      );
    });
    controller.animateToPage(
      currentPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

  }

  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.fill),
          ),
          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: screenHeight*0.5,
                        child: PageView(
                          controller: controller,
                          onPageChanged: (index) {
                            setState(() {
                              currentPage = index; // Met à jour currentPage quand on change de page
                            });
                          },
                          children: listPages(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: SmoothPageIndicator(

                          count: 3,
                          effect: const ExpandingDotsEffect(
                              dotColor: Colors.grey,
                              activeDotColor:Colors.black,
                              dotHeight: 10,
                              dotWidth: 10
                          ),
                          controller: controller,

                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 50,right: 50,bottom: 90),
                        child: bottomWidget,
                      )
                    ]

          )
      ),
    );
  }

  List<Widget> listPages(){

    return [
      slide( ['OGBE / GBE','Le premier signe du fa'],

          Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 2.0,
                  height: 30.0,
                  color: Colors.black,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 2.0,
                  height: 30.0,
                  color: Colors.black,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 2.0,
                  height: 30.0,
                  color: Colors.black,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 2.0,
                  height: 30.0,
                  color: Colors.black,
                )
              ],
            ),
          ),false
      ),
      slide(['OYEKU / YEKU','Le second signe du fa'],

          Center(
            child: Column(

              children: [
                SizedBox(
                  width: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10 ),
                        width: 2.0,
                        height: 30.0,
                        color: Colors.black,
                      ),
                      const Spacer(),
                      Container(
                        width: 2.0,
                        height: 30.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10 ),
                        width: 2.0,
                        height: 30.0,
                        color: Colors.black,
                      ),
                      const Spacer(),
                      Container(
                        width: 2.0,
                        height: 30.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10 ),
                        width: 2.0,
                        height: 30.0,
                        color: Colors.black,
                      ),
                      const Spacer(),
                      Container(
                        width: 2.0,
                        height: 30.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10 ),
                        width: 2.0,
                        height: 30.0,
                        color: Colors.black,
                      ),
                      const Spacer(),
                      Container(
                        width: 2.0,
                        height: 30.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),false
      ),
      slide(['SEGBOLISSA','Créteur de toutes divinités',],
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Image.asset('assets/images/lisa.png',width: 500,height: 230,),
          ),true
      )
    ];
  }

  Widget slide( List<String> text, Widget content,bool image){

    return Container(
      color: Colors.white.withOpacity(0.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0,right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Padding(
              padding: EdgeInsets.only(bottom: image ?0.0:50),
              child: content,
            ),
            Text(text[0],
                style: const TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0,),
              child: Text(text[1],
                style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black.withOpacity(0.7)
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

}
