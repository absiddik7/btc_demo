import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:provider/provider.dart';

class BackgroundColorSelectorBottomSheet extends StatefulWidget {
  final String initialColorHex; // Pass hex color code as a string

  const BackgroundColorSelectorBottomSheet({super.key, required this.initialColorHex});

  @override
  State<BackgroundColorSelectorBottomSheet> createState() => _BackgroundColorSelectorBottomSheetState();
}

class _BackgroundColorSelectorBottomSheetState extends State<BackgroundColorSelectorBottomSheet> {
  final List<String> _colorHexCodes = [
    '#FF3F51B6', // Custom color 1
    '#FF4FADA3', // Custom color 2
    '#FFAE433F', // Custom color 3
  ];

  List<Color> get _colors => _colorHexCodes.map(_fromHex).toList();

  Color? _selectedColor;
  bool _isThemeColorSelected = false;
  String? _selectedColorHexString;

  void _openColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Color pickerColor = Colors.white;

        return AlertDialog(
          title: const Text('Pick a Color'),
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) {
                pickerColor = color;
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () {
                _addCustomColor(pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    if (widget.initialColorHex == 'themeColor') {
      _selectedColor = themeProvider.currentTheme.appSecondaryColor; // Use the theme color
      _isThemeColorSelected = true; // Set the flag
    } else {
      _selectedColorHexString = widget.initialColorHex;
      _selectedColor = _fromHex(widget.initialColorHex);

      // Check if the color is predefined
      if (_colorHexCodes.contains(widget.initialColorHex)) {
        _selectedColor = _fromHex(widget.initialColorHex); // Just select the color
      } else {
        // If not predefined, add it at the beginning of the list
        _colorHexCodes.insert(0, widget.initialColorHex);
      }

      // If the passed color matches the theme's secondary color, mark the flag as true
      if (widget.initialColorHex == _toHex(themeProvider.currentTheme.appSecondaryColor)) {
        _isThemeColorSelected = true;
      }
    }
  }

  Color _fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String _toHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  void _addCustomColor(Color color) {
    final colorHex = _toHex(color);
    if (!_colorHexCodes.contains(colorHex)) {
      setState(() {
        _colorHexCodes.insert(0, colorHex); // Add custom color at the beginning
        _selectedColor = color;
        _isThemeColorSelected = false; // Reset theme selection
        _selectedColorHexString = colorHex; // Track the custom color as a hex string
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;
        final Color borderColor = themeProvider.currentTheme.borderColor;
        final Color selectedItemBorderColor = themeProvider.currentTheme.appThirdColor;
        final Color iconButtonColor = themeProvider.currentTheme.appSecondaryColor;
        final Color iconColor = themeProvider.currentTheme.iconColor;
        final Color dynamicColor = themeProvider.currentTheme.appSecondaryColor;

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Background',
                style: AppTextStyles.outfitSB24(color: textColor),
              ),
              const SizedBox(height: 16),

              // Color Selector Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Add Color (+) Button
                    GestureDetector(
                      onTap: _openColorPicker,
                      child: Container(
                        width: 78,
                        height: 78,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor, width: 1),
                          borderRadius: BorderRadius.circular(20),
                          color: iconButtonColor,
                        ),
                        child: Center(
                          child: Icon(Icons.add, color: iconColor, size: 32),
                        ),
                      ),
                    ),

                    // First Color is dynamic based on theme
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = dynamicColor; // Set theme color
                          _isThemeColorSelected = true; // Set flag for theme color
                        });
                      },
                      child: Container(
                        width: 78,
                        height: 78,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: dynamicColor, // Dynamic theme color
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _isThemeColorSelected ? selectedItemBorderColor : borderColor,
                            width: _isThemeColorSelected ? 4 : 1,
                          ),
                        ),
                      ),
                    ),

                    // List of Predefined Colors
                    ..._colors.map((color) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedColor = color;
                            _isThemeColorSelected = false; // Deselect theme color
                            _selectedColorHexString = _toHex(color); // Track custom color
                          });
                        },
                        child: Container(
                          width: 78,
                          height: 78,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _selectedColor == color ? selectedItemBorderColor : borderColor,
                              width: _selectedColor == color ? 4 : 1,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 26),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CommonButton(
                      type: ButtonType.secondary,
                      label: 'Cancel',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CommonButton(
                      type: ButtonType.primary,
                      label: 'Add',
                      onPressed: () {
                        if (_isThemeColorSelected) {
                          Navigator.of(context).pop('themeColor');
                        } else {
                          print('Selected Color: $_selectedColorHexString');
                          Navigator.of(context).pop(_selectedColorHexString);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
