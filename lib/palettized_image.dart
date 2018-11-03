import 'dart:io';
import 'dart:math';
import 'package:image/image.dart';
import 'palette.dart';
import 'palette_color.dart';

class PalettizedImage {
  File rawImage;
  Image image;
  Palette palette;
  int paletteSize = 10;
  int tolerance = 30;

  PalettizedImage(File rawImage) {
    this.rawImage = rawImage;
    this.image = decodeImage(rawImage.readAsBytesSync());
    print(this.image.height);
    print(this.image.width);
    generatePalette();
  }

  void generatePalette() {
    // Transform the _image into a convenient format for clustering
    Map<PaletteColor, int> colorMap = {};
    List<int> bytes = this.image.getBytes();
    for (var i = 0; i < bytes.length; i += 4) {
      PaletteColor color = new PaletteColor(bytes[i], bytes[i + 1], bytes[i + 2]);
      if (colorMap.containsKey(color)) {
        colorMap[color]++;
      } else {
        colorMap[color] = 1;
      }
    }
    // Run the clustering algorithm
    // First, sort the colors by frequency.
    List<PaletteColor> colors = colorMap.keys.toList();
    colors.sort((c1, c2) {
      if (colorMap[c1] > colorMap[c2]) {
        return -1;
      }
      if (colorMap[c1] < colorMap[c2]) {
        return 1;
      }
      return 0;
    });

    // Find the first N colors that are far enough away from each other.
    Set<PaletteColor> centroids = new Set<PaletteColor>();
    for (PaletteColor candidate in colors) {
      if (!centroids.any((centroid) => candidate.distanceFrom(centroid) <= tolerance)) {
        centroids.add(candidate);
      }
      if (centroids.length == paletteSize) {
        break;
      }
    }

    // Run K-means!
    // Compare each color in the image against the centroids to find the closest one
    // Then add the color to that centroid's neighbors
    int iterations = 0;
    List<Set<PaletteColor>> centroidPhases = [centroids];
    List<Set<PaletteColor>> finalCentroidPhases = kMeansHelper(iterations, colors, centroidPhases);
    print('done');
  }

 List<Set<PaletteColor>> kMeansHelper(int iterations, List<PaletteColor> colors, List<Set<PaletteColor>> centroids) {
    Set<PaletteColor> latest = centroids.last;
    Map<PaletteColor, List<PaletteColor>> centroidNeighborsMap = new Map<PaletteColor, List<PaletteColor>>();
    latest.forEach((centroid) {
      centroidNeighborsMap[centroid] = new List<PaletteColor>();
    });

    for (PaletteColor color in colors) {
      // Find the centroid in latest where latest.distanceFrom(color)
      List<int> distances = latest.map((centroid) => color.distanceFrom(centroid)).toList();
      PaletteColor closestCentroid = latest.elementAt(distances.indexOf(distances.reduce(min)));
      centroidNeighborsMap[closestCentroid].add(color);
    }

    Set<PaletteColor> newCentroids = centroidNeighborsMap.values.toSet().map((neighbors) => averageOfColors(neighbors)).toSet();
    centroids.add(newCentroids);

    if (newCentroids.containsAll(latest)) {
      print('Finished with $iterations iterations.');
      return centroids;
    } else {
      return kMeansHelper(iterations + 1, colors, centroids);
    }
  }

  PaletteColor averageOfColors(List<PaletteColor> colors) {
    Map<String, int> sums = { 'r': 0, 'g': 0, 'b': 0 };
    colors.fold(sums, (map, color) {
      map['r'] += color.r;
      map['g'] += color.g;
      map['b'] += color.b;
      return map;
    });

    return new PaletteColor(sums['r'] ~/ colors.length, sums['g'] ~/ colors.length, sums['b'] ~/ colors.length);
  }


}