import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/global_ui_viewmodel.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  void logout() async{
    _ui.loadState(true);
    try{
      await _auth.logout().then((value){
        Navigator.of(context).pushReplacementNamed('/login');
      })
          .catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    }catch(err){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
    }
    _ui.loadState(false);
  }

  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;
  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _auth = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          SizedBox(
            height: 60,
          ),
          Text("My Account" , style: TextStyle(fontFamily: 'Poppins' , color: Colors.pink , fontSize:
          20 , fontWeight: FontWeight.bold , ),),
          Image.asset(
            "assets/images/img_3.png",
            height: 100,
            width: 800,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Text(_auth.loggedInUser!.email.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black,),),
          ),
          SizedBox(
            height: 30,
          ),
          makeSettings(
              icon: Icon(Icons.fireplace_outlined, color: Colors.black, size: 40),
              title: "Candle",
              subtitle: "View Products",
              onTap: (){
                Navigator.of(context).pushNamed("/my-products");
              }
          ),
          makeSettings(
              icon: Icon(Icons.logout, color: Colors.black, size: 40),
              title: "Logout",
              subtitle: "Logout from this application",
              onTap: (){
                logout();
              }
          ),
          makeSettings(
              icon: Icon(Icons.android , color: Colors.black, size: 40),
              title: "Version",
              subtitle: "0.0.1",
              onTap: (){

              }
          )
        ],
      ),
    );
  }

  makeSettings({required Icon icon, required String title, required String subtitle, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
            elevation: 4,
            child: ListTile(
                tileColor: Colors.pink.shade100,
                textColor: Colors.black,titleTextStyle: TextStyle(fontWeight: FontWeight.bold , fontSize: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                leading: icon,
                title: Text(
                  title,
                ),
                subtitle: Text(
                  subtitle,
                ))),
      ),
    );
  }
}
