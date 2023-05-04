import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:abhay_chemicals/controllers/production_controller.dart';
import 'package:abhay_chemicals/controllers/users_controller.dart';
import 'package:abhay_chemicals/widgets/appbar_widget.dart';
import 'package:abhay_chemicals/widgets/buttons_widgets.dart';
import 'package:abhay_chemicals/widgets/dropdown_widget.dart';
import 'package:abhay_chemicals/widgets/error_text.dart';
import 'package:abhay_chemicals/widgets/input_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditAdmin extends StatefulWidget {
  final DocumentSnapshot document;
  const EditAdmin({super.key, required this.document});

  @override
  State<EditAdmin> createState() => _EditAdminState();
}

class _EditAdminState extends State<EditAdmin> {
  String name = "";
  String mobile = "";
  String email = "";
  String pass = "";
  String cpass = "";

  String mainErr = "";
  String nameErr = "";
  String mobileErr = "";
  String emailErr = "";
  String passErr = "";
  String cpassErr = "";

  String selectedItem = "User";
  List<String> menuItems = ["Admin", "User"];

  @override
  void initState() {
    selectedItem = widget.document['role'] == "admin" ? "Admin" : "User";
    name = widget.document['name'];
    mobile = widget.document['phoneNumber'].toString();
    email = widget.document['email'];
    super.initState();
  }

  bool validation() {
    bool status = true;
    if (name == "") {
      setState(() {
        nameErr = "Please fill this field";
      });
      status = false;
    }

    if (mobile.length != 10) {
      setState(() {
        mobileErr = "Please provide 10 digit number";
      });
      status = false;
    }
    if (EmailValidator.validate(email) == false) {
      setState(() {
        emailErr = "entered email is valid";
      });
      status = false;
    }
    if (pass.length < 8) {
      setState(() {
        passErr = "password must be atleast 8 char";
      });
      status = false;
    }
    if (pass != cpass || cpass == "") {
      setState(() {
        cpassErr = "passwords not matching";
      });
      status = false;
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: buildAppBar("Add Employee"),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              ErrorText(nameErr: mainErr),
              reusableText("Name", 10.w),
              buildTextInput(
                placeHolder: "Enter Name",
                initialValue: name,
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
                initialValue: mobile,
                iconName: "message-circle",
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
              reusableText("Role", 20.w),
              KamaalDropDown(
                menuItems: menuItems,
                icon: "person",
                selectedItem: selectedItem,
                onChanged: (value) {
                  print(value);
                  setState(() {
                    selectedItem = value!;
                  });
                },
              ),
              Visibility(
                  visible: selectedItem == "admin" || selectedItem == "Admin",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText("Password", 20.w),
                      buildTextInput(
                        placeHolder: "Enter Password",
                        inputType: "password",
                        iconName: "lock",
                        onChange: ((value) {
                          setState(() {
                            pass = value;
                          });
                        }),
                      ),
                      ErrorText(nameErr: passErr),
                      reusableText("Confirm Password", 20.w),
                      buildTextInput(
                        placeHolder: "Confirm Password",
                        inputType: "text",
                        iconName: "lock",
                        onChange: ((value) {
                          setState(() {
                            cpass = value;
                          });
                        }),
                      ),
                      ErrorText(nameErr: cpassErr),
                    ],
                  )),
              ErrorText(nameErr: cpassErr),
              GestureDetector(
                onTap: () async {
                  if (validation()) {
                    setState(() {
                      nameErr = "";
                      mobileErr = "";
                      emailErr = "";
                      passErr = "";
                      cpassErr = "";
                    });
                    bool status = false;

                    status = await UsersController().editUser(
                        reference: widget.document.reference,
                        name: name,
                        mobile: int.parse(mobile),
                        email: email,
                        role: selectedItem.toLowerCase());

                    if (status) {
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        mainErr = "Something went wrong.. try later";
                      });
                    }
                  }

                  // if (batchNumber != "" && controller.text != "") {
                  //   bool status = await ProductionController()
                  //       .addProduction(controller.text, batchNumber);
                  //   if (status == true) {
                  //     Navigator.pop(context);
                  //   }
                  // }
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
