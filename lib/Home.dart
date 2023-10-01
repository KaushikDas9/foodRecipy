import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:untitled/model.dart';

import 'WebViewPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 0;
  List<RecipieModel> recipiList = <RecipieModel>[];
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController foodname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> getData(String foodName) async {
      String api_key = dotenv.get("api_key", fallback: "");
      String app_id = dotenv.get("app_id", fallback: "");

      recipiList.clear();
      try {
        String url =
            await "https://api.edamam.com/search?q=$foodName&app_id=$app_id&app_key=$api_key";
        var response = await get(Uri.parse(url));
        var respondata = json.decode(response.body);

        print(respondata.toString());

        setState(() {
          print("set state1");
          respondata["hits"].forEach((element) {
            RecipieModel recipieModel = new RecipieModel();
            recipieModel = RecipieModel.fromMap(element["recipe"]);
            recipiList.add(recipieModel);
          });
        });
      } catch (e) {
        print(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/logInPage", (Route route) => false);
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(color: Color(0xffFB7901)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Srearch bar suru
                  Container(
                    width: MediaQuery.of(context).size.width * .9,
                    height: MediaQuery.of(context).size.height * .07,
                    margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.white24),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            child:
                                const Icon(Icons.search, color: Colors.white70),
                            onTap: () {
                              getData(foodname.text.toString());
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .75,
                            height: MediaQuery.of(context).size.height * .06,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: TextField(
                                controller: foodname,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: "pop_medium"),
                                cursorColor: Colors.white70,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (value) {
                                  getData(foodname.text.toString());
                                  print("Controller:${foodname.text}");
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Enter any food name',
                                  hintStyle: TextStyle(color: Colors.white70),
                                  disabledBorder: InputBorder.none,
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
                    padding: const EdgeInsets.fromLTRB(25, 20, 20, 0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 9,
                      height: MediaQuery.of(context).size.height * .20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "WHAT YOU WILL MAKE TODAY ? ",
                            style: TextStyle(
                              // overflow: TextOverflow.ellipsis,
                              color: Colors.pink,
                              fontFamily: "pop_bold",
                              fontSize: 35,
                            ),
                          ),
                          Text("Lets make a ${foodname.text} dish today ! ",
                              style: const TextStyle(
                                color: Colors.pink,
                                fontFamily: "pop_light",
                                fontSize: 18,
                              )),
                        ],
                      ),
                    ),
                  ),
                  //two Text ses
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: recipiList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            print("tapping");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => webViewDesign(
                                        recipiList[index].appUrl.toString())));
                          },
                          child: Card(
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 5, top: 10),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      recipiList[index].appImgUrl,
                                      filterQuality: FilterQuality.low,
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                          color: Colors.black45),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          recipiList[index].appLabel,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .25,
                                        decoration: const BoxDecoration(
                                            color: Colors.black45),
                                        child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 6),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                    Icons.local_fire_department,
                                                    color: Colors.deepOrange),
                                                Text(
                                                  recipiList[index]
                                                      .appCalories
                                                      .toString()
                                                      .substring(0, 6),
                                                  style: const TextStyle(
                                                      color: Colors.amberAccent,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )),
                                      ))
                                ],
                              )),
                        );
                      })
                ],
              ),
            )),
      ]),
    );
  }
}
