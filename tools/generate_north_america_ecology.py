#!/usr/bin/env python3
"""Bake CEC ecoregions and Little's native plant ranges into the CCB atlas grid."""

import argparse
import json
from pathlib import Path

import numpy as np
from pyproj import CRS, Transformer
from rasterio.features import rasterize
from rasterio.transform import from_origin, rowcol
from rasterio import Affine, open as open_raster
from rasterio.warp import Resampling, reproject
from shapely import make_valid, transform
from shapely.geometry import shape

PROJECTION = CRS.from_proj4("+proj=aeqd +lat_0=42.47 +lon_0=-71.2894 +R=6371000 +units=m")
STEP = 8640  # two overmaps, with one map square per projected metre
X, Y = -7603200, -6220800
WIDTH, HEIGHT = 1320, 1250
AFFINE = from_origin(X, -Y, STEP, STEP)


def read(path):
    return json.loads(path.read_text(encoding="utf-8"))


def projected_shapes(path):
    data = read(path)
    crs = data.get("crs", {}).get("properties", {}).get("name", "EPSG:4326")
    to_atlas = Transformer.from_crs(crs, PROJECTION, always_xy=True)
    for feature in data["features"]:
        if feature["geometry"] is not None:
            geom = make_valid(transform(shape(feature["geometry"]), to_atlas.transform,
                                        interleaved=False))
            if not geom.is_empty:
                yield geom, feature["properties"]


def encode(rows):
    """Write non-empty contiguous runs as [x, y, count, profile]."""
    for y, row in enumerate(rows):
        cuts = np.flatnonzero(np.r_[True, row[1:] != row[:-1], True])
        for start, end in zip(cuts, cuts[1:]):
            if row[start]:
                yield [int(start), y, int(end - start), int(row[start])]


def population_grid(path):
    # JRC overview pixels contain average persons per 1 km² source pixel.
    with np.load(path) as source:
        transform = Affine(*source["affine"][:6])
        data = source["data"]
        nodata = source["nodata"]
    to_mollweide = Transformer.from_crs(PROJECTION, "ESRI:54009", always_xy=True)
    points_x, points_y = np.meshgrid(
        X + (np.arange(WIDTH) + 0.5) * STEP,
        -Y - (np.arange(HEIGHT) + 0.5) * STEP,
    )
    sx, sy = to_mollweide.transform(points_x, points_y)
    rr, cc = rowcol(transform, sx.ravel(), sy.ravel())
    rr = np.asarray(rr, dtype="int32").reshape(sx.shape)
    cc = np.asarray(cc, dtype="int32").reshape(sx.shape)
    values = data[np.clip(rr, 0, data.shape[0] - 1), np.clip(cc, 0, data.shape[1] - 1)]
    values = np.where(np.isfinite(values) & (values != nodata), values, 0)
    # Store relative density bands. Zero is unpopulated; 7 is urban.
    return np.searchsorted([0.01, 0.1, 0.5, 2, 10, 40, 200], values, side="right")


def forest_cover_bands(fine_cells):
    land = (fine_cells > 0) & (fine_cells != 18)
    count = land.sum(axis=(1, 3))
    trees = ((fine_cells > 0) & (fine_cells <= 6)).sum(axis=(1, 3))
    return np.where(count > 0, 1 + (trees * 5 + count // 2) // np.maximum(count, 1), 0)


def landcover_grid(source):
    # Count forest in sixteen stratified samples of each atlas cell. Class
    # numbers 1–6 are the NALCMS forest and taiga classes. Zero is no coverage.
    finer = np.zeros((HEIGHT * 4, WIDTH * 4), dtype="uint8")
    for suffix in ("west", "east", "aleutian"):
        with open_raster(source / f"landcover-{suffix}.tif") as dataset:
            reproject(dataset.read(1), finer, src_transform=dataset.transform,
                      src_crs=dataset.crs, src_nodata=0, dst_nodata=0,
                      dst_transform=AFFINE * Affine.scale(0.25), dst_crs=PROJECTION.to_wkt(),
                      init_dest_nodata=False, resampling=Resampling.nearest)
    # 0 indicates no sampling coverage; 1 through 6 encode 0–100% forest cover.
    return forest_cover_bands(finer.reshape(HEIGHT, 4, WIDTH, 4))


def build(source, definitions):
    ecoregions = list(projected_shapes(source / "eco2-main.geojson"))
    codes = sorted({props["LEVEL2"] for _, props in ecoregions})
    if not set(codes).issubset(definitions["regions"]):
        raise ValueError("Missing vegetation profiles for " +
                         ", ".join(sorted(set(codes) - definitions["regions"].keys())))
    regions = rasterize(((geom, codes.index(props["LEVEL2"]) + 1)
                         for geom, props in ecoregions),
                        out_shape=(HEIGHT, WIDTH), transform=AFFINE, dtype="uint8")

    species = definitions["species"]
    if len(species) > 57:
        raise ValueError("The generated plant range mask supports at most 57 species")
    sonoran = rasterize(((geom, 1) for geom, _ in projected_shapes(Path(__file__).with_name("north_america_sonoran_range.geojson"))),
                        out_shape=regions.shape, transform=AFFINE, dtype="uint8")
    mask = regions.astype("uint64")
    for i, plant in enumerate(species):
        if plant["range"]:
            geometries = ((geom, 1) for geom, _ in projected_shapes(
                source / (plant["range"] + ".geojson")))
            presence = rasterize(geometries, out_shape=regions.shape,
                                 transform=AFFINE, dtype="uint8")
            mask |= presence.astype("uint64") << np.uint64(i + 1 + 5)
    area = regions != 0
    mask[~area] = 0
    # A range mask bit after all species distinguishes the Sonoran warm desert.
    mask |= ((regions == codes.index("10.2") + 1) & (sonoran != 0)).astype("uint64") << np.uint64(len(species) + 6)
    density = population_grid(source / "population.npz")
    density[~area] = 0
    cover = landcover_grid(source)
    cover[~area] = 0
    patterns, index = np.unique(mask, return_inverse=True)
    profiles = [None]
    profile_index = {}
    remap = np.zeros(len(patterns), dtype=np.int32)
    for pattern_id, raw in enumerate(patterns[1:], 1):
        bits = int(raw)
        code = codes[(bits & 63) - 1]
        biome = "sonoran_desert" if bits & (1 << (len(species) + 6)) else definitions["regions"][code]
        included = []
        for i, plant in enumerate(species):
            if biome in plant["biomes"] and (
                not plant["range"] or (bits & (1 << (i + 6)))
            ):
                included.append(i)
        key = (code, biome, tuple(included))
        if key not in profile_index:
            profile_index[key] = len(profiles)
            profiles.append([code, biome, included])
        remap[pattern_id] = profile_index[key]
    return {
        "version": 1,
        "grid": [X, Y, STEP, WIDTH, HEIGHT],
        "profiles": profiles,
        "runs": list(encode(remap[index].reshape(regions.shape))),
        "population": list(encode(density)),
        "forest_cover": list(encode(cover)),
    }


def render(data):
    lines = ["{"]
    for key, value in data.items():
        end = "," if key != "forest_cover" else ""
        if key in {"runs", "population", "forest_cover"}:
            lines.append(f'  "{key}": [')
            lines.extend("    " + ",".join(json.dumps(run, separators=(",", ":"))
                                            for run in value[i:i+12])
                         + ("," if i + 12 < len(value) else "")
                         for i in range(0, len(value), 12))
            lines.append("  ]" + end)
        else:
            lines.append(f'  "{key}": ' + json.dumps(value, separators=(",", ":")) + ",")
    return "\n".join(lines + ["}", ""])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path)
    parser.add_argument("definitions", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    expected = render(build(args.source, read(args.definitions)))
    if args.check:
        if args.output.read_text(encoding="utf-8") != expected:
            parser.exit(1, "North America ecology atlas is out of date\n")
    else:
        args.output.write_text(expected, encoding="utf-8", newline="\n")


if __name__ == "__main__":
    main()