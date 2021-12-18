import 'package:app_notation_mobile/app/controllers/controller_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomField extends StatefulWidget {
  final bool? enable;
  final String placeholder;
  final TextEditingController? controller;
  final String label;
  final FocusNode? focus;
  final int maxLines;
  final bool? isPass;
  final int minLines;
  final void Function()? onTap;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final int? max;
  final void Function()? onEditingComplete;
  final Widget? lateralName;
  final Function(String)? onChange;
  final bool center;
  final Widget? icon;
  final Color? bgColor;

  const CustomField({
    Key? key,
    this.onTap,
    this.minLines = 1,
    this.enable,
    this.placeholder = '',
    this.controller,
    this.label = '',
    this.icon,
    this.focus,
    this.center = false,
    this.maxLines = 1,
    this.isPass,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.max,
    this.onEditingComplete,
    this.lateralName,
    this.onChange,
    this.bgColor,
  }) : super(key: key);

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool? pass;

  @override
  void initState() {
    pass = widget.isPass;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: widget.bgColor ?? ControllerTheme.instance.theme.cardColor,
          borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        onTap: widget.onTap,
        textCapitalization: widget.textCapitalization,
        maxLength: widget.max,
        inputFormatters: widget.inputFormatters,
        obscureText: pass ?? false,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
        onChanged: widget.onChange,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        textAlign: widget.center ? TextAlign.center : TextAlign.left,
        focusNode: widget.focus,
        enabled: widget.enable ?? true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onEditingComplete: widget.onEditingComplete,
        decoration: InputDecoration(
          hintText: widget.placeholder,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: const OutlineInputBorder(borderSide: BorderSide()),
          labelText: widget.label,
          icon: widget.lateralName,
          suffixIcon: Visibility(
            visible: widget.icon != null,
            child: widget.icon ?? const SizedBox(width: 0, height: 0),
            replacement: Visibility(
              visible: pass != null,
              child: IconButton(
                onPressed: () => setState(() => pass = !pass!),
                icon: Icon(
                    pass ?? false ? Icons.visibility_off : Icons.visibility),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

nextFocus(BuildContext context) {
  FocusScope.of(context).nextFocus();
}

unfocus(BuildContext context) {
  FocusScope.of(context).unfocus();
}

changeFocus(BuildContext context, FocusNode focus) {
  FocusScope.of(context).requestFocus(focus);
}
