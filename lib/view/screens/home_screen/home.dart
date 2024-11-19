import 'package:final_exam_2/controller/home_controller.dart';
import 'package:final_exam_2/modal/modal.dart';
import 'package:final_exam_2/service/auth_service.dart';
import 'package:final_exam_2/service/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Expanse'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: homeController.txtTitle,
                      decoration: InputDecoration(
                          hintText: 'Title',
                          labelText: 'Title',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )),
                    ),
                    SizedBox(
                      height: h * 0.007,
                    ),
                    TextFormField(
                      controller: homeController.txtCategory,
                      decoration: InputDecoration(
                          hintText: 'Category',
                          labelText: 'Category',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )),
                    ),
                    SizedBox(
                      height: h * 0.007,
                    ),
                    TextFormField(
                      controller: homeController.txtAmount,
                      decoration: InputDecoration(
                          hintText: 'Amount',
                          labelText: 'Amount',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )),
                    ),
                    SizedBox(
                      height: h * 0.007,
                    ),

                    TextFormField(
                      controller: homeController.txtDate,
                      decoration: InputDecoration(
                          hintText: 'Date',
                          labelText: 'Date',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          )),
                    ),
                    // ListTile(
                    //   title: Text('Select Date'),
                    //   leading: Icon(Icons.date_range),
                    //   onTap: () async {
                    //     DateTime? date = await showDatePicker(
                    //         context: context,
                    //         firstDate: DateTime(1900),
                    //         lastDate: DateTime(2030));
                    //     if (date != null) date;
                    //   },
                    // )
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      ExpanseModal expanse = ExpanseModal(
                        title: homeController.txtTitle.text,
                        amount: homeController.txtCategory.text,
                        date: homeController.txtAmount.text,
                        category: homeController.txtDate.text,
                      );
                      DbHelper.dbHelper.insertData(expanse);
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                AuthService().logout();
                Get.offAllNamed('/login');
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: FutureBuilder(
        future: homeController.readDataDatabase(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ExpanseModal> expanse = [];
            expanse = homeController.expanseList
                .map(
                  (e) => ExpanseModal.fromJson(e),
                )
                .toList();
            return ListView.builder(
              itemCount: homeController.expanseList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  /*providerTrue.id = notesModal[index].id;
                        providerTrue.txtTitle.text = notesModal[index].title;
                        providerTrue.txtCategory.text =
                            notesModal[index].category;
                        providerTrue.txtAmount.text = notesModal[index].amount;*/
                  title: Text(homeController.txtTitle.text),
                  subtitle: Text(homeController.txtTitle.text),
                  leading: Text(homeController.txtTitle.text +
                      homeController.txtTitle.text),
                  trailing: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog();
                              },
                            );
                          },
                          icon: Icon(Icons.edit))
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
