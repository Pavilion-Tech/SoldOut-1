import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/shared/images/images.dart';
import 'package:soldout/shared/styles/colors.dart';

import 'constants.dart';

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

Widget defaultButton({
  required VoidCallback onTap,
  required String text,
  Color textColor = defaultColorTwo,
  Color buttonColor = defaultColor,
  Color radiusColor = defaultColor,
  double? width,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: size!.height * .06,
      width: width ?? size!.width * .44,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadiusDirectional.circular(10),
        border: Border.all(
          color: radiusColor,
        ),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700
        ),
      ),
    ),
  );
}

Widget defaultTextField({
  TextEditingController? controller,
  required String hint,
  TextInputType type = TextInputType.text,
  Widget? suffix,
  Color color = defaultColorTwo,
  FormFieldValidator<String>? validator,
  bool readOnly = false,
  VoidCallback? onTap,
  List<TextInputFormatter>? inputFormatters,
  Function(String)? onChanged,
}){
  return Stack(
    children: [
      Container(
        height: size!.height*.06,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
       borderRadius: BorderRadiusDirectional.circular(15),
         border: Border.all(color: Colors.grey.shade200),
        ),
      ),
      Padding(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 15),
        child: TextFormField(
          onChanged: onChanged,
          onTap: onTap,
          readOnly: readOnly,
          validator: validator,
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: hint,
            suffixIcon: suffix,
            hintStyle: TextStyle(color: HexColor('#A0AEC0')),
          ),
          inputFormatters: inputFormatters,
        ),
      ),
    ],
  );
}

Widget myAppBar({
  required BuildContext context,
  required String title,
  double? height,
  bool isArrowBack = false,
  bool isLastIcon = false,
  IconData? lastIcon,
  VoidCallback? lastButtonTap,
  VoidCallback? arrowTap,
}) {
  return Container(
    width: double.infinity,
    height: height ?? size!.height * .33,
    alignment: AlignmentDirectional.topStart,
    decoration: const BoxDecoration(
      color: defaultColor,
      borderRadius: BorderRadiusDirectional.only(
        bottomEnd: Radius.circular(15),
        bottomStart: Radius.circular(15),
      ),
    ),
    child: Padding(
      padding: const EdgeInsetsDirectional.all(20),
      child: Row(
        children: [
          SizedBox(height : size!.height*.1 ),
          if (isArrowBack)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 25),
              child: InkWell(
                onTap: arrowTap ??() {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 25,
                  width: 25,
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                    color: defaultColorTwo,
                    borderRadius: BorderRadiusDirectional.circular(5),
                  ),
                  child: myLocale == 'ar'
                      ?const Icon(Icons.arrow_back_ios,size: 14,color: defaultColor,)
                      :Image.asset(BuyerImages.arrow,height: 12,width: 12,),
                ),

              ),
            ),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: defaultColorTwo,
              fontSize: 18
            ),
          ),
          const Spacer(),
          if (isLastIcon)
            IconButton(
                onPressed: lastButtonTap,
                icon: Icon(lastIcon,color: defaultColorTwo,)),
        ],
      ),
    ),
  );
}

Future showToast ({required String msg , bool? toastState})
{
 return Fluttertoast.showToast(
   msg: msg,
   toastLength: Toast.LENGTH_LONG,
   gravity: ToastGravity.BOTTOM,
   timeInSecForIosWeb: 5,
   textColor: Colors.white,
   fontSize: 16.0,
   backgroundColor: toastState != null
       ? toastState ?Colors.yellow[900]
       : Colors.red : Colors.green,
 );
}