import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:material_symbols_icons/symbols.dart';
import 'package:shirikisho_drivers/micro/styles.dart';
import 'package:shirikisho_drivers/static_data/consts.dart';

class DelegateaccountTopSect extends SliverPersistentHeaderDelegate {
  final String profilePic;
  final String userName;

  DelegateaccountTopSect({required this.profilePic, required this.userName});
  final KishoStyles appStyles = KishoStyles();
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var shrinkPercentage =
        min(1, shrinkOffset / (maxExtent - minExtent)).toDouble();
    double appTopBarHeight = 50;
    return Material(
      color: Colors.white,
      child: Stack(fit: StackFit.expand, clipBehavior: Clip.none, children: [
        Opacity(
          opacity: 1 - shrinkPercentage,
          child: Column(
            children: [
              Container(
                height:
                    shrinkPercentage < 0.65 ? 250 * (1 - shrinkPercentage) : 10,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/shirikisho_profile.png'),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: shrinkPercentage < 0.7 ? 24 : 6,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: shrinkPercentage < 65 ? 20 * (1 - shrinkPercentage) : 2,
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Opacity(
                  opacity: 1 - shrinkPercentage,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 100,
                        child: Stack(clipBehavior: Clip.none, children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 2.5,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                          Positioned(
                              top: 2,
                              left: 2,
                              width: 96,
                              height: 96,
                              child: ClipOval(
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  profilePic,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(assest404Image,
                                        fit: BoxFit.cover);
                                  },
                                ),
                              )),
                          Positioned(
                              right: 0,
                              bottom: 0,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: appStyles.roundButtonStyles().copyWith(
                                    padding: const MaterialStatePropertyAll(
                                        EdgeInsets.zero),
                                    minimumSize: const MaterialStatePropertyAll(
                                        Size(30, 30)),
                                    maximumSize: const MaterialStatePropertyAll(
                                        Size(35, 35))),
                                child: const Icon(
                                  Symbols.add,
                                  size: 28,
                                ),
                              ))
                        ]),
                      ),
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Container(
                          color: Colors.transparent,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                    onPressed: () {
                                      Get.toNamed('/account/settings');
                                    },
                                    icon: const Icon(
                                      Icons.settings_rounded,
                                      color: Colors.green,
                                      size: 40,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
        // appbar
        SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Opacity(
                  opacity: shrinkPercentage,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    width: MediaQuery.of(context).size.width,
                    height: appTopBarHeight,
                    child: Text(
                      userName,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
