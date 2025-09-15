import 'package:flutter/painting.dart';
import 'package:frontend/modules/admin/dashboard/models/analytic.dart';

final analyticData = <Analytic>[
  Analytic(
    title: 'Total Products',
    subtitle: '20',
    iconPath: 'assets/icons/analytic_1.svg',
    iconColor: const Color(0xFF581313),
    iconBackground: const Color(0xFFF8D6D6),
  ),

  Analytic(
    title: 'Total Users',
    subtitle: '100',
    iconPath: 'assets/icons/analytic_2.svg',
    iconColor: const Color(0xFF002B63),
    iconBackground: const Color(0xFFCCE1FE),
  ),

  Analytic(
    title: 'Total Orders',
    subtitle: '5',
    iconPath: 'assets/icons/analytic_3.svg',
    iconColor: const Color(0xFF664D03),
    iconBackground: const Color(0xFFFFF3CD),
  ),

  Analytic(
    title: 'Total Payment',
    subtitle: '2000',
    iconPath: 'assets/icons/analytic_4.svg',
    iconColor: const Color(0xFF0F5132),
    iconBackground: const Color(0xFFD1E7DD),
  ),
];
