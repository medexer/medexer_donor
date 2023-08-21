// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class CustomGenotypeButton extends StatefulWidget {
  final List items;
  String currentItem;
  final Function onChangeHandler;
  CustomGenotypeButton({
    super.key,
    required this.items,
    required this.currentItem,
    required this.onChangeHandler,
  });

  @override
  State<CustomGenotypeButton> createState() => _CustomGenotypeButtonState();
}

class _CustomGenotypeButtonState extends State<CustomGenotypeButton> {
  void onTapHandler() {
    showModalBottomSheet(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        context: context,
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: EdgeInsets.symmetric(
              vertical: 4.0.hp,
              horizontal: 4.0.wp,
            ),
            decoration: BoxDecoration(
              color: AppStyles.bgWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: 'Genotype',
                  size: 14.0,
                ),
                SizedBox(height: 2.0.hp),
                Expanded(
                  // height: 35.0.hp,
                  child: ListView.builder(
                      itemCount: widget.items.length,
                      itemBuilder: (_, index) {
                        debugPrint('[ICON] :: ${widget.items[index]['icon']}');
                        return InkWell(
                          onTap: () {
                            setState(() {
                              widget.currentItem = widget.items[index]['name'];
                            });
                            widget.onChangeHandler(index);
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: 3.0.hp,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CustomTextWidget(
                                      text: widget.items[index]['name'],
                                      size: 14.0,
                                    ),
                                    SizedBox(width: 2.0.wp),
                                    CustomTextWidget(
                                      text: '(${widget.items[index]['title']})',
                                      size: 10.0.sp,
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 2.0.hp,
                                  height: 2.0.hp,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppStyles.bgBlack),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: widget.currentItem ==
                                            widget.items[index]['name']
                                        ? Container(
                                            width: 1.0.hp,
                                            height: 1.0.hp,
                                            decoration: BoxDecoration(
                                              color: AppStyles.bgBlack,
                                              border: Border.all(
                                                  color: AppStyles.bgBlack),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          )
                                        : Container(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapHandler,
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.06,
        padding: EdgeInsets.only(
          left: 4.0.wp,
          right: 4.0.wp,
        ),
        decoration: BoxDecoration(
          color: AppStyles.bgWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppStyles.bgBlack.withOpacity(0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextWidget(
              text: widget.currentItem == '' ? '-' : widget.currentItem,
              size: 14.0,
              color: AppStyles.bgBlack,
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppStyles.bgBlack,
            ),
          ],
        ),
      ),
    );
  }
}
