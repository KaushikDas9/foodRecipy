import 'dart:convert';
import 'dart:developer';
import 'package:untitled/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<RecipieModel> recipiList = <RecipieModel>[];

  void getData( String foodName)  async {
    String url = "https://api.edamam.com/search?q=$foodName&app_id=86af4909&app_key=d204e8dc294ab499bef1fbfa892b4561";
      var response = await get(Uri.parse(url));
      var respondata = json.decode(response.body);

      respondata["hits"].forEach( ( element ) {

        RecipieModel recipieModel =  new RecipieModel();
        recipieModel = RecipieModel.fromMap(element["recipe"]);
        recipiList.add(recipieModel);

      });

      
  }

  String foodName="";

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print(foodName);
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(title: const Text("Home"),),
      resizeToAvoidBottomInset: false,
      body: Stack(
          children:[
            Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(color: Color(0xffFB7901)),
              child: Column(
                 children: [

                       //Srearch bar suru
                 Container(
                    width: MediaQuery.of(context).size.width * .9 ,
                     height: MediaQuery.of(context).size.height * .07,
                     margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    decoration:  BoxDecoration(
                     borderRadius: BorderRadius.circular(35),
                    color: Colors.white24),
                       child:   Padding(
                          padding: EdgeInsets.only(left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                          child: const Icon(Icons.search ,color: Colors.white70),
                                          onTap: () {
                                            setState(() {getData(foodName);});
                                          } ,
                               ),
                                SizedBox(
                                        width: MediaQuery.of(context).size.width * .75,
                                       height: MediaQuery.of(context).size.height * .06,

                                     child: Padding(
                                       padding: const EdgeInsets.only(left:5),
                                       child: TextField(style: const TextStyle(color: Colors.white,fontFamily: "pop_medium"),
                                           cursorColor:Colors.white70 ,
                                           textInputAction: TextInputAction.search,
                                           onSubmitted: (value) {
                                        foodName=value;
                                           print(" search  $foodName");
                                        setState(() {getData(foodName);});
                                        },
                                         decoration: const InputDecoration(
                                        hintText: 'Enter any food name' ,
                                         hintStyle: TextStyle(color: Colors.white70),
                                         disabledBorder:InputBorder.none,
                                             focusedBorder: InputBorder.none,
                                           ),

                                        ),
                                                       ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                   //Search Bar ses

                   //two Text suru
                   Padding(
                     padding: const EdgeInsets.fromLTRB(25,20,20,10),
                     child: SizedBox(
                       width: MediaQuery.of(context).size.width* 9 ,
                       height:  MediaQuery.of(context).size.height*.45 ,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const Text("WHAT YOU WILL MAKE TODAY ? " , style: TextStyle( color: Colors.pink , fontFamily: "pop_bold" , fontSize: 35 ,),),
                           Text("Lets make a $foodName dish today ! " ,style: TextStyle( color: Colors.pink , fontFamily: "pop_light" , fontSize: 18 ,))
                         ],
                       ),
                     ),
                   )
                  //two Text ses





                ],
              )
                ),
              ]
                  ) ,
            );

  }
}
