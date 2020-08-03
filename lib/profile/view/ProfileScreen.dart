import 'package:Radar/profile/controller/ProfileController.dart';
import 'package:Radar/chat/view/ChatScreen.dart';
import 'package:Radar/profile/view/MyRequestBar.dart';
import 'package:Radar/profile/view/MyRequestDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Radar/utils/ConnectionState.dart' as util;

class ProfileScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 13,bottom: 13,left: 27),
          child: Text('Profile',style: TextStyle(fontSize: 24),),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(top: 16,right: 28,bottom: 12.09),
            iconSize: 27,
            icon: SvgPicture.asset(
              'assets/logout.svg',color: Colors.white,
            ),
            onPressed: null,
            color: Colors.white,
          )
        ],
      ),
      body: Consumer<ProfileController>(
        builder: (context, _controller, child) {
          if (_controller.connectionState ==
              util.ConnectionState.Disconnected) {
            return Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        //backgroundImage: NetworkImage('url'),
                        radius: 60,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: ListTile(
                          trailing: IconButton(
                              icon: Icon(Icons.save), onPressed: null),
                          title: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              labelText: 'Name ',
                            ),
                            onEditingComplete: null,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_controller.myRequest != null)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      child: MyRequestBar(_controller),
                      onTap: () => showModalBottomSheet(
                        builder: (context) => MyRequestDetails(_controller),
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  )
              ],
            );
          } else if (_controller.connectionState ==
              util.ConnectionState.Connecting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            return ChatScreen(_controller, _controller.myRequest.title,
                _controller.myRequest.description);
          }
        },
      ),
    );
  }
}
