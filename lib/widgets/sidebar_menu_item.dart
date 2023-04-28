import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SidebarMenuItem extends StatelessWidget {
  const SidebarMenuItem(
      {super.key, required this.title, required this.assetSvg, this.onTap});

  final String title, assetSvg;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title, style: const TextStyle(color: Colors.white)),
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: SvgPicture.asset(
          assetSvg,
          width: 20,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          semanticsLabel: title,
        ),
      ),
    );
  }
}
