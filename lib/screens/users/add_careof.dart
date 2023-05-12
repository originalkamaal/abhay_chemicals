import 'package:abhay_chemicals/common/consts/colors.dart';
import 'package:abhay_chemicals/controllers/careof_controller.dart';
import 'package:abhay_chemicals/widgets/appbar_widget.dart';
import 'package:abhay_chemicals/widgets/buttons_widgets.dart';
import 'package:abhay_chemicals/widgets/error_text.dart';
import 'package:abhay_chemicals/widgets/input_widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCareOf extends StatefulWidget {
  const AddCareOf({super.key});

  @override
  State<AddCareOf> createState() => _AddCareOfState();
}

class _AddCareOfState extends State<AddCareOf> {
  DateTime selectedDate = DateTime.now();
  String name = "";
  String email = "";
  String mobile = "";

  String nameErr = "";
  String emailErr = "";
  String mobileErr = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: buildAppBar("Add New CareOF"),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              reusableText("Full Name", 20.w),
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
                    mobile = (value);
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
                  if (name != "" &&
                      mobile.length == 10 &&
                      EmailValidator.validate(email)) {
                    bool status = await UsersCareofController().addCareOf(
                        name: name, email: email, mobile: int.parse(mobile));

                    if (status == true) {
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    }
                  } else {
                    if (name == "") {
                      setState(() {
                        nameErr = "Name is mandatory field";
                      });
                    }
                    if (mobile.length != 10) {
                      setState(() {
                        mobileErr = "Please enter 10 digit mobile";
                      });
                    }
                    if (EmailValidator.validate(email) == false) {
                      setState(() {
                        emailErr = "Please enter valid email";
                      });
                    }
                  }
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
