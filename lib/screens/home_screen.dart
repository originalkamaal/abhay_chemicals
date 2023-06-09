import 'package:abhay_chemicals/blocs/common_bloc/common_bloc.dart';
import 'package:abhay_chemicals/screens/expense/expense.dart';
import 'package:abhay_chemicals/screens/production/prodcution.dart';
import 'package:abhay_chemicals/screens/purchase/purchase.dart';
import 'package:abhay_chemicals/screens/home/home.dart';
import 'package:abhay_chemicals/screens/sales/sales_order.dart';
import 'package:abhay_chemicals/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
      allowImplicitScrolling: true,
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: const <Widget>[
        Home(),
        AddProduction(),
        OrdersAndSales(),
        AddPurchase(),
        Expense()
      ],
    );
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
    return BlocBuilder<CommonBloc, CommonState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Image.asset(
              "assets/images/logo.png",
              height: 60,
              fit: BoxFit.fitHeight,
            ),
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            actionsIconTheme: const IconThemeData(color: Colors.black),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.search_outlined)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_outlined)),
            ],
          ),
          drawer: const SideBar(),
          body: buildPageView(),
          bottomNavigationBar: BottomNavigationBar(
            iconSize: 25,
            backgroundColor: const Color.fromARGB(255, 135, 205, 100),
            selectedItemColor: Colors.white,
            onTap: (index) {
              bottomTapped(index);
            },
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
            unselectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
            currentIndex: pageIndex,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: const Color.fromARGB(255, 34, 78, 12),
            items: buildBottomNavBarItems(),
          ),
        );
      },
    );
  }
}
