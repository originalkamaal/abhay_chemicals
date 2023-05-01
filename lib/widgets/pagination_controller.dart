import 'package:abhay_chemicals/blocs/customers_bloc/customers_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginationController<B, S> extends StatefulWidget {
  final B bloc;
  final BuildContext context;
  final S state;
  const PaginationController(
      {super.key,
      required this.bloc,
      required this.context,
      required this.state});

  @override
  State<PaginationController> createState() => _PaginationControllerState();
}

class _PaginationControllerState extends State<PaginationController> {
  List<String> items = ["10", "20", "30", "50"];
  String selectedCount = "10";
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
                style: TextStyle(fontSize: 12.sp, color: Colors.black),
                dropdownColor: const Color.fromARGB(255, 237, 246, 237),
                value: selectedCount,
                items: items.map((e) {
                  return DropdownMenuItem(value: e, child: Text(e));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCount = value.toString();
                    context
                        .read<CustomersBloc>()
                        .add(LoadCustomers(limit: int.parse(value!)));
                  });
                }),
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                if (this.widget.state.pageNumber > 1) {
                  this.widget.bloc.add(LoadCustomers(
                      direction: "back",
                      pageNumber: this.widget.state.pageNumber,
                      limit: this.widget.state.limit,
                      lastDoc: this.widget.state.customers!.docs.first));
                }
              },
              child: Container(
                color: const Color.fromARGB(255, 237, 246, 237),
                padding: const EdgeInsets.all(5),
                child: const Center(child: Icon(Icons.chevron_left)),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (this.widget.state.customers!.docs.length ==
                    this.widget.state.limit) {
                  this.widget.bloc.add(LoadCustomers(
                      direction: "forward",
                      pageNumber: this.widget.state.pageNumber,
                      limit: this.widget.state.limit,
                      lastDoc: this.widget.state.customers!.docs.last));
                }
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 20),
                color: const Color.fromARGB(255, 237, 246, 237),
                padding: const EdgeInsets.all(5),
                child: const Center(child: Icon(Icons.chevron_right)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Row paginationControllers(
//     BuildContext context, S state, B bloc) {
  
// }
