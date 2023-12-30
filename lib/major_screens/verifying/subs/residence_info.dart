import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class DriverResidenceInfoReview extends StatelessWidget {
  final String residenceInfo;
  const DriverResidenceInfoReview({required this.residenceInfo, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 7),
      decoration: BoxDecoration(
          color: const Color(0x33D3F0D5),
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          border: Border.all(color: const Color(0xFFD3F0D5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 105,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD3F0D5),
                  ),
                  child: Icon(
                    Symbols.location_on_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                ),
                const Text(
                  'Anapoishi:',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 142,
            child: Text(
              residenceInfo,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 11),
            ),
          )
        ],
      ),
    );
  }
}
