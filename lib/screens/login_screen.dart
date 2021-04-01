import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_mobx/screens/list_screen.dart';
import 'package:todo_mobx/stores/login_store.dart';
import 'package:todo_mobx/widgets/custom_icon_button.dart';
import 'package:todo_mobx/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {

  final LoginStore loginStore = LoginStore();
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
          child: Observer(
            builder: (_) => Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    hint: 'E-Mail',
                    prefix: Icon(Icons.account_circle),
                    textInputType: TextInputType.emailAddress,
                    onChanged: loginStore.setEmail,
                    enabled: !loginStore.loading,
                  ),
                  const SizedBox(height: 16,),
                  CustomTextField(
                    hint: 'Senha',
                    prefix: Icon(Icons.lock),
                    obscure: loginStore.obscurePassword,
                    textInputType: TextInputType.emailAddress,
                    onChanged: loginStore.setPassword,
                    enabled: !loginStore.loading,
                    suffix: CustomIconButton(
                      radius: 32,
                      iconData: loginStore.obscurePassword ? Icons.visibility : Icons.visibility_off,
                      onTap: loginStore.togglePasswordVisibility,
                    ),
                  ),
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
                      onPressed: loginStore.loginPressed,
                      child: loginStore.loading ?
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                          :
                        Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
