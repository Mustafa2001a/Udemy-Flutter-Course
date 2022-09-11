import 'package:flutter/material.dart';

class MassangerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20.0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('images/avatar.jpeg'),
              radius: 20.0,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsetsDirectional.all(10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Search',
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 110.0,
                child: ListView.separated(
                  itemBuilder: (context, index) => buildStoryItem(),
                  separatorBuilder: (context, index) => SizedBox(width: 5.0),
                  itemCount: 7,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ListView.separated(
                  itemBuilder: (context, index) => buildChatItem(),
                  separatorBuilder: (context, index) => SizedBox(height: 20.0),
                  itemCount: 10,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                ),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildStoryItem() => Row(
        children: [
          Container(
            width: 80.0,
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/avatar.jpeg'),
                      radius: 35.0,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        bottom: 5.0,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 8.0,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Mustafa Nael Ahmed-SH',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      );
  Widget buildChatItem() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 35.0,
            backgroundImage: AssetImage('images/avatar.jpeg'),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: 5.0,
            ),
            child: CircleAvatar(
              radius: 7.0,
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
      SizedBox(
        width: 10.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: Text(
                'Mustafa Nael SH Mustafa Nael SH Mustafa Nael SH',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Hello World! there is a new message.',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    width: 5.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Text(
                  '12:00 pm',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),


          ],
        ),
      )

    ],
  );
}
