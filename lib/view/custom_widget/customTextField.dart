import 'package:delivery_boy/values/export.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../values/styles.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final int? maxLength;
  final String? hintTextErorr;
  final Function? validator;
  final Function? onSaved;

  final TextInputType textInputType;
  final bool password;
  final bool outBorder;
  final bool enabled;
  final Color? fillColor;
  final double? borderRadius;
  final Widget? prefixIcon;
  bool repeat = false;
  String initialValue;
  TextEditingController? textEditingController;

  final EdgeInsetsGeometry? contentPadding;

  CustomTextFormField(
      {Key? key,
      this.hintText,
      this.hintTextErorr,
      this.password = false,
      this.enabled = true,
      this.validator,
      this.onSaved,
      this.repeat = false,
      this.textInputType = TextInputType.text,
      this.textEditingController,
      this.initialValue = "",
      this.outBorder = false,
      this.fillColor,
      this.maxLength,
      this.borderRadius,
      this.contentPadding,
      this.prefixIcon});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  IconData iconData = FontAwesomeIcons.eyeSlash;
  bool toggleEye = true;

  fmToggleEye() {
    toggleEye = !toggleEye;
    iconData = toggleEye ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: const Color(0xFFE9E9E9),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.black54),
        // initialValue: widget.initialValue,
        controller: widget.textEditingController,
        validator: (value) => widget.validator!(value),
        // onSaved: (newValue) => widget.onSaved(newValue),
        // onChanged: (value) => widget.onSaved(value),
        enabled: widget.enabled,
        obscureText: widget.password ? toggleEye : false,
        cursorColor: Colors.black12,
        keyboardType: widget.textInputType,
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          // labelText: widget.hintText,
          errorText: widget.hintTextErorr,
          prefixIcon: widget.prefixIcon,
          contentPadding: widget.contentPadding ??
              EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
          fillColor: widget.fillColor,
          filled: widget.fillColor != null ? true : false,
          suffix: widget.repeat == true
              ? Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CustomSvgImage(
                    height: 10.h,
                    width: 10.w,
                    imageName: 'repeat',
                    color: AppColors.blackDark,
                  ),
                )
              : Visibility(
                  visible: widget.password,
                  child: GestureDetector(
                    child: Icon(
                      iconData,
                      color: AppColors.blackDark,
                    ),
                    onTap: () {
                      fmToggleEye();
                    },
                  ),
                ),
          labelStyle:
              rubikBold.copyWith(fontSize: 12, color: Color(0xff658199)),
          hintText: widget.hintText,
          hintStyle: rubikBold.copyWith(
            color: Colors.grey[500],
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: AppColors.blackLight,
            width: 2.w,
          )),
          focusedBorder: widget.outBorder
              ? OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 10.r),
                  borderSide: BorderSide(
                    color: AppColors.blackLight,
                    width: 2.w,
                  ))
              : UnderlineInputBorder(
                  borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 2.w,
                )),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.transparent,
          )),
        ),
      ),
    );
  }
}
