import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class VehicleInfoDriverReview extends StatelessWidget {
  final String vType;
  final String vNumber;
  final String lNumber;
  final String bimaCode;
  const VehicleInfoDriverReview(
      {required this.bimaCode,
      required this.lNumber,
      required this.vNumber,
      required this.vType,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 7),
      decoration: BoxDecoration(
          color: const Color(0x33D3F0D5),
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          border: Border.all(color: const Color(0xFFD3F0D5))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD3F0D5),
                ),
                child: Icon(
                  Symbols.motorcycle_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
              ),
              const SizedBox(width: 7),
              const Text(
                'Taarifa za Chombo',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Aina ya chombo',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(vType,
                  style: const TextStyle(
                      fontSize: 13, color: Color.fromARGB(176, 15, 15, 16)))
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Namba ya chombo',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(vNumber,
                  style: const TextStyle(
                      fontSize: 13, color: Color.fromARGB(176, 15, 15, 16)))
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Namba ya leseni',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(lNumber,
                  style: const TextStyle(
                      fontSize: 13, color: Color.fromARGB(176, 15, 15, 16)))
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sticker ya Bima',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(bimaCode,
                  style: const TextStyle(
                      fontSize: 13, color: Color.fromARGB(176, 15, 15, 16)))
            ],
          ),
        ],
      ),
    );
  }
}
