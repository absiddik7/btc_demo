import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle outfitSB40({Color? color, double? height}) => GoogleFonts.outfit(
        fontWeight: FontWeight.w600, // SemiBold
        fontSize: 40,
        color: color,
        height: height,
      );
  static TextStyle outfitSB32({Color? color, double? height}) => GoogleFonts.outfit(
        fontWeight: FontWeight.w600, // SemiBold
        fontSize: 32,
        color: color,
        height: height,
      );

  static TextStyle outfitSB24({Color? color}) => GoogleFonts.outfit(
        fontWeight: FontWeight.w600, // SemiBold
        fontSize: 24,
        color: color,
      );

  static TextStyle outfitSB20({Color? color}) => GoogleFonts.outfit(
        fontWeight: FontWeight.w600, // SemiBold
        fontSize: 20,
        color: color,
      );

  static TextStyle outfitSB16({Color? color}) => GoogleFonts.outfit(
        fontWeight: FontWeight.w600, // SemiBold
        fontSize: 16,
        color: color,
      );

  static TextStyle outfitR16({Color? color}) => GoogleFonts.outfit(
        fontWeight: FontWeight.w400, // Regular
        fontSize: 16,
        color: color,
      );

  static TextStyle outfitB14({Color? color}) => GoogleFonts.outfit(
        fontWeight: FontWeight.w700, // Bold
        fontSize: 14,
        color: color,
      );

  static TextStyle outfitSB14({Color? color}) => GoogleFonts.outfit(
        fontWeight: FontWeight.w600, // SemiBold
        fontSize: 14,
        color: color,
      );

  static TextStyle outfitR14({Color? color}) => GoogleFonts.outfit(
        fontWeight: FontWeight.w400, // Regular
        fontSize: 14,
        color: color,
      );
  
  static TextStyle outfitM14({Color? color}) => GoogleFonts.outfit(
        fontWeight: FontWeight.w500, // Medium
        fontSize: 14,
        color: color,
      );

  static TextStyle outfitR12({Color? color}) => GoogleFonts.outfit(
        fontWeight: FontWeight.w400, // Regular
        fontSize: 12,
        color: color,
      );

  static TextStyle interR16({Color? color}) => GoogleFonts.inter(
        fontWeight: FontWeight.w400, // Regular
        fontSize: 16,
        color: color,
      );

  static TextStyle urbanistR14({Color? color}) => GoogleFonts.urbanist(
        fontWeight: FontWeight.w400, // Regular
        fontSize: 14,
        color: color,
      );
  
  static TextStyle urbanistB14({Color? color}) => GoogleFonts.urbanist(
        fontWeight: FontWeight.w700, // Regular
        fontSize: 14,
        color: color,
      );
}
