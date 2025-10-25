
import '../constants/app_constants.dart';

abstract class ImageHelper {
  static String showImage(String image)=> '${AppConstants.storageUrl}$image';
}