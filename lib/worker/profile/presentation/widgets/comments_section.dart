import 'package:decorizer/common/common.dart';
import 'package:decorizer/common/widget/app/floating_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/constant/textStyles.dart';
import '../../domain/models/worker_profile_model.dart';


class WorkerComments extends StatelessWidget {
  const WorkerComments({
    required this.worker,
    super.key});

  final WorkerProfileModel worker;
  @override
  Widget build(BuildContext context) {
    return FloatingCard(
      padding: EdgeInsetsDirectional.only(
          start: 12.w, end: 12.w, top: 8.h, bottom: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الآراء و التعليقات',
                style: TextStyles.semiBold14(context: context),
              ),
            ],
          ),
           SizedBox(height: 10.h),
          Row(
            children: [
               Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                       Text(
                        '4.9',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width:10.w),
                      Text('من 5', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      SizedBox(width:130.w),
                      Icon(Icons.star, color: Colors.amber,size: 20.sp,),
                      Icon(Icons.star, color: Colors.amber,size: 20.sp,),
                      Icon(Icons.star, color: Colors.amber,size: 20.sp,),
                      Icon(Icons.star, color: Colors.amber,size: 20.sp,),
                      Icon(Icons.star_half, color: Colors.amber,size: 20.sp,),
                    ],
                  ),

                ],
              ),
            ],
          ),
          // const SizedBox(height: 10),
          // ListView.builder(
          //     itemCount: 5,
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     itemBuilder: (context, index) {
          //   final stars = [5, 4, 3, 2, 1];
          //   return _buildRatingBar(stars[index], (index + 1) / 5);
          // }, ),
           SizedBox(height: 12.h),
           Align(
            alignment: Alignment.centerRight,
            child:  Text(
              'اخفاء التعليقات',
              style: TextStyles.regular14Weight400(
                  color: context.appColors.primary, context: context),
            ),
          ),
           SizedBox(height: 12.h),
          _buildComment('سمية عبد', '26\\8\\2024', 5),
          const Divider(),
          _buildComment('مصطفى محمود', '26\\8\\2024', 4),
          const Divider(),
          _buildComment('أدهم السيد', '26\\8\\2024', 5),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int stars, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$stars'),
          const SizedBox(width: 4),
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.grey.shade300,
              color: Colors.black,
              minHeight: 6,
            ),
          ),
          const SizedBox(width: 8),
          Text('${(value * 100).toInt()}%'),
        ],
      ),
    );
  }
  Widget _buildComment(String name, String date, int stars) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundImage: NetworkImage('https://via.placeholder.com/50'),
          radius: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Row(
                    children: List.generate(
                      stars,
                          (index) => const Icon(Icons.star, color: Colors.amber, size: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 6),
              const Text(
                'هذا النص هو بديل لنص يمكن أن يستبدل في نفس المساحة، هذا النص هو بديل لنص يمكن أن يستبدل في نفس المساحة',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        )
      ],
    );
  }
}
