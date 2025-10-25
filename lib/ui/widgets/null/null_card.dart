import 'package:flutter/material.dart';

import '../../../utils/constants/app_typography.dart';

class NullCard extends StatelessWidget {
  const NullCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Center(
        child: Container(
          height: 100,
          width: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.do_not_disturb_alt_outlined,
                  color: Colors.redAccent,
                ),
                Text(
                  "No Data Found",
                  style: AppTypography.bodyMedium.copyWith(color: Colors.redAccent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
