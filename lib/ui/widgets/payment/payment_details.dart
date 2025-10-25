import 'package:flutter/material.dart';
import 'package:smart_city/utils/constants/app_typography.dart';

class PaymentDetails extends StatelessWidget {
  final double subTotal;
  final double discount;
  final double tax;
  final double payableAmount;
  const PaymentDetails({
    super.key, required this.subTotal, required this.discount, required this.tax, required this.payableAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 168,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 5,
            offset: const Offset(0, 5),
            spreadRadius: 2,
          )
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child:  Column(
        children: [
          Divider(),
          _PaymentField(fieldname: 'subtotal', fvalue: subTotal.toString()),
          _PaymentField(fieldname: 'Discount', fvalue: discount.toString()),
          _PaymentField(fieldname: 'Gst', fvalue: tax.toString()),
          Divider(),
          _PaymentField(
            fieldname: 'Payable Amount',
            fvalue: payableAmount.toString(),
            isBold: true,
          ),
        ],
      ),
    );
  }
}

class _PaymentField extends StatelessWidget {
  // const _PaymentField({super.key});
  final String fieldname;
  final String fvalue;
  final bool isBold;

  const _PaymentField({
    super.key,
    required this.fieldname,
    required this.fvalue,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(fieldname,
              style: isBold
                  ? AppTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.w500, color: const Color(0xFFC6011F))
                  : AppTypography.bodyLarge),
          Row(
            children: [
              Text('\$ $fvalue',
                  style: isBold
                      ? AppTypography.bodyLarge.copyWith(
                          fontWeight: FontWeight.w500, color: const Color(0xFFC6011F))
                      : AppTypography.bodyLarge),
            ],
          ),
        ],
      ),
    );
  }
}
