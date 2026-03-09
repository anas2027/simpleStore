import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/extension/app_extension.dart';
import '../../../core/navigation/app_routes.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _selectLanguage(
    BuildContext context,
    Locale currentLocale,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('profile.selectLanguage'.locale, style: AppStyles.large),
                SizedBox(height: AppSizes.sm),
                ListTile(
                  title: const Text('English'),
                  trailing: currentLocale.languageCode == 'en'
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () async {
                    if (currentLocale.languageCode != 'en') {
                      await context.setLocale(const Locale('en'));
                    }
                    if (sheetContext.mounted) {
                      Navigator.of(sheetContext).pop();
                    }
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.splash,
                        (route) => false,
                      );
                    }
                  },
                ),
                ListTile(
                  title: const Text('العربية'),
                  trailing: currentLocale.languageCode == 'ar'
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () async {
                    if (currentLocale.languageCode != 'ar') {
                      await context.setLocale(const Locale('ar'));
                    }
                    if (sheetContext.mounted) {
                      Navigator.of(sheetContext).pop();
                    }
                    if (context.mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.splash,
                        (route) => false,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;

    return ListView(
      padding: EdgeInsets.all(AppSizes.md),
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.lg),
            child: Column(
              children: [
                CircleAvatar(
                  radius: AppSizes.xxl,
                  child: Text('AA', style: AppStyles.xLarge),
                ),
                SizedBox(height: AppSizes.sm),
                Text('Anas Alsamman', style: AppStyles.xLarge),
                SizedBox(height: AppSizes.xxs),
                Text('profile.title'.locale, style: AppStyles.medium),
              ],
            ),
          ),
        ),
        SizedBox(height: AppSizes.md),
        Card(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('profile.language'.locale, style: AppStyles.large),
                SizedBox(height: AppSizes.sm),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => _selectLanguage(context, Locale(locale)),
                    child: Text('profile.changeLanguage'.locale),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
