#!/usr/bin/env python3
(
    "Project Natural Earth 1:10m admin-1 boundaries into the North America "
    "atlas."
)

import argparse
import json
from pathlib import Path

import shapefile
from pyproj import CRS, Transformer
from shapely import transform
from shapely.geometry import shape
from shapely.validation import make_valid

from generate_north_america import (
    LATITUDE, LONGITUDE, RADIUS, components, pack_polygon,
)


def render(source):
    project = Transformer.from_crs(
        "EPSG:4326",
        CRS.from_proj4(
            f"+proj=aeqd +lat_0={LATITUDE} +lon_0={LONGITUDE} "
            f"+R={RADIUS} +units=m"
        ),
        always_xy=True,
    )
    rows = []
    with shapefile.Reader(str(source), encoding="utf-8") as shapes:
        for record in shapes.iterShapeRecords():
            if record.record["adm0_a3"] not in {"USA", "CAN", "MEX"}:
                continue
            code = record.record["iso_3166_2"]
            if not code:
                raise ValueError(
                    "Missing ISO subdivision code for "
                    f"{record.record['name']}"
                )
            if code == "MX-X01~":
                # Natural Earth's unnamed offshore feature has no state code.
                continue
            if code == "MX-DIF":
                code = "MX-CMX"
            outlines = make_valid(shape(record.shape.__geo_interface__))
            for polygon in components(outlines, "Polygon"):
                projected = transform(
                    polygon, project.transform, interleaved=False
                )
                # Keep shared land-border vertices. Discard small coastal
                # rocks that are also below the scale of the terrain atlas.
                if projected.area >= 100_000:
                    rows.append((code, pack_polygon(projected)))
    body = ",\n".join(
        "    " + json.dumps(row, separators=(",", ":"))
        for row in sorted(rows)
    )
    return '{\n  "version": 1,\n  "polygons": [\n' + body + "\n  ]\n}\n"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "source", type=Path,
        help="Natural Earth admin-1 ZIP or SHP with its DBF",
    )
    parser.add_argument("output", type=Path)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    expected = render(args.source)
    if args.check:
        if args.output.read_text(encoding="utf-8") != expected:
            parser.exit(1, "North America jurisdictions are out of date\n")
    else:
        args.output.write_text(expected, encoding="utf-8", newline="\n")


if __name__ == "__main__":
    main()
