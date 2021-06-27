import 'package:One4All/Constants.dart';
import 'package:flutter/material.dart';

class TextEditor extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String tip;
  final IconData icon;
  final bool password;
  final int maxLines;
  final TextInputType inputType;
  final TextAlign textAlign;
  final Function functionOnChanged;
  final Function functionCompleteEditing;

  TextEditor({
    this.controller,
    this.label,
    this.tip,
    this.icon,
    this.password = false,
    this.maxLines = 1,
    this.inputType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.functionOnChanged,
    this.functionCompleteEditing,
  });

  @override
  TextEditorState createState() => TextEditorState();
}

class TextEditorState extends State<TextEditor> {
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: widget.functionOnChanged,
        onEditingComplete: widget.functionCompleteEditing,
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        controller: widget.controller,
        style: TextStyle(
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: Constants.borderRadius,
          ),
          icon: widget.icon != null ? Icon(widget.icon) : null,
          labelText: widget.label,
          hintText: widget.tip,
          suffixIcon: _buildSuffixIcon(),
        ),
        obscureText: widget.password ? _isHidden : false,
        keyboardType: widget.inputType,
      ),
    );
  }

  Widget _buildSuffixIcon() {
    return widget.password
        ? IconButton(
            icon:
                _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
            onPressed: () {
              _toggleVisibility();
            },
          )
        : null;
  }
}
