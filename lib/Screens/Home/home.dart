import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/Constants/colors.dart';
import 'package:task_app/Models/list_item_model.dart';
import 'package:task_app/Provider/app_provider.dart';
import 'package:task_app/Screens/Home/widgets/list_item_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final StreamController _streamController = StreamController();
  final TextEditingController editController = TextEditingController();

  Stream<List<ListItem>> getList(context) async* {
    for (var i = 0;; i++) {
      _streamController.sink
          .add(Provider.of<AppProvider>(context, listen: false).getItems);
      await Future.delayed(const Duration(seconds: 5), () {
        Provider.of<AppProvider>(context, listen: false).addItem();
      });

      yield Provider.of<AppProvider>(context, listen: false).getItems;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Task App"),
      ),
      body: StreamBuilder(
          stream: getList(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: Provider.of<AppProvider>(context).getItems.length,
                  itemBuilder: (context, index) {
                    return ListItemWidget(
                      item: snapshot.data![index],
                      onEdit: () {
                        editDialog(context, index, editController);
                      },
                      onDelete: () {
                        final removedItem = snapshot.data![index];
                        deleteDialog(context, index, removedItem);
                      },
                    );
                  });
            } else {
              return Container();
            }
          }),
    );
  }

  void deleteDialog(context, index, removedItem) {
    showDialog(
        context: context,
        builder: (contextInsideDialog) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
            child: Container(
              width: double.infinity,
              // height: 400,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Warning",
                                  style: TextStyle(
                                      color: MediaQuery.of(context)
                                                  .platformBrightness ==
                                              Brightness.dark
                                          ? darkTextColorTheme
                                          : lightTextColorTheme,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        Text(
                          "Are you sure you want to delete?",
                          style: TextStyle(
                              fontFamily: "av-regular",
                              color:
                                  MediaQuery.of(context).platformBrightness ==
                                          Brightness.dark
                                      ? darkTextColorTheme
                                      : lightTextColorTheme,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              elevation: 5,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              minWidth: MediaQuery.of(context).size.width * 0.3,
                              color: Colors.red,
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: "av-regular"),
                              ),
                              onPressed: () async {
                                Navigator.of(context).pop();
                                Provider.of<AppProvider>(context, listen: false)
                                    .removeItem(index);
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            MaterialButton(
                              elevation: 5,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              minWidth: MediaQuery.of(context).size.width * 0.3,
                              color: Color.fromARGB(255, 120, 120, 120),
                              child: Text(
                                "No",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: "av-regular"),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void editDialog(context, index, editController) {
    showDialog(
        context: context,
        builder: (contextInsideDialog) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
            child: Container(
              width: double.infinity,
              // height: 400,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Edit",
                                    style: TextStyle(
                                        color: MediaQuery.of(context)
                                                    .platformBrightness ==
                                                Brightness.dark
                                            ? darkTextColorTheme
                                            : lightTextColorTheme,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          TextField(
                            controller: editController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: BorderSide(
                                        color: MediaQuery.of(context).platformBrightness ==
                                                Brightness.dark
                                            ? darkTextColorTheme
                                            : lightTextColorTheme,
                                        width: 1)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: BorderSide(
                                        color: MediaQuery.of(context).platformBrightness ==
                                                Brightness.dark
                                            ? darkTextColorTheme
                                            : lightTextColorTheme,
                                        width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: BorderSide(
                                        color:
                                            MediaQuery.of(context).platformBrightness ==
                                                    Brightness.dark
                                                ? darkTextColorTheme
                                                : lightTextColorTheme,
                                        width: 1))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                elevation: 5,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.3,
                                color: Colors.blue,
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: "av-regular"),
                                ),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .editItem(index, editController.text);
                                  editController.text = "";
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
