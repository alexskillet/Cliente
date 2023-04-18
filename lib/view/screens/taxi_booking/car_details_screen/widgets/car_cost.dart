import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/theme_controller.dart';
import 'package:sixam_mart/data/model/response/vehicle_model.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

class CarCost extends StatelessWidget {
  final Vehicles vehicle;
  final String fareCategory;
  const CarCost({Key key, @required this.vehicle, @required this.fareCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [BoxShadow(color: Colors.grey[Get.find<ThemeController>().darkTheme ? 800 : 300], blurRadius: 5, spreadRadius: 1,)],
      ),
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: Dimensions.PADDING_SIZE_DEFAULT),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _carInfoItem('per_hour_cost'.tr, Images.hour_cost, fareCategory == 'hourly', vehicle.insidePerHourCharge, vehicle.insidePerKmCharge),
          _carInfoItem('per_kilometer_cost'.tr, Images.km_cost, fareCategory == 'per_km', vehicle.outsidePerHourCharge, vehicle.outsidePerKmCharge),
        ],
      ),
    );
  }

  Widget _carInfoItem(String title,String iconPath, bool isSelected, double insideCityCost, double outsideCityCost){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title,style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
            SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
            Image.asset(iconPath, height: 12, width: 12),
          ],
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

        Text.rich(
          TextSpan(
            style: robotoRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: isSelected ?  Theme.of(Get.context).primaryColor:Theme.of(Get.context).textTheme.bodyLarge.color.withOpacity(.5),
            ),
            children: [
              TextSpan(
                  text: Get.find<SplashController>().configModel.currencySymbol,
                  style: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                  )),
              TextSpan(
                  text: insideCityCost.toStringAsFixed(Get.find<SplashController>().configModel.digitAfterDecimalPoint),
                  style: robotoBold.copyWith(
                    fontSize: Dimensions.fontSizeExtraLarge,
                  )),
              TextSpan(
                  text: '/hr',
                  style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeSmall)),

              TextSpan(
                  text: 'inside_city'.tr,
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall)),
            ],
          ),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

        Text.rich(
          TextSpan(
            style: robotoRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color:Theme.of(Get.context).textTheme.bodyLarge.color.withOpacity(.5),
            ),
            children: [
              TextSpan(
                  text:  Get.find<SplashController>().configModel.currencySymbol,
                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
              TextSpan(
                  text: outsideCityCost.toStringAsFixed(Get.find<SplashController>().configModel.digitAfterDecimalPoint),
                  style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
              TextSpan(
                  text: '/hr',
                  style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall)),

              TextSpan(
                  text: 'outside_city'.tr,
                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
            ],
          ),
        ),

      ],
    );
  }
}
