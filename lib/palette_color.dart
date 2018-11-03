import 'package:quiver/core.dart';

class PaletteColor {
  int r;
  int g;
  int b;

  PaletteColor(this.r, this.g, this.b);

  bool operator ==(o) => o is PaletteColor && r == o.r && g == o.g && b == o.b;
  int get hashCode => hash3(r.hashCode, g.hashCode, b.hashCode);

  int distanceFrom(PaletteColor other) {
    return (r - other.r).abs() + (g - other.g).abs() + (b - other.b).abs();
  }

  String toString() {
    return '($r, $g, $b)';
  }
}