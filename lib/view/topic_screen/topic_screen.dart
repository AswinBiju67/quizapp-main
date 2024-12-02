import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/view/dummydb.dart';
import 'package:quizapp/view/screen_0ne/screen_0ne.dart';

class TpoicScreen extends StatefulWidget {
  const TpoicScreen({super.key});

  @override
  State<TpoicScreen> createState() => _TpoicScreenState();
}

class _TpoicScreenState extends State<TpoicScreen> {
  @override
  Widget build(BuildContext context) {
   
    List topic=[
    Dummydb().questions,
    Dummydb().footballQuestions,
    Dummydb().cricketQuestions,
    Dummydb().carQuestions,
    Dummydb().pythonQuestions,
    Dummydb().androidQuestions,
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Quiz App",style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,color: Colors.white),),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 20),
          child: CircleAvatar(backgroundImage: AssetImage("assets/images/R.png"),),
        )],
      ),
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("Select Topic",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.white),),
          SizedBox(height: 20,),
           Expanded(
             child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     ), 
                     itemCount: Dummydb().images.length,
                     itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenOne(topic: topic[index],),));
                  },
                  child: Image.asset(
                    height: 100,
                    fit: BoxFit.fill,
                    Dummydb().images[index]),
                ),
              ),
                     ),),
           ),
        ],),
      )
    );
  }
}