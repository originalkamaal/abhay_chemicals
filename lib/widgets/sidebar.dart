import 'package:abhay_chemicals/controllers/auth_controller.dart';
import 'package:abhay_chemicals/widgets/info_card.dart';
import 'package:abhay_chemicals/widgets/sidebar_menu_item.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: double.infinity,
        color: const Color.fromARGB(255, 10, 8, 31),
        padding: const EdgeInsets.only(top: 30),
        child: Column(children: [
          const InfoCard(
            name: "Admin",
            email: "email@email.com",
          ),
          const SizedBox(
            height: 30,
          ),
          SidebarMenuItem(
            title: "Dashboard",
            assetSvg: "assets/images/ac_dashboard.svg",
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/home", (route) => false);
            },
          ),
          SidebarMenuItem(
            title: "Customers",
            assetSvg: "assets/images/ac_customers.svg",
            onTap: () {
              Navigator.of(context).popAndPushNamed("/customers");
            },
          ),
          SidebarMenuItem(
              title: "Suppliers",
              assetSvg: "assets/images/ac_supplier.svg",
              onTap: () {
                Navigator.of(context).popAndPushNamed("/suppliers");
              }),
          SidebarMenuItem(
            title: "Users",
            assetSvg: "assets/images/ac_admin.svg",
            onTap: () {
              Navigator.of(context).popAndPushNamed("/users");
            },
          ),
          ListTile(
            onTap: () {
              AuthController(context: context).logout();
            },
            title: const Text("Logout", style: TextStyle(color: Colors.white)),
            leading: const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                )),
          )
        ]),
      ),
    );
  }
}
