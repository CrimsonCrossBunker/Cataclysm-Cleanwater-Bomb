#!/usr/bin/env python3
"""Bake USDA Global Soil Regions into a compact, quarter-degree game grid."""

import argparse
import json
from pathlib import Path

# Each class is a gameplay approximation of a broad mapped soil unit.
SOIL_TYPES = {
    "Acrisols": "clay_loam",
    "Andosols": "volcanic",
    "Arenosols": "sandy_loam",
    "Cambisols": "loam",
    "Chernozems": "prairie",
    "Ferralsols": "clay_loam",
    "Fluvisols": "silt_loam",
    "Gleysols": "silt_loam",
    "Greyzems": "prairie",
    "Histosols": "organic",
    "Kastanozems": "prairie",
    "Lithosols": "gravelly",
    "Luvisols": "clay_loam",
    "Nitosols": "clay_loam",
    "Phaeozems": "prairie",
    "Planosols": "clay_loam",
    "Plansols": "clay_loam",
    "Podzols": "podzol",
    "Podzoluvisols": "podzol",
    "Regosols": "gravelly",
    "Rendzinas": "calcareous",
    "Solonchak": "calcareous",
    "Solonetz": "clay_loam",
    "Vertisols": "heavy_clay",
    "Vertsols": "heavy_clay",
    "Xerosols": "sandy_loam",
    "Yermosols": "sandy_loam",
}
NON_SOIL = {"No data", "Glaciers", "Salt", "Water"}
WEST, NORTH, EAST, SOUTH = -180, 84, -48, 10
STEP = 0.25
WIDTH = int((EAST - WEST) / STEP)
HEIGHT = int((NORTH - SOUTH) / STEP)


def render(source):
    from rasterio.features import rasterize
    from rasterio.transform import from_origin

    features = json.loads(source.read_text(encoding="utf-8"))["features"]
    types = sorted(set(SOIL_TYPES.values()))
    codes = {name: index + ord("A") for index, name in enumerate(types)}
    shapes = []
    for feature in features:
        label = feature["properties"]["soilRegionName"]
        if label in NON_SOIL:
            continue
        shapes.append((feature["geometry"], codes[SOIL_TYPES[label]]))
    cells = rasterize(
        shapes, out_shape=(
            HEIGHT, WIDTH), dtype="uint8", transform=from_origin(
            WEST, NORTH, STEP, STEP), fill=ord("."))
    rows = ",\n".join(
        "    " +
        json.dumps(
            row.tobytes().decode("ascii")) for row in cells)
    return (
        '{\n  "version": 1,\n'
        f'  "west": {WEST},\n  "north": {NORTH},\n  "step": {STEP},\n'
        f'  "types": {json.dumps(types)},\n  "rows": [\n{rows}\n  ]\n}}\n'
    )


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "source",
        type=Path,
        help="USDA Global Soil Regions GeoJSON export")
    parser.add_argument("output", type=Path)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    expected = render(args.source)
    if args.check:
        if args.output.read_text(encoding="utf-8") != expected:
            parser.exit(1, "North America soils are out of date\n")
    else:
        args.output.write_text(expected, encoding="utf-8", newline="\n")


if __name__ == "__main__":
    main()
