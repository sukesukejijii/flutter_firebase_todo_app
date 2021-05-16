import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;

  const TodoFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onSavedTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          SizedBox(height: 8),
          buildDescription(),
          SizedBox(height: 32),
          buildButton(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return TextFormField(
      maxLines: 1,
      autofocus: true,
      initialValue: title,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Title',
      ),
      onChanged: onChangedTitle,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Title cannot be empty';
        }
      },
    );
  }

  Widget buildDescription() {
    return TextFormField(
      minLines: 5,
      maxLines: 10,
      initialValue: description,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Description',
      ),
      onChanged: onChangedDescription,
    );
  }

  Widget buildButton() {
    return ElevatedButton(
      onPressed: onSavedTodo,
      child: Text('Save'),
    );
  }
}
