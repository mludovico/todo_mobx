import 'package:flutter/material.dart';
import 'package:todo_mobx/screens/list_screen.dart';
import 'package:todo_mobx/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(32),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 16,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(),
                SizedBox(height: 16,),
                CustomTextField(),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => ListScreen())
                      );
                    },
                    child: Text('Login'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
