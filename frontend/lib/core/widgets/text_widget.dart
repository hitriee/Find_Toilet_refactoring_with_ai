import 'package:find_toilet/core/theme/style.dart';
import 'package:find_toilet/core/utils/global_utils.dart';
import 'package:find_toilet/core/widgets/box_container.dart';
import 'package:find_toilet/core/widgets/icon.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? initValue, hintText;
  final void Function(String)? onChanged, onSubmitted;
  final int maxLines;
  final double width, height, radius, textHeight;
  final Widget? prefixIcon, suffixIcon;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry padding;
  final bool searchMode;
  final bool hasBorder;
  const CustomTextField({
    super.key,
    this.initValue,
    required this.onChanged,
    this.maxLines = 1,
    this.width = 350,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.height = 50,
    this.boxShadow,
    this.radius = 5,
    this.padding = const EdgeInsetsDirectional.all(30),
    this.onSubmitted,
    this.searchMode = false,
    this.textHeight = 1,
    this.hasBorder = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      width: widget.width,
      height: widget.height,
      border: widget.hasBorder ? Border.all(color: mainColor, width: 2) : null,
      radius: widget.radius,
      color: whiteColor,
      boxShadow: widget.boxShadow,
      child: Padding(
        padding: widget.padding,
        child: TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(top: isDefaultTheme(context) ? 13 : 12),
            border: InputBorder.none,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
          ),
          maxLines: widget.maxLines,
          style: TextStyle(
            fontSize: isDefaultTheme(context) ? defaultSize : largeDefaultSize,
            height: widget.textHeight,
            letterSpacing: 1,
          ),
          textInputAction:
              widget.searchMode ? TextInputAction.search : null,
          onSubmitted: widget.onSubmitted,
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String title;
  final String? font;
  final FontSize fontSize;
  final CustomColors color;
  final double? height;
  final bool isBoldText, isCentered, applyTheme, hasUnderline;
  const CustomText({
    super.key,
    required this.title,
    this.fontSize = FontSize.defaultSize,
    this.color = CustomColors.blackColor,
    this.font,
    this.isBoldText = false,
    this.isCentered = false,
    this.applyTheme = true,
    this.hasUnderline = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: isCentered ? TextAlign.center : null,
      style: TextStyle(
        color: convertedColor(color),
        fontSize: convertedSize(
          applyTheme ? applyDefaultTheme(context, fontSize) : fontSize,
        ),
        height: height,
        fontFamily: font,
        fontWeight: isBoldText ? FontWeight.bold : null,
        decoration: hasUnderline ? TextDecoration.underline : null,
      ),
    );
  }
}

class TextWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? font;
  final FontSize fontSize;
  final CustomColors textColor, iconColor;
  final int flex;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double gap;
  final bool applyTheme, hasUnderline;
  const TextWithIcon({
    super.key,
    required this.icon,
    required this.text,
    this.fontSize = FontSize.smallSize,
    this.iconColor = CustomColors.mainColor,
    this.textColor = CustomColors.blackColor,
    this.font,
    this.flex = 4,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.gap = 10,
    this.applyTheme = true,
    this.hasUnderline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.loose,
          child: CustomIcon(
            icon: icon,
            color: convertedColor(iconColor),
          ),
        ),
        Flexible(child: SizedBox(width: gap)),
        Flexible(
          flex: flex,
          fit: FlexFit.loose,
          child: CustomText(
            title: text,
            fontSize: fontSize,
            color: textColor,
            font: font,
            applyTheme: applyTheme,
            hasUnderline: hasUnderline,
          ),
        )
      ],
    );
  }
}
