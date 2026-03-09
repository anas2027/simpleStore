import 'package:flutter/material.dart';

import '../theme/app_sizes.dart';
import 'app_image_widget.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});

  static const String _loadingAsset = 'assets/lottie/loading.lottie';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppImageWidget(
        imageUrl: _loadingAsset,
        width: AppSizes.imageLarge,
        height: AppSizes.imageLarge,
      ),
    );
  }
}
