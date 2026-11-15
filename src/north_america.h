#pragma once
#ifndef CATA_SRC_NORTH_AMERICA_H
#define CATA_SRC_NORTH_AMERICA_H

#include <string>
#include <string_view>
#include <vector>

#include "coordinates.h"
#include "regional_climate.h"
#include "type_id.h"

namespace north_america
{

enum class terrain { land, ocean, lake, river };

struct place {
    std::string country;
    std::string region;
    std::string name;
    point_abs_omt position;
    int population;
};

bool available();
bool active();
bool offer_starting_city();
const std::vector<place> &cities();
const std::vector<size_t> &cities_in( point_abs_om overmap );
bool suitable_for_highway_intersection( point_abs_om overmap );
bool military_base_region( point_abs_om overmap, unsigned seed );
regional_climate::coordinates location( point_abs_ms position );
// Empty outside the covered land. Coordinates use the same projection as the terrain atlas.
std::string_view jurisdiction_at( point_abs_ms position );
std::string chart_discovery_key( std::string_view jurisdiction );
// New ambient spawns only. Existing monsters and mission targets keep their saved types.
mtype_id regional_monster( const mtype_id &type, point_abs_ms position );

struct regional_loot_table;

// Supplies the origin for nested loot groups without changing non-geographic item APIs.
class scoped_regional_loot
{
    public:
        explicit scoped_regional_loot( point_abs_ms position );
        ~scoped_regional_loot();
        scoped_regional_loot( const scoped_regional_loot & ) = delete;
        scoped_regional_loot &operator=( const scoped_regional_loot & ) = delete;

    private:
        const regional_loot_table *previous;
};

const item_group_id &regional_item_group( const item_group_id &base );
const std::string &civic_flag_variant();
// The caller can include a border to make shoreline classification independent of generation order.
std::vector<terrain> raster( point_abs_omt origin, int width, int height, int stride = 1,
                             bool chart = false );

} // namespace north_america

#endif // CATA_SRC_NORTH_AMERICA_H
