#!/usr/bin/env python3
"""Compile the Natural Earth network and jurisdiction road-map items."""

import argparse
import json
import math
from pathlib import Path

import shapefile
from pyproj import CRS, Transformer
from shapely import transform
from shapely.geometry import LineString, shape

from generate_north_america import LATITUDE, LONGITUDE, RADIUS, components
from generate_regional_loot import render

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data"
COUNTRIES = {"USA", "CAN", "MEX"}
ROAD_TYPES = {
    "Road", "Secondary Highway", "Major Highway", "Beltway", "Bypass",
}
DISPLAY_NAMES = {
    "MX-CMX": "Mexico City", "MX-COA": "Coahuila", "MX-MIC": "Michoacán",
    "MX-VER": "Veracruz", "MX-MEX": "State of Mexico", "CA-QC": "Quebec",
}


def ontario_segments(source, projection):
    province = json.loads(source.read_text(encoding="utf-8"))
    lines = []
    for feature in province["features"]:
        name = feature["properties"]["FULL_STREET_NAME"]
        if name in {"HIGHWAY 401", "HIGHWAY 401 COLLECTOR"}:
            lines.append((
                name.endswith("COLLECTOR"),
                feature["properties"]["NUMBER_OF_LANES"],
                shape(feature["geometry"]),
            ))
    previous = None
    previous_lanes = 0
    for column in range(-79870, -79549):
        longitude = column / 1000
        meridian = LineString([(longitude, 43.50), (longitude, 43.68)])
        main_hits, collector_hits = [], []
        for collector, lanes, road in lines:
            intersection = road.intersection(meridian)
            points = collector_hits if collector else main_hits
            points.extend(
                (p.y, int(lanes)) for p in components(intersection, "Point")
            )
        if not main_hits:
            previous = None
            continue
        latitude = sum(y for y, _ in main_hits) / len(main_hits)
        collector_lanes = max(
            (n for y, n in collector_hits if abs(y - latitude) < 0.0015),
            default=0,
        )
        lanes = max(n for _, n in main_hits) + collector_lanes
        lanes = 12 if lanes >= 6 else 8 if lanes >= 4 else 6
        x, y = projection.transform(longitude, latitude)
        point = (math.floor(x / 24), math.floor(-y / 24))
        if previous is not None and 0 < math.dist(previous, point) < 24:
            yield tuple(sorted((previous, point))), min(lanes, previous_lanes)
        previous, previous_lanes = point, lanes


def project_roads(source, places, ontario401):
    projection = Transformer.from_crs(
        "EPSG:4326",
        CRS.from_proj4(
            f"+proj=aeqd +lat_0={LATITUDE} +lon_0={LONGITUDE} "
            f"+R={RADIUS} +units=m"
        ),
        always_xy=True,
    )
    centers = [(x, y, pop) for _, _, _, x, y, pop in places if pop >= 250_000]
    network = {}
    with shapefile.Reader(str(source), encoding="utf-8") as roads:
        for record in roads.iterShapeRecords():
            attributes = record.record.as_dict()
            if (attributes["sov_a3"] not in COUNTRIES or
                    attributes["type"] not in ROAD_TYPES):
                continue
            major = attributes["type"] in {
                "Major Highway", "Beltway", "Bypass",
            }
            express = bool(attributes["expressway"])
            for part in components(
                shape(record.shape.__geo_interface__), "LineString",
            ):
                if (len(part.coords) < 2 or
                        part.bounds[2] - part.bounds[0] > 180):
                    continue
                line = transform(
                    part, projection.transform, interleaved=False,
                ).simplify(45)
                if line.is_empty:
                    continue
                for (x0, y0), (x1, y1) in zip(
                    line.coords, list(line.coords)[1:],
                ):
                    count = max(
                        1, math.ceil(math.hypot(x1 - x0, y1 - y0) / 3000),
                    )
                    for index in range(count):
                        xa, ya = (
                            x0 + (x1 - x0) * index / count,
                            y0 + (y1 - y0) * index / count,
                        )
                        xb, yb = (
                            x0 + (x1 - x0) * (index + 1) / count,
                            y0 + (y1 - y0) * (index + 1) / count,
                        )
                        a = (math.floor(xa / 24), math.floor(-ya / 24))
                        b = (math.floor(xb / 24), math.floor(-yb / 24))
                        if a == b:
                            continue
                        x, y = (xa + xb) / 2, -(ya + yb) / 2
                        lanes = 2
                        if express or major:
                            urban = max(
                                (pop for px, py, pop in centers
                                 if abs(px - x) < 14_000 and
                                 abs(py - y) < 14_000),
                                default=0,
                            )
                            if express:
                                lanes = (
                                    8 if urban >= 1_500_000 else
                                    6 if urban >= 250_000 else 4
                                )
                            elif urban >= 250_000:
                                lanes = 4
                        segment = tuple(sorted((a, b)))
                        network[segment] = max(network.get(segment, 0), lanes)
    for segment, lanes in ontario_segments(ontario401, projection):
        network[segment] = max(network.get(segment, 0), lanes)
    return [(lanes, *a, *b) for (a, b), lanes in sorted(network.items())]


def compact_json(records):
    return "[\n" + ",\n".join(
        "  " + json.dumps(entry, ensure_ascii=False, separators=(", ", ": "))
        for entry in records
    ) + "\n]\n"


def jurisdiction_maps(source):
    atlas = json.loads(
        (DATA / "raw/north_america.jurisdictions").read_text(encoding="utf-8")
    )
    codes = {row[0] for row in atlas["polygons"]}
    with shapefile.Reader(
        str(source), encoding="utf-8", encodingErrors="replace",
    ) as regions:
        names = {
            record["iso_3166_2"]: record["name_en"] or record["name"]
            for record in regions.iterRecords()
        }
    for code in sorted(codes):
        name = DISPLAY_NAMES.get(code) or names[code]
        yield code, name


def map_stock(regions):
    records = [{
        "type": "item_group", "id": "roadmap_stock", "subtype": "distribution",
        "items": [["roadmap", 100]],
    }]
    for country in ("US", "CA", "MX"):
        entries = [
            [f"atlas_map_{code.lower()}", 100] for code, _ in regions
            if code.startswith(country + "-")
        ]
        records.append({
            "type": "item_group", "id": "atlas_maps_" + country,
            "subtype": "distribution", "items": entries,
        })
    records.append({
        "type": "item_group", "id": "atlas_maps", "subtype": "distribution",
        "groups": [
            [f"atlas_maps_{country}", 100] for country in ("US", "CA", "MX")
        ],
    })
    for code, _ in regions:
        records.append({
            "type": "item_group", "id": "roadmap_stock-" + code,
            "subtype": "distribution",
            "entries": [
                {"item": f"atlas_map_{code.lower()}", "prob": 65},
                {"item": "roadmap", "prob": 20},
                {"group": "atlas_maps_" + code[:2], "prob": 12},
                {"group": "atlas_maps", "prob": 3},
            ],
        })
    return records


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("roads", type=Path)
    parser.add_argument("jurisdictions", type=Path)
    parser.add_argument(
        "ontario401", type=Path,
        help="Ontario Road Network GeoJSON extract for Highway 401",
    )
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    places = json.loads(
        (DATA / "raw/north_america.atlas").read_text(encoding="utf-8")
    )["cities"]
    network = project_roads(args.roads, places, args.ontario401)
    regions = list(jurisdiction_maps(args.jurisdictions))
    road_maps = [
        {
            "type": "ITEM", "id": "atlas_map_" + code.lower(),
            "copy-from": "roadmap",
            "name": {
                "str": f"road map of {name}", "str_pl": f"road maps of {name}",
            },
            "description":
                "A printed chart of highways, rivers, and major cities.",
            "use_action": {
                "type": "reveal_map", "radius": 0, "atlas_jurisdiction": code,
            },
        }
        for code, name in regions
    ]
    for path, contents in {
        DATA / "raw/north_america.transport": compact_json(network),
        DATA / "json/items/book/atlas_road_maps.json": (
            render(road_maps) + "\n"
        ),
        DATA / "json/itemgroups/atlas_road_maps.json": (
            render(map_stock(regions)) + "\n"
        ),
    }.items():
        if args.check:
            if path.read_text(encoding="utf-8") != contents:
                raise SystemExit(f"{path.name} is out of date")
        else:
            path.write_text(contents, encoding="utf-8", newline="\n")


if __name__ == "__main__":
    main()
