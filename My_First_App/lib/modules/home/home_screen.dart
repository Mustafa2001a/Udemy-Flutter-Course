import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('First Apptication'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                print('Search');
              },
            ),
            IconButton(
                icon: Icon(Icons.notification_important),
                onPressed: () {
                  print('Notification');
                }),
          ],
          backgroundColor: Colors.red,
          centerTitle: true,
          elevation: 10.0,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(100),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  )
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: 200.0,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image(
                      image: AssetImage('flwr.jpg'),
                      height: 200.0,
                      width: 200.0,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: EdgeInsetsDirectional.only(
                        top: 5.0,
                        bottom: 5.0,
                      ),
                      color: Colors.black.withOpacity(0.8),
                      width: double.infinity,
                      child: Text(
                          'Flower',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                      ),
                    )
                  ],
                ),
              ),
            ),

          ],
        )
    );
  }
}
