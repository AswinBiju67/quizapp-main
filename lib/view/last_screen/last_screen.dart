import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quizapp/view/screen_0ne/screen_0ne.dart';
import 'package:quizapp/view/topic_screen/topic_screen.dart';
import 'package:share_plus/share_plus.dart';

class LastScreen extends StatefulWidget {
  int score;
  dynamic quiz;
  LastScreen({super.key, required this.score,this.quiz
  });

  @override
  State<LastScreen> createState() => _LastScreenState();
}

class _LastScreenState extends State<LastScreen> {
  int starcount = 0;
  @override
  void initState() {
    calculateper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
            child: Stack(
              children: [
                if(widget.score>=3)
                Center(child:
                 Positioned(child: 
                 Lottie.asset('assets/animation/Animation_popper.json'),)),
                Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.only(
                      left: 15, right: 15, bottom: index == 1 ? 30 : 0),
                  child: Icon(
                    Icons.star,
                    color: starcount > index ? Colors.yellowAccent : Colors.grey,
                    size: index == 1 ? 70 : 40,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              starcount>=2?"Congratulations":"Try Agin",
              style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Your Score",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "${widget.score} / 13",
              style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                     showModalBottomSheet(context: context, builder: (context) => Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(15),right: Radius.circular(15))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                        ElevatedButton(onPressed: () {
                           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TpoicScreen(),), (route) => false,);
                        }, child: Text("Select Topic",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 20),)),
                         ElevatedButton(onPressed: () {
                           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ScreenOne(topic: widget.quiz),), (route) => false,);
                        }, child: Text("Retry Topic",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 20),)),
                      ],),
                    ),);
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.restart_alt),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Retry",
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                InkWell(
                  onTap: () {
                    Share.share('check out my website https://example.com');
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                    color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                  ),child: Icon(Icons.share_outlined),),
                )
              ],
            )
          ],
        )
              ],
            )),
      ),
    );
  }

  calculateper() {
    num percentage = (widget.score / widget.quiz.length) * 100;
    if (percentage >= 90) {
      starcount = 3;
    } else if (percentage >= 50) {
      starcount = 2;
    } else if (percentage >= 30) {
      starcount = 1;
    }
    setState(() {});
  }
}
