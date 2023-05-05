import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:abhay_chemicals/controllers/customers_controllers.dart';
import 'package:abhay_chemicals/widgets/appbar_widget.dart';
import 'package:abhay_chemicals/widgets/buttons_widgets.dart';
import 'package:abhay_chemicals/widgets/error_text.dart';
import 'package:abhay_chemicals/widgets/input_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCustomer extends StatefulWidget {
  const AddCustomer({super.key});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  String selectedCareOf = "0";
  String name = "";
  String mobile = "";
  String village = "";
  String badd = "";
  bool isSameAsBill = false;
  String bpin = "";
  String sadd = "";
  String spin = "";

  String nameErr = "";
  String mobileErr = "";
  String villageErr = "";
  String careofErr = "";
  String mainErr = "";

  bool validation() {
    bool result = true;
    setState(() {
      nameErr = "";
      mobileErr = "";
      villageErr = "";
      careofErr = "";
    });
    if (name == "") {
      setState(() {
        nameErr = "Please enter name";
      });
      result = false;
    }

    if (mobile.length != 10) {
      setState(() {
        mobileErr = "Invalid mobile number";
      });
      result = false;
    }
    if (village == "") {
      setState(() {
        villageErr = "Village is mandatory";
      });
      result = false;
    }
    if (selectedCareOf == "0") {
      setState(() {
        careofErr = "Please select careof";
      });
      result = false;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    BuildContext ctx = context;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar("Add Customer"),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ErrorText(nameErr: mainErr),
                reusableText("Name", 10.w),
                buildTextInput(
                  placeHolder: "Enter Namer",
                  inputType: "text",
                  iconName: "ang",
                  onChange: ((value) {
                    setState(() {
                      name = value;
                    });
                  }),
                ),
                ErrorText(nameErr: nameErr),
                reusableText("Contact Number", 10.w),
                buildTextInput(
                  placeHolder: "Enter Contact Number",
                  inputType: "mobile",
                  iconName: "ang",
                  onChange: ((value) {
                    setState(() {
                      mobile = value;
                    });
                  }),
                ),

                ErrorText(nameErr: mobileErr),
                reusableText("Village", 10.w),
                buildTextInput(
                  placeHolder: "Enter Village",
                  inputType: "text",
                  iconName: "ang",
                  onChange: ((value) {
                    setState(() {
                      village = value;
                    });
                  }),
                ),

                ErrorText(nameErr: villageErr),
                reusableText("Care Of", 10.w),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("careof")
                        .snapshots(),
                    builder: (context, snapShot) {
                      List<DropdownMenuItem> careofsItems = [];
                      careofsItems.add(DropdownMenuItem(
                        child: reusableText("Select Careof", 0),
                        value: "0",
                      ));
                      if (!snapShot.hasData) {
                        return const CircularProgressIndicator();
                      } else {
                        final careofs = snapShot.data!.docs.toList();
                        for (var careof in careofs) {
                          careofsItems.add(DropdownMenuItem(
                            child: Text(
                              careof['name'],
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            value: careof.reference.path,
                          ));
                        }
                      }
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.w),
                            border: Border.all(
                                color: AppColors.primaryThreeElementText)),
                        width: double.maxFinite,
                        height: 50.w,
                        child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                          isExpanded: false,
                          value: selectedCareOf,
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              selectedCareOf = value.toString();
                            });
                          },
                          items: careofsItems,
                        )),
                      );
                    }),

                ErrorText(nameErr: careofErr),
                reusableText("Billing Address", 10.w),
                buildTextInput(
                  placeHolder: "Billing Address",
                  inputType: "text",
                  iconName: "ang",
                  onChange: ((value) {
                    setState(() {
                      badd = value;
                    });
                  }),
                ),

                // Create a flutter date input statefull widget here

                reusableText("Billing Pincode", 10.w),
                buildTextInput(
                  placeHolder: "Billing Pincode",
                  inputType: "number",
                  iconName: "ang",
                  onChange: ((value) {
                    setState(() {
                      bpin = value;
                    });
                  }),
                ),
                Row(children: [
                  Checkbox(
                      value: isSameAsBill,
                      onChanged: (value) {
                        setState(() {
                          isSameAsBill = value!;
                        });
                      }),
                  reusableText("Same as Billing?", 5)
                ]),
                Visibility(
                    visible: isSameAsBill == false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reusableText("Shipping Address", 10.w),
                        buildTextInput(
                          placeHolder: "Shipping Address",
                          inputType: "text",
                          iconName: "ang",
                          onChange: ((value) {
                            setState(() {
                              sadd = value;
                            });
                          }),
                        ),
                        reusableText("Shipping Pincode", 10.w),
                        buildTextInput(
                          placeHolder: "Shipping Pincode",
                          inputType: "number",
                          iconName: "ang",
                          onChange: ((value) {
                            setState(() {
                              spin = value;
                            });
                          }),
                        ),
                      ],
                    )),
                GestureDetector(
                    onTap: () async {
                      if (validation()) {
                        bool status = await CustomersController().addCustomer(
                            name: name,
                            mobile: int.parse(mobile),
                            village: village,
                            reference:
                                FirebaseFirestore.instance.doc(selectedCareOf),
                            billingAddress: badd,
                            billingPin: (bpin),
                            shippingAddress: isSameAsBill ? badd : sadd,
                            shippingPin: isSameAsBill ? (bpin) : (spin));
                        if (status) {
                          Navigator.pop(ctx);
                        } else {
                          setState(() {
                            mainErr = "Something went wrong..";
                          });
                        }
                      }
                    },
                    child: filledButton(AppColors.primaryElement, "SUBMIT")),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ));
  }
}
