import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

/// Where the image bytes are coming from.
/// You won't set this directly — use one of the named constructors below
/// (AppImage.network, AppImage.asset, AppImage.file, AppImage.memory)
/// and this gets set automatically.
enum _ImageSourceType { asset, network, file, memory }

/// One widget to handle every image in the app — product photos, user
/// avatars, category icons, receipts, whatever. It takes care of:
///   - loading spinner while a network image downloads
///   - a fallback icon if the image fails to load (bad URL, no file, etc.)
///   - optional circle/rounded shape so you're not wrapping in ClipRRect everywhere
///
/// Usage:
///   AppImage.network('https://...', width: 80, height: 80, shape: ImageShape.circle)
///   AppImage.asset('assets/logo.png', width: 64)
///   AppImage.file(File('/storage/.../photo.jpg'), shape: ImageShape.rounded)
enum ImageShape { rectangle, rounded, circle }

class AppImage extends StatelessWidget {
  final _ImageSourceType _sourceType;
  final String? _path; // used for asset & network
  final File? _file; // used for file
  final Uint8List? _bytes; // used for memory

  final double? width;
  final double? height;
  final BoxFit fit;
  final ImageShape shape;
  final double borderRadius; // only used when shape == ImageShape.rounded
  final Color backgroundColor;
  final Widget? placeholder; // shown while a network image loads
  final Widget? errorWidget; // shown if loading fails

  const AppImage._({
    required _ImageSourceType sourceType,
    String? path,
    File? file,
    Uint8List? bytes,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.shape = ImageShape.circle,
    this.borderRadius = 12,
    this.backgroundColor = AppColors.cardBackground,
    this.placeholder,
    this.errorWidget,
  }) : _sourceType = sourceType,
       _path = path,
       _file = file,
       _bytes = bytes;

  /// Image coming from a URL, e.g. a product photo stored in the cloud.
  const AppImage.network(
    String url, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    ImageShape shape = ImageShape.rectangle,
    double borderRadius = 12,
    Color backgroundColor = AppColors.cardBackground,
    Widget? placeholder,
    Widget? errorWidget,
  }) : this._(
         sourceType: _ImageSourceType.network,
         path: url,
         width: width,
         height: height,
         fit: fit,
         shape: shape,
         borderRadius: borderRadius,
         backgroundColor: backgroundColor,
         placeholder: placeholder,
         errorWidget: errorWidget,
       );

  /// Image bundled with the app, e.g. assets/images/logo.png
  /// (remember to declare the assets folder in pubspec.yaml)
  const AppImage.asset(
    String assetPath, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    ImageShape shape = ImageShape.rectangle,
    double borderRadius = 12,
    Color backgroundColor = AppColors.cardBackground,
    Widget? errorWidget,
  }) : this._(
         sourceType: _ImageSourceType.asset,
         path: assetPath,
         width: width,
         height: height,
         fit: fit,
         shape: shape,
         borderRadius: borderRadius,
         backgroundColor: backgroundColor,
         errorWidget: errorWidget,
       );

  /// Image picked from the device, e.g. a photo taken with the camera
  /// (common for "add product photo" or "cashier profile picture" flows)
  const AppImage.file(
    File file, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    ImageShape shape = ImageShape.rectangle,
    double borderRadius = 12,
    Color backgroundColor = AppColors.cardBackground,
    Widget? errorWidget,
  }) : this._(
         sourceType: _ImageSourceType.file,
         file: file,
         width: width,
         height: height,
         fit: fit,
         shape: shape,
         borderRadius: borderRadius,
         backgroundColor: backgroundColor,
         errorWidget: errorWidget,
       );

  /// Image already in memory as raw bytes, e.g. decoded from a barcode/receipt scan
  const AppImage.memory(
    Uint8List bytes, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    ImageShape shape = ImageShape.rectangle,
    double borderRadius = 12,
    Color backgroundColor = AppColors.cardBackground,
    Widget? errorWidget,
  }) : this._(
         sourceType: _ImageSourceType.memory,
         bytes: bytes,
         width: width,
         height: height,
         fit: fit,
         shape: shape,
         borderRadius: borderRadius,
         backgroundColor: backgroundColor,
         errorWidget: errorWidget,
       );

  Widget _defaultPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: backgroundColor,
      alignment: Alignment.center,
      child: const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.primaryPurple,
        ),
      ),
    );
  }

  Widget _defaultErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: backgroundColor,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_not_supported_outlined,
        color: AppColors.textGrey,
        size: (width ?? height ?? 40) * 0.4,
      ),
    );
  }

  Widget _buildRawImage() {
    switch (_sourceType) {
      case _ImageSourceType.network:
        return Image.network(
          _path!,
          width: width,
          height: height,
          fit: fit,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child; // finished loading
            return placeholder ?? _defaultPlaceholder();
          },
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ?? _defaultErrorWidget();
          },
        );

      case _ImageSourceType.asset:
        return Image.asset(
          _path!,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ?? _defaultErrorWidget();
          },
        );

      case _ImageSourceType.file:
        return Image.file(
          _file!,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ?? _defaultErrorWidget();
          },
        );

      case _ImageSourceType.memory:
        return Image.memory(
          _bytes!,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ?? _defaultErrorWidget();
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = _buildRawImage();

    // Circle shape: clip with ClipOval instead of ClipRRect
    if (shape == ImageShape.circle) {
      return ClipOval(child: image);
    }

    // Rounded rectangle shape
    if (shape == ImageShape.rounded) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: image,
      );
    }

    // Plain rectangle, no clipping needed
    return image;
  }
}
