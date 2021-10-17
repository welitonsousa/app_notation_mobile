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
  final void Function()? onTap;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final int? max;
  final onEditingComplete;
  final Widget? lateralName;
  final Function(String)? onChange;
  final bool center;
  
  CustomField({
    this.onTap,
    this.enable,
    this.placeholder = '',
    this.controller,
    this.label = '',
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
    this.onEditingComplete, this.lateralName,
    this.onChange,
  });

  @override
  _CustomFieldState createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool? pass;

  @override
  void initState() {
    pass = this.widget.isPass;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: new TextFormField(
        onTap: this.widget.onTap,
        textCapitalization: this.widget.textCapitalization,
        maxLength: this.widget.max ?? null,
        inputFormatters: this.widget.inputFormatters,
        obscureText: pass ?? false,
        controller: this.widget.controller,
        keyboardType: this.widget.textInputType,
        textInputAction: this.widget.textInputAction,
        validator: this.widget.validator,
        onChanged: this.widget.onChange,
        minLines: 1,
        maxLines: this.widget.maxLines,
        textAlign: this.widget.center ? TextAlign.center : TextAlign.left,
        focusNode: this.widget.focus,
        enabled: this.widget.enable ?? true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onEditingComplete: this.widget.onEditingComplete,
        decoration: InputDecoration(
          hintText: this.widget.placeholder,
          border: const OutlineInputBorder(borderSide: const BorderSide()),
          labelText: this.widget.label,
          icon: this.widget.lateralName ?? null,
          suffixIcon: Visibility(
            visible: pass != null,
            child: IconButton(
              onPressed: () {
                setState(() {
                  pass = !pass!;
                });
              },
              icon: Icon(pass ?? false ?  Icons.visibility_off : Icons.visibility),
            ),
          ),
        ),
      ),
    );
  }
}

nextFocus(BuildContext context){
  FocusScope.of(context).nextFocus();
}

unfocus(BuildContext context){
  FocusScope.of(context).unfocus();
}

changeFocus(BuildContext context, FocusNode focus) {
  FocusScope.of(context).requestFocus(focus);
}