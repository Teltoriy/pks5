import 'package:flutter/material.dart';
class Profile extends StatelessWidget{
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100,),
            Icon(Icons.accessible_forward_outlined, size: 200.0),
            SizedBox(height: 10,),
            Text("Пустотреп Телторий", style: TextStyle(
                fontSize: 22
            ),),
            SizedBox(height: 10,),
            Text("pustotrep@gmail.com"),
            SizedBox(height: 10,),
            Text("+798517813xdd"),
            SizedBox(height: 20,),
          ],
        ),
      ),
      persistentFooterButtons: [
        SizedBox.expand(child: TextButton(onPressed: (){}, child: const Text("Выйти", style: TextStyle(fontSize: 18),),))
      ],
    );
  }
}