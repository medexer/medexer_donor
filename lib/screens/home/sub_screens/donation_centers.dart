import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medexer_donor/config/app_config.dart';
import 'package:medexer_donor/widgets/buttons/custom_button.dart';
import 'package:medexer_donor/widgets/text/custom_text_widget.dart';

class DonationCenters extends StatefulWidget {
  const DonationCenters({super.key});

  @override
  State<DonationCenters> createState() => _DonationCentersState();
}

class _DonationCentersState extends State<DonationCenters> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (_, index) {
          return ListTile(
            leading: SvgPicture.asset(
              'assets/icons/icon__building.svg',
              color: AppStyles.bgPrimary,
            ),
            title: CustomTextWidget(
              text: 'Hospital ${index + 1}',
              size: 12.0.sp,
            ),
            subtitle: CustomTextWidget(
              text: 'No 1. Lorem Impsum Street...',
              size: 8.0.sp,
            ),
            trailing: GestureDetector(
              onTap: () {
                debugPrint('[BOOK-APPOINTMENT]');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppStyles.bgBlue,
                ),
                height: 5.0.hp,
                width: 22.0.wp,
                padding: EdgeInsets.symmetric(horizontal: 1.0.wp),
                child: Center(
                  child: CustomTextWidget(
                    text: 'Book appointment',
                    color: Colors.white,
                    size: 6.0.sp,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
