import 'dart:io';
import 'package:database/utils/Database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../chart/data/expense_data.dart';
import '../../../chart/widget/all.dart';
import '../controller/expense_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ExpenseController controller = Get.put(ExpenseController());

  @override
  void initState() {
    super.initState();
    controller.loadDB();
    controller.sumexpense("Expense");
    controller.sumincome("Income");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color(0xFF1C2833),
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF17202A),
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF17202A),
                ),
                accountName: Text(
                  "Ravina Baldaniya",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("Ravina999@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: Padding(
                  padding: EdgeInsets.only(),
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(155, 165, 255, 137),
                    child: Text(
                      "R",
                      style: TextStyle(fontSize: 30.0, color: Colors.black),
                    ), //Text
                  ),
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Color(0xFF32B3DF),
              ),
              title: Text(
                ' My Profile ',
                style: GoogleFonts.lato(
                  fontSize: 12.sp,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w500,
                  color: kTextColor,
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.book,
                color: Color(0xFF32B3DF),
              ),
              title: Text(
                ' My Course ',
                style: GoogleFonts.lato(
                  fontSize: 12.sp,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w500,
                  color: kTextColor,
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.workspace_premium,
                color: Color(0xFF32B3DF),
              ),
              title: Text(
                ' Go Premium ',
                style: GoogleFonts.lato(
                  fontSize: 12.sp,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w500,
                  color: kTextColor,
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.video_label,
                color: Color(0xFF32B3DF),
              ),
              title: Text(
                ' Saved Videos ',
                style: GoogleFonts.lato(
                  fontSize: 12.sp,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w500,
                  color: kTextColor,
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.edit,
                color: Color(0xFF32B3DF),
              ),
              title: Text(
                ' Edit Profile Image',
                style: GoogleFonts.lato(
                  fontSize: 12.sp,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w500,
                  color: kTextColor,
                ),
              ),
              onTap: () async {
                ImagePicker picker = ImagePicker();
                XFile? xfill = await picker.pickImage(
                    source: ImageSource.gallery, imageQuality: 30);
                controller.imgPath.value = xfill!.path;
                controller.byte = await xfill.readAsBytes();
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Color(0xFF32B3DF),
              ),
              title: Text(
                'LogOut',
                style: GoogleFonts.lato(
                  fontSize: 12.sp,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w500,
                  color: kTextColor,
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            floating: true,
            expandedHeight: 10.h,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.settings,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'My Budget',
                style: GoogleFonts.lato(
                  fontSize: 12.sp,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.w500,
                  color: kTextColor,
                ),
              ),
            ),
            actions: [
              Obx(
                () => InkWell(
                  onTap: () async {},
                  child: CircleAvatar(
                    backgroundImage: FileImage(
                      File(controller.imgPath.value),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 60,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color(0xFF17202A),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Colors.red.shade200,
                                shape: BoxShape.circle),
                            child: const Icon(Icons.arrow_upward,
                                color: Colors.white),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Expense",
                                style: TextStyle(color: Colors.red.shade200),
                              ),
                              Obx(
                                () => Text(
                                  "Rs.${controller.Expense.value}",
                                  style: GoogleFonts.lato(
                                    fontSize: 12.sp,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w500,
                                    color: kTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color(0xFF17202A),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Colors.green.shade200,
                                shape: BoxShape.circle),
                            child: const Icon(Icons.arrow_downward,
                                color: Colors.white),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Income",
                                style: TextStyle(color: Colors.green.shade200),
                              ),
                              Obx(
                                () => Text(
                                  "Rs.${controller.Income.value}",
                                  style: GoogleFonts.lato(
                                    fontSize: 12.sp,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w500,
                                    color: kTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, int index) {
                if (index == 0) {
                  return Container(
                    margin: EdgeInsets.only(
                      left: 2.w,
                      right: 2.w,
                      top: 2.h,
                      bottom: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(3.h),
                    ),
                    child: CustomChart(
                      expenses: weeklySpending,
                    ),
                  );
                } else {
                  return Container();
                }
              },
              childCount: 1,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        "Recent Transactions",
                        style: GoogleFonts.lato(
                          fontSize: 17.sp,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500,
                          color: kTextColor,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.toNamed('/Tran');
                        },
                        child: Text(
                          "See all",
                          style: GoogleFonts.lato(
                            fontSize: 12.sp,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w500,
                            color: kTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 83,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                              setState(() {
                                                controller
                                                    .sumexpense("Expense");
                                                controller.sumincome("Income");
                                              });
                                            },
                                            icon: Icon(Icons.edit,
                                                color: Colors.grey.shade700),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              DB_helper dbHelper = DB_helper();
                                              dbHelper.deleteDB(controller
                                                  .dataList[index]['id']);
                                              setState(() {
                                                controller.loadDB();
                                                controller
                                                    .sumexpense("Expense");
                                                controller.sumincome("Income");
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
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          Get.toNamed("/add", arguments: {"option": 1, "index": null});
        },
        child: const Icon(Icons.add, size: 25, color: Colors.amber),
      ),
    );
  }
}
