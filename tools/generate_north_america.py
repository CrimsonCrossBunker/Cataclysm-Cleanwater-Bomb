#!/usr/bin/env python3
"""Project Natural Earth data into CCB's one-metre North America world grid."""

import argparse
import json
import math
from pathlib import Path

import shapefile
from pyproj import CRS, Transformer
from shapely import transform
from shapely.geometry import Polygon, box, shape
from shapely.validation import make_valid

LATITUDE = 42.47
LONGITUDE = -71.2894
RADIUS = 6371000
# Continue around Greenland on the east, leaving Iceland outside the mask.
# The second window picks up the Aleutians across the antimeridian.
WINDOWS = [
    Polygon([(-180, 7), (-47, 7), (-47, 54), (-37, 59), (-32, 64), (-24, 69),
             (-6, 74), (-6, 90), (-180, 90)]),
    box(170, 50, 180, 56),
]
LAYERS = {
    "land": "ne_10m_land.zip",
    "lakes": "ne_10m_lakes.zip",
    "rivers": "ne_10m_rivers_lake_centerlines.zip",
    "cities": "ne_10m_populated_places.zip",
}


def components(geometry, kind):
    if geometry.is_empty:
        return
    if geometry.geom_type == kind:
        yield geometry
    elif hasattr(geometry, "geoms"):
        for part in geometry.geoms:
            yield from components(part, kind)


def projected_features(path, project, kind, max_rank=None):
    with shapefile.Reader(str(path), encoding="utf-8") as source:
        for record in source.iterShapeRecords():
            if max_rank is not None and record.record["scalerank"] > max_rank:
                continue
            if kind == "LineString" and record.record["featurecla"] != "River":
                continue
            geometry = shape(record.shape.__geo_interface__)
            for window in WINDOWS:
                if not window.intersects(box(*geometry.bounds)):
                    continue
                clipped = make_valid(geometry).intersection(window)
                for part in components(clipped, kind):
                    projected = transform(part, project.transform, interleaved=False).simplify(120, preserve_topology=True)
                    yield from components(projected, kind)


def packed_points(points):
    return [[round(x), round(-y)] for x, y in points]


def pack_polygon(polygon):
    return [packed_points(polygon.exterior.coords),
            *(packed_points(ring.coords) for ring in polygon.interiors)]


def build(source):
    # Spherical azimuthal equidistant: metre distances from Bedford are preserved.
    project = Transformer.from_crs(
        "EPSG:4326",
        CRS.from_proj4(f"+proj=aeqd +lat_0={LATITUDE} +lon_0={LONGITUDE} +R={RADIUS} +units=m"),
        always_xy=True,
    )
    map_data = {
        "version": 1,
        "land": [pack_polygon(p) for p in projected_features(
            source / LAYERS["land"], project, "Polygon") if p.area >= 1_000_000],
        "lakes": [pack_polygon(p) for p in projected_features(
            source / LAYERS["lakes"], project, "Polygon", 6) if p.area >= 1_000_000],
        "rivers": [packed_points(p.coords) for p in projected_features(
            source / LAYERS["rivers"], project, "LineString", 7)],
        "cities": [],
    }
    with shapefile.Reader(str(source / LAYERS["cities"]), encoding="utf-8") as places:
        for r in places.iterRecords():
            if r["ADM0_A3"] not in {"USA", "CAN", "MEX"} or not r["ADM1NAME"]:
                continue
            if r["SCALERANK"] > 8 or r["ADM1NAME"] == "Hawaii":
                continue
            x, y = project.transform(r["LONGITUDE"], r["LATITUDE"])
            if not math.isfinite(x) or not math.isfinite(y):
                continue
            map_data["cities"].append([r["ADM0NAME"], r["ADM1NAME"], r["NAME"],
                                       round(x), round(-y), r["POP_MAX"]])
    map_data["cities"].sort()
    return map_data


def render(data):
    lines = ['{', '  "version": 1,']
    for key in ("land", "lakes", "rivers", "cities"):
        lines.append(f'  "{key}": [')
        for i, entry in enumerate(data[key]):
            suffix = "," if i + 1 < len(data[key]) else ""
            lines.append("    " + json.dumps(entry, ensure_ascii=False, separators=(",", ":")) + suffix)
        lines.append("  ]" + ("," if key != "cities" else ""))
    return "\n".join(lines + ["}", ""])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path, help="directory containing the four Natural Earth ZIPs")
    parser.add_argument("output", type=Path)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    expected = render(build(args.source))
    if args.check:
        if args.output.read_text(encoding="utf-8") != expected:
            parser.exit(1, "North America atlas is out of date\n")
    else:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(expected, encoding="utf-8", newline="\n")


if __name__ == "__main__":
    main()
