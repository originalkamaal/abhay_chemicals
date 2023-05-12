import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:abhay_chemicals/controllers/supplier_controller.dart';
import 'package:abhay_chemicals/widgets/appbar_widget.dart';
import 'package:abhay_chemicals/widgets/buttons_widgets.dart';
import 'package:abhay_chemicals/widgets/error_text.dart';
import 'package:abhay_chemicals/widgets/input_widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddSupplier extends StatefulWidget {
  const AddSupplier({super.key});

  @override
  State<AddSupplier> createState() => _AddSupplierState();
}

class _AddSupplierState extends State<AddSupplier> {
  String name = "";
  String mobile = "";
  String email = "";

  String nameErr = "";
  String mobileErr = "";
  String emailErr = "";

  bool validation() {
    bool result = true;
    if (name == "") {
      setState(() {
        nameErr = "Name cannot be empty";
      });
      result = false;
    }
    if (mobile.length != 10) {
      setState(() {
        mobileErr = "Number invalid";
      });
      result = false;
    }
    if (EmailValidator.validate(email) == false) {
      setState(() {
        emailErr = "Email Invalid";
      });
      result = false;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: buildAppBar("Edit Supplier $name"),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              reusableText("Company or Individual Name", 20.w),
              buildTextInput(
                placeHolder: "Enter Name",
                inputType: "text",
                iconName: "person",
                onChange: ((value) {
                  setState(() {
                    name = value;
                  });
                }),
              ),
              ErrorText(nameErr: nameErr),
              reusableText("Contact Number", 20.w),
              buildTextInput(
                placeHolder: "Enter Contact Number",
                inputType: "mobile",
                iconName: "",
                onChange: ((value) {
                  setState(() {
                    mobile = value;
                  });
                }),
              ),
              ErrorText(nameErr: mobileErr),
              reusableText("Email", 20.w),
              buildTextInput(
                placeHolder: "Enter Email",
                inputType: "text",
                iconName: "message-circle",
                onChange: ((value) {
                  setState(() {
                    email = value;
                  });
                }),
              ),
              ErrorText(nameErr: emailErr),
              GestureDetector(
                onTap: () async {
                  if (validation()) {
                    setState(() {
                      nameErr = "";
                      mobileErr = "";
                      emailErr = "";
                    });
                    bool status = await SupplierController().addNewSupplier(
                        name: name, mobile: mobile, email: email);
                    if (status) {
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    }
                  } else {}
                },
                child: filledButton(AppColors.primaryElement, "SUBMIT"),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}
