#!/usr/bin/env python3
"""Sample Natural Earth urban areas into compact CCB city districts."""

import argparse
import json
import math
from pathlib import Path

from pyproj import CRS, Transformer
from shapely import STRtree
from shapely.geometry import Point

from generate_north_america import (
    LATITUDE, LONGITUDE, RADIUS, projected_features,
)

DISTRICT_SIZE = 48
METRES_PER_OMT = 24
MIN_CITY_POPULATION = 100_000


def districts(urban_areas, atlas):
    project = Transformer.from_crs(
        "EPSG:4326",
        CRS.from_proj4(
            f"+proj=aeqd +lat_0={LATITUDE} "
            f"+lon_0={LONGITUDE} +R={RADIUS} +units=m"),
        always_xy=True,
    )
    centers = [
        (index, Point(x, -y))
        for index, (_, _, _, x, y, population) in enumerate(atlas["cities"])
        if population >= MIN_CITY_POPULATION
    ]
    index = STRtree([point for _, point in centers])
    metres = DISTRICT_SIZE * METRES_PER_OMT
    sampled = {}
    for polygon in projected_features(urban_areas, project, "Polygon"):
        if polygon.area < metres * metres:
            continue
        nearby = index.query(polygon, predicate="dwithin", distance=5000)
        if len(nearby) == 0:
            continue
        x0, y0, x1, y1 = polygon.bounds
        for row in range(math.floor(-y1 / metres), math.ceil(-y0 / metres)):
            for col in range(math.floor(x0 / metres), math.ceil(x1 / metres)):
                center = Point((col + 0.5) * metres, -(row + 0.5) * metres)
                if not polygon.covers(center):
                    continue
                closest = min(
                    nearby, key=lambda
                    candidate: centers[candidate][1].distance(center))
                sampled[col, row] = centers[closest][0]
    return [[x, y, city] for (x, y), city in sorted(sampled.items())]


def render(urban_areas, atlas):
    entries = ",\n".join(
        "    " + json.dumps(district)
        for district in districts(urban_areas, atlas))
    return (
        f'{{\n  "version": 1,\n  "district_size": {DISTRICT_SIZE},\n'
        f'  "districts": [\n{entries}\n  ]\n}}\n'
    )


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("urban_areas", type=Path)
    parser.add_argument("atlas", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    atlas = json.loads(args.atlas.read_text(encoding="utf-8"))
    expected = render(args.urban_areas, atlas)
    if args.check:
        if args.output.read_text(encoding="utf-8") != expected:
            parser.exit(1, "Urban districts are out of date\n")
    else:
        args.output.write_text(expected, encoding="utf-8", newline="\n")


if __name__ == "__main__":
    main()
