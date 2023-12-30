import 'package:flutter/material.dart';

class SelectInputNormal extends StatefulWidget {
  final List<String> itemz;
  final Function selecedFun;
  final String labelText;
  final TextStyle labelStyles;
  final Color borderColor;
  final Color focusedColor;
  final Color fillcolor;
  final IconData icon;
  final Color icolor;
  const SelectInputNormal(
      {required this.borderColor,
      required this.fillcolor,
      required this.focusedColor,
      required this.itemz,
      required this.selecedFun,
      required this.labelText,
      required this.labelStyles,
      required this.icolor,
      required this.icon,
      super.key});

  @override
  State<SelectInputNormal> createState() => _SelectInputNormalState();
}

class _SelectInputNormalState extends State<SelectInputNormal> {
  late String itemx;
  @override
  void initState() {
    super.initState();
    itemx = widget.itemz.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: widget.labelStyles
              .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              border: Border.all(color: widget.borderColor),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
                icon: Icon(
                  widget.icon,
                  color: widget.icolor,
                  size: 26,
                ),
                elevation: 0,
                isExpanded: true,
                borderRadius: BorderRadius.circular(7),
                value: itemx,
                items:
                    widget.itemz.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    itemx = value!;
                    widget.selecedFun(itemx);
                  });
                }),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
