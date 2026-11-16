#!/usr/bin/env python3
"""Generate atlas soil cover definitions and the NSIDC permafrost grid."""

import argparse
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TERRAIN = ROOT / "data/json/furniture_and_terrain"
FORMS = {
    "grass": ("t_grass", "grass", "grazed_grass"),
    "long_grass": ("t_grass_long", "long grass", "grass"),
    "tall_grass": ("t_grass_tall", "tall grass", "long_grass"),
    "dead_grass": ("t_grass_dead", "dead grass", None),
    "grazed_grass": ("t_grass_grazed", "grazed grass", "grass"),
    "forest_floor": ("t_forestfloor", "forest floor", None),
    "moss": ("t_moss", "moss", None),
}


def ground_cover():
    original = json.loads(
        (TERRAIN / "terrain-north-america-soils.json").read_text(
            encoding="utf-8"))
    variants = []
    for soil in original:
        if soil["copy-from"] != "t_dirt":
            continue
        for suffix, (base, cover, next_cover) in FORMS.items():
            variant = {
                "type": "terrain",
                "id": f'{soil["id"]}_{suffix}',
                "copy-from": base,
                "name": f'{cover} on {soil["name"]}',
                "looks_like": base,
            }
            if next_cover:
                variant["transforms_into"] = f'{soil["id"]}_{next_cover}'
            variants.append(variant)
    return json.dumps(variants, indent=2, ensure_ascii=False) + "\n"


def permafrost_grid(source):
    import numpy
    import shapefile
    import shapely
    from pyproj import CRS, Transformer
    from shapely.geometry import shape as geometry_shape

    with shapefile.Reader(str(source), encoding="latin1") as shape_file:
        polygons, values = [], []
        for record in shape_file.iterShapeRecords():
            category = int(record.record.as_dict()["NUM_CODE"])
            # NSIDC categories 1 to 20 repeat continuous, discontinuous,
            # sporadic and isolated. Glaciers and open water are excluded.
            if 1 <= category <= 20 and record.shape.points:
                polygons.append(geometry_shape(record.shape.__geo_interface__))
                values.append((category - 1) % 4 + 1)

    west, north, step = -180, 84, 0.5
    width, height = 264, 100
    source_crs = CRS.from_wkt(
        source.with_suffix(".prj").read_text(
            encoding="ascii"))
    transform = Transformer.from_crs("EPSG:4326", source_crs, always_xy=True)
    longitude, latitude = numpy.meshgrid(
        west + (numpy.arange(width) + 0.5) * step,
        north - (numpy.arange(height) + 0.5) * step,
    )
    x, y = transform.transform(longitude.ravel(), latitude.ravel())
    cells = numpy.zeros(width * height, dtype="uint8")
    centers, shapes = shapely.STRtree(polygons).query(
        shapely.points(x, y), predicate="within")
    for center, shape in zip(centers, shapes):
        value = values[shape]
        if not cells[center] or value < cells[center]:
            cells[center] = value
    rows = [
        "".join(".CDSI"[value] for value in row)
        for row in cells.reshape(height, width)
    ]
    data = {
        "version": 1,
        "west": west,
        "north": north,
        "step": step,
        "rows": rows}
    return json.dumps(data, indent=2) + "\n"


def write_output(path, output, check):
    if check:
        if not path.is_file() or path.read_text(encoding="utf-8") != output:
            raise SystemExit(f"{path.name} differs from the generated data")
    else:
        path.write_text(output, encoding="utf-8", newline="\n")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--permafrost", type=Path,
        help="NSIDC permaice.shp with its accompanying files")
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    write_output(
        TERRAIN /
        "terrain-north-america-ground-cover.json",
        ground_cover(),
        args.check)
    if args.permafrost:
        write_output(
            ROOT /
            "data/raw/north_america.permafrost",
            permafrost_grid(
                args.permafrost),
            args.check)


if __name__ == "__main__":
    main()
