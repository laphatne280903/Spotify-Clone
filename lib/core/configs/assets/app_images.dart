class AppImages {
  static const String basePath = "assets/images/";
  static const String formatPng = ".png";
  static const String formatjpg = ".jpg";

  static String imagePng (String imageName) {
    String imageAssets="${basePath}${imageName}${formatPng}";
    return imageAssets;
  }

  static String imageJpg (String imageName) {
    String imageAssets="${basePath}${imageName}${formatjpg}";
    return imageAssets;
  }
}