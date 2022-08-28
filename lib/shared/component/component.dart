import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget CustomTextFormField({
  required FormFieldValidator<String> validator,
  TextInputType? keyboardType,
  required TextEditingController controller,
  required String hintText,
  IconData? prefixIcon,
  IconData? suffixIcon,
  ValueChanged<String>? onSubmit,
  bool obscureText = false,
  VoidCallback? pressedSuffixIcon,
  bool isDense = true,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  int? maxLines,
}) =>
    TextFormField(
      onTap: onTap,
      validator: validator,
      onFieldSubmitted: onSubmit,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        isDense: isDense,
        hintText: hintText,
        // labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon:
            IconButton(onPressed: pressedSuffixIcon, icon: Icon(suffixIcon)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.green)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.green)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.green)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.green)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.green)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.green)),
      ),
    );

Widget CustomTextButton(
        {required VoidCallback onPressed,
        required String text,
        double? fontSize,
        Color color = Colors.blue}) =>
    TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: color, fontSize: fontSize),
        ));

Widget CustomButton({
  required VoidCallback onPressed,
  required Widget child,
  ShapeBorder? shape,
  double? elevation,
  double? height,
  double? width,
  EdgeInsetsGeometry? padding,
  Color? textColor,
  Color? backgroundColor,
}) =>
    MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: elevation,
      height: height,
      padding: padding,
      color: backgroundColor,
      minWidth: width,
      textColor: textColor,
      child: child,
    );

void navigateTo({required BuildContext context, required Widget widget}) =>
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }));

void navigateAndFinish(
        {required BuildContext context, required Widget widget}) =>
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }));

void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color? chooseToastColor(ToastStates state) {
  Color? color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget CustomPorgressIndicator() => const Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: Colors.white,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    );

Widget customText({
  required String text,
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  int? maxLines,
  TextOverflow? overflow,
}) =>
    Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          overflow: overflow),
      maxLines: maxLines,
    );
