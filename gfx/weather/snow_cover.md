# Snow cover texture

`snow_cover.png` is a 128 × 384 RGBA sheet with three 128 × 128 bands:
light, medium, and deep snow, from top to bottom. Each band contains a
continuous 4 × 4 pattern of 32 × 32 terrain tiles. Keep neighboring
edges aligned when replacing the sheet. The original terrain shows
through the transparent areas.

The snow density pattern was generated with ImageGen from visual references
to three CC0 Poly Haven materials, then downsampled and converted to the
three coverage masks used by the game:

- [Snow 02](https://polyhaven.com/a/snow_02)
- [Asphalt Snow](https://polyhaven.com/a/asphalt_snow)
- [Snow Field Aerial](https://polyhaven.com/a/snow_field_aerial)
