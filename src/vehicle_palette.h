#pragma once

// Vehicle color palettes (ported from CBN). A vehicle prototype may reference a
// palette by id via its "color_palette" JSON field; when the vehicle spawns,
// pick_colors() rolls one color per group and they are applied to the matching
// parts (see vehicle::apply_color_palette and vehicle_prototype::color_match).
// Palettes are defined in data/json/vehicle_palette.json.

#include <map>
#include <string>
#include <vector>

#include "hsv_color.h"
#include "json.h"
#include "type_id.h"
#include "weighted_list.h"

/**
 * Random vehicle color palette. Ported from Cataclysm: Bright Nights.
 *
 * Each palette maps fuzzy part-id prefixes (e.g. "door", "windshield") to a
 * weighted color group. When a vehicle spawns, one color per group is rolled
 * (see @ref pick_colors) and applied to the matching parts.
 */
class VehiclePalette
{
    public:
        VehiclePalette() = default;

        static void load( const JsonObject &jo );
        static void check();
        static void reset();

        /** Returns the color-group index a part id belongs to, or -1 if none matches. */
        int fuzzy_to_index( const vpart_id &id ) const;

        /** Rolls one weighted-random color per color group. */
        std::vector<RGBColor> pick_colors() const;

    private:
        vpalette_id id;
        std::vector<weighted_int_list<std::string>> colors;
        std::map<std::string, int> fuzzy_color_match;
};
