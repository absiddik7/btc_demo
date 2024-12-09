import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/providers/theme/theme_provider.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/ui/themes/styles/app_text_styles.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/secondary_icon_button.dart';
import 'package:provider/provider.dart';

class EditDashboardBottomSheet extends StatefulWidget {
  const EditDashboardBottomSheet({super.key});

  @override
  State<EditDashboardBottomSheet> createState() =>
      _EditDashboardBottomSheetState();
}

class _EditDashboardBottomSheetState extends State<EditDashboardBottomSheet> {
  final List<String> _boardList = ['Board 1', 'Board 2', 'Board 3'];
  String _selectedBoard = '';
  final TextEditingController _textController = TextEditingController();

  void _enableTextField(String boardName) {
    setState(() {
      _selectedBoard = boardName;
      _textController.text = boardName;
    });
  }

  void _removeBoard(int index) {
    setState(() {
      _boardList.removeAt(index);
    });
  }

  void _addBoard() {
    setState(() {
      _boardList.add('New Board');
    });
  }

  void _saveChanges() {
    if (_selectedBoard.isNotEmpty) {
      final index = _boardList.indexOf(_selectedBoard);
      if (index != -1) {
        setState(() {
          _boardList[index] = _textController.text;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final Color textColor = themeProvider.currentTheme.textPrimaryColor;
        final Color borderColor = themeProvider.currentTheme.borderColor;
        final Color backgroundColor =
            themeProvider.currentTheme.communityBoardItemColor;
        final Color iconColor = themeProvider.currentTheme.iconColor;
        final Color removeIconColor = themeProvider.currentTheme.errorColor;

        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit dashboard',
                style: AppTextStyles.outfitSB24(color: textColor),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Board Name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                        ),
                        // rename text field
                        SizedBox(
                          height: 56, // Set height to 56px
                          child: TextFormField(
                            controller: _textController,
                            decoration: InputDecoration(
                              hintText: "Select a board",
                              hintStyle: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                              filled: true,
                              fillColor: backgroundColor,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical:
                                    16, // Adjust vertical padding to ensure height
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color:
                                      borderColor, // Dynamic border color from theme
                                  width: 0.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color:
                                      borderColor, // Dynamic border color from theme
                                  width: 0.5,
                                ),
                              ),
                            ),
                            //validator: validator,
                            cursorColor: Colors.blue,
                            style: TextStyle(fontSize: 16, color: textColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Created boards',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                    ),

                    // Board List
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _boardList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () =>
                                      _enableTextField(_boardList[index]),
                                  child: Container(
                                    height: 56,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: backgroundColor,
                                      border: Border.all(
                                          color: borderColor, width: 0.5),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              AppAssets.editBoardIcon,
                                              colorFilter: ColorFilter.mode(
                                                  iconColor, BlendMode.srcIn),
                                              width: 24,
                                              height: 24,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              _boardList[index],
                                              style: AppTextStyles.outfitSB16(
                                                  color: textColor),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () => _removeBoard(index),
                                          icon: Icon(Icons.remove_circle,
                                              color: removeIconColor, size: 24),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            // Add Board Button
                            SecondaryIconButton(
                              type: SecondaryIconButtonType.addButton,
                              label: 'Add board',
                              onPressed: () => _addBoard(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Save Changes Button
              CommonButton(
                type: ButtonType.primary,
                label: 'Save changes',
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
