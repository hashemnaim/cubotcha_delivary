import 'package:delivery_boy/values/export.dart';

import '../../values/styles.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final TextAlign? textAlign;
  final Color? color;

  final FontWeight? fontWeight;
  final int? maxLines;
  final double? letterSpacing;

  CustomText(
      {this.text,
      this.fontSize,
      this.textAlign,
      this.color,
      this.fontWeight,
      this.maxLines,
      this.letterSpacing});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: rubikBold.copyWith(
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: fontSize ?? 14.sp,
        letterSpacing: letterSpacing ?? -0.16,
        color: color ?? AppColors.bluColor,
        decoration: TextDecoration.none,
      ),
    );
  }
}
