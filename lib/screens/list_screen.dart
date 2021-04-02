import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobx/screens/login_screen.dart';
import 'package:todo_mobx/stores/list_store.dart';
import 'package:todo_mobx/stores/login_store.dart';
import 'package:todo_mobx/widgets/custom_icon_button.dart';
import 'package:todo_mobx/widgets/custom_text_field.dart';

class ListScreen extends StatefulWidget {

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  ListStore listStore;
  LoginStore loginStore;
  TextEditingController _controller;
  ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();
    listStore = ListStore();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loginStore = Provider.of<LoginStore>(context);
    disposer = reaction(
      (_) => loginStore.loggedIn,
      (loggedIn) {
        if (!loggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen())
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.fromLTRB(32, 0, 32, 32),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tarefas',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    color: Colors.white,
                    onPressed: loginStore.logout,
                  )
                ],
              ),
            ),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 16,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Observer(
                        builder: (_) {
                          return CustomTextField(
                            controller: _controller,
                            hint: 'Tarefa',
                            onChanged: listStore.setNewTodoTitle,
                            suffix: listStore.isFormValid ? CustomIconButton(
                              radius: 32,
                              iconData: Icons.add,
                              onTap: () {
                                listStore.addTodo();
                                _controller.clear();
                              },
                            ) : null,
                          );
                        }
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: Observer(
                          builder: (_) {
                            return ListView.separated(
                              itemCount: listStore.todoList.length,
                              itemBuilder: (_, index) {
                                final todo = listStore.todoList[index];
                                return Observer(
                                  builder: (_) {
                                    return ListTile(
                                      title: Text(
                                        todo.title,
                                        style: TextStyle(
                                          decoration: todo.done ?
                                            TextDecoration.lineThrough : null,
                                          color: todo.done ? Colors.grey : Colors.black,
                                        ),
                                      ),
                                      onTap: todo.toggleDone,
                                    );
                                  }
                                );
                              },
                              separatorBuilder: (_, index) {
                                return Divider();
                              },
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }
}
