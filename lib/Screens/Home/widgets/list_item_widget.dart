import 'package:flutter/material.dart';
import 'package:task_app/Constants/colors.dart';
import 'package:task_app/Models/list_item_model.dart';

class ListItemWidget extends StatelessWidget {
  final ListItem item;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  const ListItemWidget(
      {super.key,
      required this.item,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return buildItem(context);
  }

  Widget buildItem(context) => Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Colors.black
                : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: ListTile(
          contentPadding: EdgeInsets.all(12),
          leading: CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage(item.image!),
          ),
          title: Text(
            item.title!,
            style: TextStyle(
                fontSize: 20,
                color:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? darkTextColorTheme
                        : lightTextColorTheme),
          ),
          trailing: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              children: [
                IconButton(
                    onPressed: onEdit,
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue,
                      size: 32,
                    )),
                IconButton(
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 32,
                    )),
              ],
            ),
          ),
        ),
      );
}
