part of 'style_guide.dart';

class AppColors {
  // Main background colors - Warm, light theme
  static const bgPrimary = Color.fromRGBO(255, 252, 248, 1); // Warm off-white
  static const bgSecondary = Color.fromRGBO(
    255,
    248,
    240,
    1,
  ); // Very light peach
  static const bgTertiary = Color.fromRGBO(255, 245, 235, 1); // Light cream
  static const bgNegative = Color.fromRGBO(
    255,
    235,
    235,
    1,
  ); // Light red background
  static const bgPositive = Color.fromRGBO(
    235,
    255,
    235,
    1,
  ); // Light green background

  // Text colors - Dark, readable
  static const textPrimary = Color.fromRGBO(45, 35, 25, 1); // Warm dark brown
  static const textSecondary = Color.fromRGBO(100, 85, 70, 1); // Medium brown
  static const textError = Color.fromRGBO(220, 80, 80, 1); // Warm red
  static const textUrl = Color.fromRGBO(70, 130, 200, 1); // Warm blue

  // Icon colors
  static const iconsPrimary = Color.fromRGBO(45, 35, 25, 1); // Warm dark brown
  static const iconsSecondary = Color.fromRGBO(100, 85, 70, 1); // Medium brown

  // Button colors - Warm and inviting
  static const buttonPrimary = Color.fromRGBO(255, 140, 80, 1); // Warm orange
  static const buttonSecondary = Color.fromRGBO(100, 160, 220, 1); // Warm blue
  static const buttonDisabled = Color.fromRGBO(200, 190, 180, 1); // Light gray

  // Button text colors
  static const textButtonDefault = Color.fromRGBO(255, 255, 255, 1); // White
  static const textButtonSecondary = Color.fromRGBO(
    255,
    140,
    80,
    1,
  ); // Warm orange

  // Border colors
  static const borderActive = Color.fromRGBO(255, 140, 80, 1); // Warm orange
  static const borderDisabled = Color.fromRGBO(200, 190, 180, 1); // Light gray
  static const borderError = Color.fromRGBO(220, 80, 80, 1); // Warm red

  // Tile background
  static const tileBg = Color.fromRGBO(255, 250, 245, 1); // Very light peach

  // Basic colors
  static const white = Color.fromRGBO(255, 255, 255, 1);
  static const black = Color.fromRGBO(0, 0, 0, 1);

  // Text field background
  static const textFieldBg = Color.fromRGBO(
    255,
    250,
    245,
    1,
  ); // Very light peach

  // Primary colors - Warm orange family
  static const primary100 = Color.fromRGBO(255, 200, 160, 1); // Light orange
  static const primary200 = Color.fromRGBO(
    255,
    170,
    120,
    1,
  ); // Medium light orange
  static const primary300 = Color.fromRGBO(255, 140, 80, 1); // Main orange
  static const primary400 = Color.fromRGBO(255, 110, 50, 1); // Darker orange
  static const primary500 = Color.fromRGBO(220, 90, 40, 1); // Dark orange
  static const primaryAlpha10 = Color.fromRGBO(255, 140, 80, 0.1);

  // Secondary colors - Warm blue family
  static const secondary100 = Color.fromRGBO(180, 210, 240, 1); // Light blue
  static const secondary200 = Color.fromRGBO(
    140,
    180,
    220,
    1,
  ); // Medium light blue
  static const secondary300 = Color.fromRGBO(100, 160, 220, 1); // Main blue
  static const secondary400 = Color.fromRGBO(80, 140, 200, 1); // Darker blue
  static const secondary500 = Color.fromRGBO(60, 120, 180, 1); // Dark blue
  static const secondaryAlpha10 = Color.fromRGBO(100, 160, 220, 0.1);

  // Natural colors - Warm grays
  static const natural100 = Color.fromRGBO(255, 255, 255, 1); // White
  static const natural200 = Color.fromRGBO(
    245,
    240,
    235,
    1,
  ); // Very light warm gray
  static const natural300 = Color.fromRGBO(235, 230, 225, 1); // Light warm gray
  static const natural400 = Color.fromRGBO(
    220,
    215,
    210,
    1,
  ); // Medium light warm gray
  static const natural500 = Color.fromRGBO(
    200,
    195,
    190,
    1,
  ); // Medium warm gray
  static const natural600 = Color.fromRGBO(
    170,
    165,
    160,
    1,
  ); // Medium dark warm gray
  static const natural700 = Color.fromRGBO(140, 135, 130, 1); // Dark warm gray
  static const natural800 = Color.fromRGBO(
    110,
    105,
    100,
    1,
  ); // Very dark warm gray
  static const natural900 = Color.fromRGBO(
    80,
    75,
    70,
    1,
  ); // Almost black warm gray
  static const natural1000 = Color.fromRGBO(45, 35, 25, 1); // Warm dark brown
  static const naturalAlpha10 = Color.fromRGBO(45, 35, 25, 0.1);

  // Red colors - Warm reds
  static const red100 = Color.fromRGBO(255, 180, 180, 1); // Light warm red
  static const red200 = Color.fromRGBO(220, 80, 80, 1); // Main warm red
  static const redAlpha10 = Color.fromRGBO(220, 80, 80, 0.1);

  // Yellow colors - Warm yellows
  static const yellow100 = Color.fromRGBO(
    255,
    230,
    150,
    1,
  ); // Light warm yellow
  static const yellow200 = Color.fromRGBO(255, 200, 100, 1); // Main warm yellow
  static const yellowAlpha10 = Color.fromRGBO(255, 200, 100, 0.1);

  // Green colors - Warm greens
  static const green100 = Color.fromRGBO(200, 240, 200, 1); // Light warm green
  static const green200 = Color.fromRGBO(120, 200, 120, 1); // Main warm green
  static const greenAlpha10 = Color.fromRGBO(120, 200, 120, 0.1);

  // Family-specific colors for tree view and member management
  static const familyPrimary = Color.fromRGBO(255, 140, 80, 1); // Warm orange
  static const familySecondary = Color.fromRGBO(100, 160, 220, 1); // Warm blue
  static const familyAccent = Color.fromRGBO(255, 200, 100, 1); // Warm yellow
  static const familySuccess = Color.fromRGBO(120, 200, 120, 1); // Warm green
  static const familyWarning = Color.fromRGBO(
    255,
    180,
    100,
    1,
  ); // Warm orange-yellow
  static const familyError = Color.fromRGBO(220, 80, 80, 1); // Warm red

  // Tree view specific colors
  static const treeLine = Color.fromRGBO(
    200,
    190,
    180,
    1,
  ); // Light gray for tree lines
  static const treeNode = Color.fromRGBO(
    255,
    250,
    245,
    1,
  ); // Light background for nodes
  static const treeNodeSelected = Color.fromRGBO(
    255,
    200,
    160,
    1,
  ); // Light orange for selected nodes

  // Other colors
  static const notificationCircleIcon = Color.fromRGBO(
    255,
    140,
    80,
    1,
  ); // Warm orange
  static const notificationDetails = Color.fromRGBO(
    100,
    85,
    70,
    1,
  ); // Medium brown
  static const notificationShadow = Color.fromRGBO(45, 35, 25, 0.1);

  static const gaugePointer = Color.fromRGBO(255, 140, 80, 1); // Warm orange
  static const gaugeBackground = Color.fromRGBO(
    245,
    240,
    235,
    1,
  ); // Light warm gray
  static const gaugeSmallPointer = Color.fromRGBO(
    100,
    160,
    220,
    1,
  ); // Warm blue

  static const tagBg = Color.fromRGBO(255, 200, 160, 1); // Light orange
  static const tagText = Color.fromRGBO(45, 35, 25, 1); // Warm dark brown
}
