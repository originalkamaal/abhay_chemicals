import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:abhay_chemicals/controllers/supplier_controller.dart';
import 'package:abhay_chemicals/widgets/appbar_widget.dart';
import 'package:abhay_chemicals/widgets/buttons_widgets.dart';
import 'package:abhay_chemicals/widgets/error_text.dart';
import 'package:abhay_chemicals/widgets/input_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditSupplier extends StatefulWidget {
  final DocumentSnapshot document;

  const EditSupplier({super.key, required this.document});

  @override
  State<EditSupplier> createState() => _EditSupplierState();
}

class _EditSupplierState extends State<EditSupplier> {
  String name = "";
  String mobile = "";
  String email = "";

  String nameErr = "";
  String mobileErr = "";
  String emailErr = "";

  @override
  void initState() {
    super.initState();
    name = widget.document['name'];
    mobile = widget.document['phoneNumber'].toString();
    email = widget.document['email'];
  }

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
                initialValue: name,
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
                initialValue: mobile,
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
                initialValue: email,
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
                    bool status = await SupplierController().editSupllier(
                        reference: widget.document.reference,
                        name: name,
                        mobile: mobile,
                        email: email);
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
