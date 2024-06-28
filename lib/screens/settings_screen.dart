import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common/styles/paddings.dart';
import '../cubits/anime_title_language_cubit.dart';
import '../cubits/theme_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Padding(
        padding: Paddings.defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Dark mode switch
              AppThemeSwitch(),

              SizedBox(height: 10),

              // Anime Title name switch
              AnimeTitleLanguageSwitch(),

              SizedBox(height: 10),

              // Notification preferences
              NotificationSettings(),

              SizedBox(height: 10),

              // Account settings
              AccountSettings(),
            ],
          ),
        ),
      ),
    );
  }
}

//! Dark Mode Switch
class AppThemeSwitch extends StatefulWidget {
  const AppThemeSwitch({super.key});

  @override
  State<AppThemeSwitch> createState() => AppThemeSwitchState();
}

class AppThemeSwitchState extends State<AppThemeSwitch> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    context.read<ThemeCubit>().getIsDarkMode().then((isDark) {
      setState(() {
        isDarkMode = isDark;
      });
    });
  }

  Future<void> toggleTheme(bool value) async {
    setState(() => isDarkMode = value);
    await context.read<ThemeCubit>().changeTheme(isDarkMode: isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Dark Theme'),
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, state) {
            isDarkMode = state == ThemeMode.dark;
            return CupertinoSwitch(
              value: isDarkMode,
              onChanged: toggleTheme,
            );
          },
        ),
      ],
    );
  }
}

//! Anime Title Language Switch
class AnimeTitleLanguageSwitch extends StatefulWidget {
  const AnimeTitleLanguageSwitch({super.key});

  @override
  State<AnimeTitleLanguageSwitch> createState() =>
      AnimeTitleLanguageSwitchState();
}

class AnimeTitleLanguageSwitchState extends State<AnimeTitleLanguageSwitch> {
  bool isEnglish = false;

  Future<void> toggleAnimeTitleLanguage(bool value) async {
    setState(() => isEnglish = value);
    await context
        .read<AnimeTitleLanguageCubit>()
        .changeAnimeTitleLanguage(isEnglish: isEnglish);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Use English Names'),
        BlocBuilder<AnimeTitleLanguageCubit, bool>(
          builder: (context, state) {
            isEnglish = state;
            return CupertinoSwitch(
              value: isEnglish,
              onChanged: toggleAnimeTitleLanguage,
            );
          },
        ),
      ],
    );
  }
}

//! Notification Settings
class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => NotificationSettingsState();
}

class NotificationSettingsState extends State<NotificationSettings> {
  bool isNotificationsEnabled = true;

  Future<void> toggleNotifications(bool value) async {
    setState(() => isNotificationsEnabled = value);
    // Here you can add code to save the preference to a database or API
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Enable Notifications'),
        CupertinoSwitch(
          value: isNotificationsEnabled,
          onChanged: toggleNotifications,
        ),
      ],
    );
  }
}

//! Account Settings
class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Profile'),
          onTap: () {
            // Navigate to edit profile screen
          },
        ),
        ListTile(
          leading: Icon(Icons.lock),
          title: Text('Change Password'),
          onTap: () {
            // Navigate to change password screen
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () {
            // Implement logout functionality
          },
        ),
      ],
    );
  }
}
