import 'package:database/Screen/Home/controller/expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../chart/widget/all.dart';
import '../../../utils/Database_helper.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  TextEditingController txtSearch = TextEditingController();
  ExpenseController controller = ExpenseController();

  @override
  void initState() {
    controller.loadDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  if(value.isEmpty) {
                    controller.loadDB();
                  }
                },
                controller: txtSearch,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(
                      color: Color(0xFF32B3DF),
                    ),
                  ),
                  suffixIcon: Padding(padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: () {
                        String search = txtSearch.text;
                        controller.getcate(search);
                      },
                      icon: const Icon(Icons.search,color: Color(0xFF32B3DF),size: 30,),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF17202A),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              spreadRadius: 2,
                              offset: Offset(1, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 83,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(1, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${controller.dataList[index]['category']}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      height: 40,
                                      width: 83,
                                      decoration: BoxDecoration(
                                        color: controller.dataList[index]
                                                    ['status'] ==
                                                "Income"
                                            ? Colors.green.shade200
                                            : Colors.red.shade200,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(1, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${controller.dataList[index]['status']}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "${controller.dataList[index]['amount']}",
                                  style: GoogleFonts.lato(
                                    fontSize: 14.sp,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w500,
                                    color: kTextColor,
                                  ),
                                ),
                                Text(
                                  "${controller.dataList[index]['note']}",
                                  style: GoogleFonts.lato(
                                    fontSize: 12.sp,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w500,
                                    color: kTextColor,
                                  ),
                                ),
                              ],
                            ),
                            const Expanded(child: SizedBox()),
                            Column(
                              children: [
                                Text(
                                  "${controller.dataList[index]['date']}",
                                  style: GoogleFonts.lato(
                                    fontSize: 12.sp,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w500,
                                    color: kTextColor,
                                  ),
                                ),
                                Text(
                                  "${controller.dataList[index]['time']}",
                                  style: GoogleFonts.lato(
                                    fontSize: 12.sp,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w500,
                                    color: kTextColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Get.toNamed("/add", arguments: {
                                          "option": 0,
                                          "index": index
                                        });
                                      },
                                      icon: Icon(Icons.edit,
                                          color: Colors.grey.shade700),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        DB_helper dbHelper = DB_helper();
                                        dbHelper.deleteDB(
                                            controller.dataList[index]['id']);
                                        setState(() {
                                          controller.loadDB();
                                        });
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Colors.red.shade300),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: controller.dataList.length,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
