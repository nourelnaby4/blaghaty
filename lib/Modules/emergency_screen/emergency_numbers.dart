import 'package:flutter/material.dart';

class Emergency_Numbers extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
        elevation: 0.0,
        centerTitle:true,
        title:  Text('Emergency Numbers',
          style: TextStyle(

            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Stack(

              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.1,

                  decoration: BoxDecoration(

                      color: Colors.orange [600],
                      borderRadius: BorderRadius.only(
                          bottomLeft:   Radius.circular(50),
                          bottomRight: Radius.circular(50)
                      )
                  ),

                ),

                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child:Container(
                      alignment: Alignment.center,

                      margin: EdgeInsets.symmetric(horizontal:20),
                      padding: EdgeInsets.symmetric(horizontal:20),

                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0,10),
                            blurRadius: 50,
                            //  color: Colors.teal.withOpacity(20),

                          )
                        ],


                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Search',
                            suffixIcon: Icon(Icons.search),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none
                        ),

                      ),
                    )
                ),
              ],
            ),
            // TextFormField(
            //   decoration: InputDecoration(
            //     labelText: 'Search'
            //   ),
            // ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 155,
                  height: 110,

                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("images/122.jpg"),
                      ),

                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topRight:Radius.circular(35),
                      )
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  width: 155,
                  height: 110,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("images/555.jpg"),

                      ),

                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft:Radius.circular(35),
                      )
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 155,
                  height: 110,
                  decoration: BoxDecoration(
                  image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("images/111.jpg"),
                  ),
                  color: Colors.blue,

                ),
                  ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  width: 155,
                  height: 110,
                  decoration: BoxDecoration(
                  image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("images/180.jpg"),
                  ),
                  color: Colors.blue,
                ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 155,
                  height: 110,

                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("images/121.jpg"),
                      ),

                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomRight:Radius.circular(35),
                      )
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  width: 155,
                  height: 110,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("images/129.jpg"),

                      ),

                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft:Radius.circular(35),
                      )
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
