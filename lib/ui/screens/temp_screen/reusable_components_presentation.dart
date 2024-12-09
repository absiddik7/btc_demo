import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mybtccanvas/core/utils/constants/app_assets.dart';
import 'package:mybtccanvas/core/utils/enums/enum.dart';
import 'package:mybtccanvas/ui/widgets/background/custom_background.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_switch.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/common_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_appbar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_horizontal_period_filter.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_icons.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_input_field.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_input_field_with_dropdown.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/custom_radio_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/date_picker_icon_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/drop_down_menu_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/filter_drop_down_menu_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/full_block_insights.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/password_input_field.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/search_bar.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/secondary_icon_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/small_icon_button.dart';
import 'package:mybtccanvas/ui/widgets/common_widget/social_media_button.dart';

class ReusableComponentsPresentation extends StatefulWidget {
  const ReusableComponentsPresentation({
    super.key,
  });

  @override
  State<ReusableComponentsPresentation> createState() => _ReusableComponentsPresentationState();
}

class _ReusableComponentsPresentationState extends State<ReusableComponentsPresentation> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _amountController = TextEditingController(text: '10000');
  final _passwordController = TextEditingController();
  bool _selectedValue = true;

  String selectedPeriod = 'Day';

  final List<String> periods = ['Day', 'Week', 'Monthly', 'Yearly'];

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be empty";
    }
    final RegExp emailRegExp = RegExp(
      r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
    );
    if (!emailRegExp.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Column(
          children: [
            // custom app bar with container, back button and title
            const CustomAppBar(
              title: 'Reusable Components',
              trailingIcon: Icon(Icons.settings, color: Colors.white),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // primary and secondary buttons
                        primaySecondaryButton(),
                        const SizedBox(height: 42),
                        // custom icon buttons
                        customIconButton(),
                        const SizedBox(height: 42),
                        // social buttons
                        socialMediaButton(),
                        const SizedBox(height: 42),
                        // secondary icon buttons
                        secondaryIconButton(),
                        const SizedBox(height: 42),
                        // small icon buttons
                        smallIconButton(),
                        const SizedBox(height: 42),
                        // custom search bar
                        customSearchBar(),
                        const SizedBox(height: 42),
                        // custom input field
                        customInputField(),
                        const SizedBox(height: 42),
                        // custom input field with dropdown
                        customInputFieldWithDropdown(),
                        const SizedBox(height: 42),
                        // password input field
                        passwordInputField(),
                        const SizedBox(height: 42),
                        // filter drop down menu button
                        filterDropDownMenuButton(),
                        const SizedBox(height: 42),
                        // drop down menu button
                        dropDownMenuButton(),
                        const SizedBox(height: 42),
                        // custom radio button
                        customRadioButton(),
                        const SizedBox(height: 42),
                        // custom switch
                        customSwitch(),
                        const SizedBox(height: 42),
                        // custom horizontal period filter
                        customHorizontalPeriodFilter(),
                        const SizedBox(height: 42),
                        // custom date picker icon button
                        customDatePickerIconButton(),
                        const SizedBox(height: 42),
                        // full block insights
                        fullBlockInsights(),
                        const SizedBox(height: 42),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget primaySecondaryButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Primary and Secondary Buttons',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        // common primary button
        CommonButton(
          type: ButtonType.primary,
          label: 'Primary Button Enabled',
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        // common primary button disabled
        CommonButton(
          type: ButtonType.primary,
          label: 'Primary Button Disabled',
          onPressed: () {},
          isEnabled: false,
        ),
        const SizedBox(height: 16),
        // common secondary button
        CommonButton(
          type: ButtonType.secondary,
          label: 'Secondary Button Enabled',
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        // common secondary button disabled
        CommonButton(
          type: ButtonType.secondary,
          label: 'Secondary Button Disabled',
          onPressed: () {},
          isEnabled: false,
        ),
      ],
    );
  }

  Widget customIconButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Custom Icon Buttons',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        // custom icon button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomIconButton(
              type: IconButtonType.playButton,
              onPressed: () {},
            ),
            const SizedBox(height: 16),

            const SizedBox(height: 16),
            // custom icon button
            CustomIconButton(
              type: IconButtonType.popButton,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget socialMediaButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Social Media Buttons',
          style: TextStyle(fontSize: 24, color: Colors.blue),
        ),
        const SizedBox(height: 16),
        // social media button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SocialMediaButton(
              type: SocialMediaType.facebook,
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            // social media button
            SocialMediaButton(
              type: SocialMediaType.apple,
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            // social media button
            SocialMediaButton(
              type: SocialMediaType.google,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget secondaryIconButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Secondary Icon Buttons',
          style: TextStyle(fontSize: 24, color: Colors.blue),
        ),
        const SizedBox(height: 16),
        // secondary icon button
        SecondaryIconButton(
          type: SecondaryIconButtonType.photoUploadButton,
          label: 'Upload Photo',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget smallIconButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Small Icon Buttons',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        // small icon button
        SmallIconButton(
          label: 'New',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget customSearchBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Custom Search Bar',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        // custom search bar
        CustomSearchBar(
          controller: TextEditingController(),
          onCancel: () {},
          onItemFound: () {},
        ),
      ],
    );
  }

  Widget customInputField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Custom Input Field',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        // custom input field
        Form(
          key: _formKey,
          child: Column(
            children: [
              CustomInputField(
                label: "Email",
                hintText: "Enter your email",
                validator: emailValidator,
                controller: _emailController,
                suffixText: "@example.com",
                prefixIcon: AppAssets.emailIcon,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // If the form is valid, proceed
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget passwordInputField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Password Input Field',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        // custom input field
        Form(
          key: _formKey3,
          child: Column(
            children: [
              PasswordInputField(
                controller: _passwordController,
                hintText: "Password",
                validator: passwordValidator,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey3.currentState?.validate() ?? false) {
                    // If the form is valid, proceed
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget customInputFieldWithDropdown() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Custom Input Field with Dropdown',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        // custom input field
        Form(
          key: _formKey2,
          child: Column(
            children: [
              CustomInputFieldWithDropdown(
                hintText: "1000",
                //validator: emailValidator,
                controller: _amountController,
                suffixText: "USD",
                onSuffixPressed: () {},
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey2.currentState?.validate() ?? false) {
                    // If the form is valid, proceed
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget filterDropDownMenuButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Filter Drop Down Menu Button',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 80,
          child: FilterDropDownMenuButton(
            label: 'Line',
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget dropDownMenuButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Drop Down Menu Button',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        DropDownMenuButton(
          label: 'Percentage change',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget customRadioButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Custom Radio Button',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        // custom radio button
        CustomRadioButton(
          title: 'Option 1',
          isSelected: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value ?? false;
            });
          },
          trailingIcon: SvgPicture.asset(AppAssets.facebookIcon), // Optional SVG icon
        ),
        const SizedBox(height: 16),
        CustomRadioButton(
          title: 'Option 2',
          isSelected: !_selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value ?? false;
            });
          },
          // trailingIcon:
          //     SvgPicture.asset('assets/google_icon.svg'), // Optional SVG icon
        ),
      ],
    );
  }

  Widget customSwitch() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Custom Switch',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        // custom switch
        CustomSwitch(
          value: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
          },
        ),
      ],
    );
  }

  Widget customHorizontalPeriodFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Custom Horizontal Period Filter',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        // custom horizontal period filter
        PeriodFilter(
          periods: periods,
          selectedPeriod: selectedPeriod,
          onPeriodSelected: (selected) {
            // Handle the selected period change here
            print('Selected period: $selected');
          },
        ),
      ],
    );
  }

  Widget customDatePickerIconButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Text(
          'Custom Date Picker Icon Button',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),
        // custom date picker icon button
        DatePickerIconButton(
          selectedDate: '',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget fullBlockInsights() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          'Full Block Insights',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 16),
        // full block insights
        FullBlockInsights(
          text:
              'Lorem ipsum dolor sit amet consectetur. Id phasellus ultrices vel nisi. Ac tempus ut convallis morbi. Lorem ipsum dolor sit amet consectetur. Id phasellus ultrices vel nisi.',
        )
      ],
    );
  }
}
