import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SelectWithSearchInput extends StatelessWidget {
  final List<String> itemz;
  final Function selecedFun;
  final String labelText;
  final TextStyle labelStyles;
  final Color borderColor;
  final Color focusedColor;
  final Color fillcolor;
  final String selectedItem;
  final GlobalKey<DropdownSearchState<String>> dropdownKey;
  const SelectWithSearchInput(
      {required this.borderColor,
      required this.dropdownKey,
      required this.fillcolor,
      required this.focusedColor,
      required this.itemz,
      required this.selecedFun,
      required this.labelText,
      required this.labelStyles,
      required this.selectedItem,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style:
              labelStyles.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 5,
        ),
        DropdownSearch<String>(
          key: dropdownKey,
          items: itemz,
          onChanged: (value) {
            if (value is String) {
              selecedFun(value);
            }
          },
          selectedItem: selectedItem,
          popupProps: PopupProps.bottomSheet(
              searchDelay: const Duration(milliseconds: 100),
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                    hintText: 'Tafuta',
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      gapPadding: 1.0,
                      borderSide: BorderSide(width: 1.0, color: borderColor),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    filled: true,
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
                padding: const EdgeInsets.only(
                    top: 20, left: 10, right: 10, bottom: 8),
              )),
          dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            fillColor: fillcolor,
            focusColor: focusedColor,
            enabledBorder: OutlineInputBorder(
              gapPadding: 1.0,
              borderSide: BorderSide(width: 1.0, color: borderColor),
              borderRadius: BorderRadius.circular(6.0),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 1.0,
              borderSide: BorderSide(width: 1.0, color: focusedColor),
              borderRadius: BorderRadius.circular(6.0),
            ),
          )),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
