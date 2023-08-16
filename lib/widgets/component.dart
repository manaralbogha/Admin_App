import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//SIGN OUT
/*
void signOut(context)
{
  CacheHelper.removeData(key: 'token',).then((value)
  {
    if(value)
    {
      navigateAndReplacement(context ,MedManageLoginScreen());
    }
  });
}*/

//divider
Widget myDivider()=> Padding(
  padding:const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width:double.infinity,
    height:1.0,
    color:Colors.grey[200] ,
  ),);


void navigateTo(context,Widget)
{
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Widget),
  );
}
void navigateAndReplacement(context,Widget)=>Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
      builder: (context) => Widget
  ),
      (Route<dynamic> route) => false,//الغي احط فولس
);

Widget defTextButton({required Function function,required String text, required Color color })=>TextButton(//Register now
  onPressed: (){
    function();
  },
  child: Text(text.toUpperCase()),);


//for TFF Or Any form contain icon
Widget defContainerWithIcon({required IconData icon, })=> Container(
  width: 45.0,
  height: 45.0,
  decoration: const BoxDecoration(
      color: Color(0xFFd9d9d9),
      borderRadius: BorderRadius.all(Radius.circular(10))),
  child:  Icon(
    icon,
    size: 30.0,
    color: const Color(0xFF709895),
  ),
);
