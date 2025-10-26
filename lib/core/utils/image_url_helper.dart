class ImageUrlHelper {
  // Picsum Photos - Reliable, fast, beautiful images
  static String getPicsumUrl({int width = 800, int height = 600, int? seed}) {
    if (seed != null) {
      return 'https://picsum.photos/$width/$height?random=$seed';
    } else {
      return 'https://picsum.photos/$width/$height';
    }
  }
}
