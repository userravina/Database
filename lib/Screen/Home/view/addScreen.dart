import 'package:database/Screen/Home/controller/expense_controller.dart';
import 'package:database/Screen/Home/modal/expense_modal.dart';
import 'package:database/utils/Database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../chart/widget/all.dart';

class AddInDataBase extends StatefulWidget {
  const AddInDataBase({super.key});

  @override
  State<AddInDataBase> createState() => _AddInDataBaseState();
}

class _AddInDataBaseState extends State<AddInDataBase> {
  ExpenseController controller = Get.put(ExpenseController());
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtcate = TextEditingController();
  TextEditingController txtNotes = TextEditingController();
  TextEditingController txtTags = TextEditingController();

  Map mapData = {};

  @override
  void initState() {
    super.initState();
    mapData = Get.arguments!;

    if (mapData['option'] == 0) {
      int index = mapData['index'];
      controller.inClick.value = controller.dataList[index]['category'];
      txtAmount = TextEditingController(
          text: "${controller.dataList[index]['amount']}");
      txtNotes =
          TextEditingController(text: "${controller.dataList[index]['note']}");
      // controller.date =  controller.dataList[index]['date'];
      // controller.time =  controller.dataList[index]['time'];
      controller.dropDown.value = controller.dataList[index]['status'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          titleSpacing: 2,
          title: Text(
            mapData['option'] == 1 ? "Add Category" : "Update",
            style: GoogleFonts.lato(
              fontSize: 12.sp,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w500,
              color: kTextColor,
            ),
          ),
          backgroundColor: const Color(0xFF17202A),
          actions: [
            DropdownButton(
              hint: Text(
                controller.dropDown.value,
                style: const TextStyle(color: Colors.white),
              ),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              items: ["Income", "Expense"].map((String value) {  
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.lato(
                      fontSize: 13. sp,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  controller.dropDown.value = newValue!;
                });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: txtAmount,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    border: UnderlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide.none,
                    ),
                    labelText: "Amount",
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.currency_rupee,
                      color: Color(0xFF32B3DF),
                      size: 30,
                    ),
                    // suffixIcon: IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.calculate, color: Colors.black),
                    // ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  height: 1,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                ),
                TextField(
                  controller: txtNotes,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    border: UnderlineInputBorder(
                      // borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide.none,
                    ),
                    labelText: "note",
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.notes_rounded,
                      color: Color(0xFF32B3DF),
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  height: 1,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        controller.date = (await showDatePicker(
                            context: context,
                            initialDate: controller.currentDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030)))!;
                        controller.changeDate(controller.date);
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Obx(
                      () => Text(
                        "${controller.day.value}/${controller.mon.value}/${controller.year.value}",
                        style: GoogleFonts.lato(
                          fontSize: 16.sp,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w500,
                          color: kTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  height: 1,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        controller.time = (await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay(
                                hour: controller.currentTime.hour,
                                minute: controller.currentTime.minute)))!;
                        controller.changeTime(controller.time);
                      },
                      icon: const Icon(Icons.access_time_filled_rounded),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Obx(
                      () => Text(
                        "${controller.hour.value}:${controller.minute.value}",
                        style: GoogleFonts.lato(
                          fontSize: 16.sp,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w500,
                          color: kTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  height: 1,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "          Category",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                          color: Color(0xFF32B3DF), shape: BoxShape.circle),
                      child: const Icon(Icons.more_horiz, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Obx(
                      () => Text(
                        controller.inClick.value,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Get.defaultDialog(
                          content: ShowDialogCate(),
                          backgroundColor: const Color(0xFF17202A),
                          title: "Categories",
                          titleStyle: const TextStyle(
                              fontSize: 25, color: Colors.white),
                        );
                      },
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  height: 1,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            DB_helper dbHelper = DB_helper();

            if (mapData['option'] == 0) {
              ExpenseModel model = ExpenseModel(
                id: controller.dataList[mapData['index']]['id'],
                category: controller.inClick.value,
                amount: int.parse(txtAmount.text),
                date:
                    "${controller.day.value}/${controller.mon.value}/${controller.year.value}",
                status: controller.dropDown.value,
                note: txtNotes.text,
                time: "${controller.hour.value}:${controller.minute.value}",
              );
              await dbHelper.updateDB(model);
            } else {
              ExpenseModel model = ExpenseModel(
                  category: controller.inClick.value,
                  amount: int.parse(txtAmount.text),
                  note: txtNotes.text,
                  date:
                      "${controller.day.value}/${controller.mon.value}/${controller.year.value}",
                  time: "${controller.hour.value}:${controller.minute.value}",
                  status: controller.dropDown.value);
              await dbHelper.insertInDB(model);
            }
            await controller.loadDB();
            Get.back();
          },
          backgroundColor: const Color(0xFF17202A),
          child: const Icon(Icons.account_balance_wallet_rounded,
              color: Colors.white),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ShowDialogCate() {
    return SizedBox(
      width: 200,
      height: 300,
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        controller.changeCategory(controller.categories[index]);
                        Get.back();
                      },
                      child: Obx(
                        () => Text(
                          "${controller.categories[index]}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: controller.categories.length,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.defaultDialog(
                backgroundColor: Colors.white,
                title: "Add the category",
                titleStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                content: categoryDialog(),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Text(
              "Add Category",
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryDialog() {
    return Column(
      children: [
        TextField(
          controller: txtcate,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Category"),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
           setState(() {
             controller.categories.add(txtcate.text);
             controller.sumincome("Income");
             controller.sumincome("Expense");
           });
            Get.back();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF17202A)),
          child: const Text("Add"),
        ),
      ],
    );
  }
}
