import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:abhay_chemicals/screens/home/add_expense.dart';
import 'package:abhay_chemicals/screens/home/add_prodcution.dart';
import 'package:abhay_chemicals/screens/home/add_purchase.dart';
import 'package:abhay_chemicals/screens/home/add_sales.dart';
import 'package:abhay_chemicals/screens/home/home.dart';
import 'package:abhay_chemicals/widgets/input_widgets.dart';
import 'package:abhay_chemicals/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  int pageNo = 0;
  HomeScreen({pageNo = 0, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageChanged(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      pageIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        if (widget.pageNo > 0) {
          pageChanged(widget.pageNo);
        } else {
          pageChanged(index);
        }
      },
      children: const <Widget>[
        Home(),
        AddProduction(),
        AddSales(),
        AddPurchase(),
        AddExpense()
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.window),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.factory),
        label: 'Production',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.trending_up_outlined),
        label: 'Sales',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.fire_truck_rounded),
        label: 'Purchase',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.money),
        label: 'Expense',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          height: 60,
          fit: BoxFit.fitHeight,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actionsIconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notifications_outlined)),
        ],
      ),
      drawer: SideBar(),
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        backgroundColor: Color.fromARGB(255, 135, 205, 100),
        selectedItemColor: Colors.white,
        onTap: bottomTapped,
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
        unselectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
        currentIndex: pageIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color.fromARGB(255, 34, 78, 12),
        items: buildBottomNavBarItems(),
      ),
    );
  }
}
