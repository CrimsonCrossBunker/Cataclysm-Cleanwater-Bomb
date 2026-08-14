#include "finite_water.h"

#include <algorithm>
#include <cstdlib>
#include <deque>
#include <map>
#include <set>
#include <tuple>
#include <vector>

#include "calendar.h"
#include "item.h"
#include "map.h"
#include "mapbuffer.h"
#include "mapdata.h"
#include "messages.h"
#include "overmap.h"
#include "overmapbuffer.h"
#include "submap.h"
#include "translations.h"
#include "weather.h"

namespace finite_water
{

namespace
{

const ter_str_id ter_pond_water_sh( "t_pond_water_sh" );
const ter_str_id ter_pond_water_dp( "t_pond_water_dp" );
const ter_str_id ter_pond_water_dp_low( "t_pond_water_dp_low" );
const ter_str_id ter_pond_bottom_dry_sh( "t_pond_bottom_dry_sh" );
const ter_str_id ter_pond_bottom_dry_dp( "t_pond_bottom_dry_dp" );
const ter_str_id ter_salt_pond_water_sh( "t_salt_pond_water_sh" );
const ter_str_id ter_salt_pond_water_dp( "t_salt_pond_water_dp" );
const ter_str_id ter_salt_pond_water_dp_low( "t_salt_pond_water_dp_low" );
const ter_str_id ter_salt_pond_bottom_dry_sh( "t_salt_pond_bottom_dry_sh" );
const ter_str_id ter_salt_pond_bottom_dry_dp( "t_salt_pond_bottom_dry_dp" );
const ter_str_id ter_pool_water( "t_pool_water" );
const ter_str_id ter_pool_water_low( "t_pool_water_low" );
const ter_str_id ter_pool_water_shallow( "t_pool_water_shallow" );
const ter_str_id ter_pool_water_outdoors( "t_pool_water_outdoors" );
const ter_str_id ter_pool_water_outdoors_low( "t_pool_water_outdoors_low" );
const ter_str_id ter_pool_water_shallow_outdoors( "t_pool_water_shallow_outdoors" );
const ter_str_id ter_pool_bottom_dry( "t_pool_bottom_dry" );
const ter_str_id ter_pool_bottom_dry_shallow( "t_pool_bottom_dry_shallow" );
const ter_str_id ter_pool_bottom_dry_outdoors( "t_pool_bottom_dry_outdoors" );
const ter_str_id ter_pool_bottom_dry_shallow_outdoors( "t_pool_bottom_dry_shallow_outdoors" );
const ter_str_id ter_channel_dry( "t_channel_dry" );
const ter_str_id ter_channel_water_fresh( "t_channel_water_fresh" );
const ter_str_id ter_channel_water_salt( "t_channel_water_salt" );
const ter_str_id ter_channel_flowing_fresh( "t_channel_flowing_fresh" );
const ter_str_id ter_channel_flowing_salt( "t_channel_flowing_salt" );

const ter_str_id ter_water_sh( "t_water_sh" );
const ter_str_id ter_water_sh_underground( "t_water_sh_underground" );
const ter_str_id ter_water_dp( "t_water_dp" );
const ter_str_id ter_water_dp_underground( "t_water_dp_underground" );
const ter_str_id ter_water_moving_sh( "t_water_moving_sh" );
const ter_str_id ter_water_moving_sh_underground( "t_water_moving_sh_underground" );
const ter_str_id ter_water_moving_dp( "t_water_moving_dp" );
const ter_str_id ter_water_moving_dp_underground( "t_water_moving_dp_underground" );
const ter_str_id ter_swater_sh( "t_swater_sh" );
const ter_str_id ter_swater_sh_underground( "t_swater_sh_underground" );
const ter_str_id ter_swater_dp( "t_swater_dp" );
const ter_str_id ter_swater_dp_underground( "t_swater_dp_underground" );
const ter_str_id ter_swater_surf( "t_swater_surf" );
const ter_str_id ter_water_murky( "t_water_murky" );
const ter_str_id ter_water_sh_murky_underground( "t_water_sh_murky_underground" );
const ter_str_id ter_sewage( "t_sewage" );
const ter_str_id ter_water_hot( "t_water_hot" );
const ter_str_id ter_water_sh_flood( "t_water_sh_flood" );
const ter_str_id ter_nl_water_pool( "t_nl_water_pool" );
const ter_str_id ter_nl_water_pool_low( "t_nl_water_pool_low" );
const ter_str_id ter_interstice_mutagen_sh( "t_interstice_mutagen_sh" );
const ter_str_id ter_interstice_mutagen_pool( "t_interstice_mutagen_pool" );
const ter_str_id ter_murky_bottom_dry( "t_murky_bottom_dry" );
const ter_str_id ter_murky_bottom_dry_underground( "t_murky_bottom_dry_underground" );
const ter_str_id ter_sewage_bottom_dry( "t_sewage_bottom_dry" );
const ter_str_id ter_hot_spring_bottom_dry( "t_hot_spring_bottom_dry" );
const ter_str_id ter_flood_bottom_dry( "t_flood_bottom_dry" );
const ter_str_id ter_nl_pool_bottom_dry( "t_nl_pool_bottom_dry" );
const ter_str_id ter_interstice_bottom_dry_sh( "t_interstice_bottom_dry_sh" );
const ter_str_id ter_interstice_pool_bottom_dry( "t_interstice_pool_bottom_dry" );
const ter_str_id ter_water_pool_legacy( "t_water_pool" );
const ter_str_id ter_water_pool_shallow_legacy( "t_water_pool_shallow" );
const ter_str_id ter_water_pool_outdoors_legacy( "t_water_pool_outdoors" );
const ter_str_id ter_water_pool_shallow_outdoors_legacy( "t_water_pool_shallow_outdoors" );

const itype_id itype_water( "water" );
const itype_id itype_water_clean( "water_clean" );
const itype_id itype_salt_water( "salt_water" );
const itype_id itype_water_murky( "water_murky" );
const itype_id itype_water_sewage( "water_sewage" );
const itype_id itype_mutagen_interstice( "mutagen_interstice" );

enum class tile_water_kind {
    not_water,
    natural_fresh,
    natural_salt,
    natural_other,
    channel_fresh,
    channel_salt,
    channel_dry,
    pond_water,
    pond_dry,
    salt_pond_water,
    salt_pond_dry,
    other_water,
    other_dry,
};

struct tile_location {
    submap *sm = nullptr;
    point_sm_ms local;
    tripoint_bub_ms bub;
    bool in_bubble = false;
};

bool locate_tile( map &here, const tripoint_abs_ms &p, tile_location &loc )
{
    loc.bub = here.get_bub( p );
    tripoint_abs_sm abs_sm;
    point_sm_ms local;
    std::tie( abs_sm, local ) = project_remain<coords::sm>( p );
    loc.local = local;
    loc.in_bubble = here.inbounds( loc.bub );
    loc.sm = MAPBUFFER.lookup_submap( abs_sm );
    return loc.sm != nullptr;
}

ter_id terrain_at( map &here, const tripoint_abs_ms &p )
{
    tile_location loc;
    if( !locate_tile( here, p, loc ) ) {
        return ter_id();
    }
    return loc.sm->get_ter( loc.local );
}

bool is_pond_water_ter( const ter_id &tid )
{
    return tid == ter_pond_water_sh || tid == ter_pond_water_dp || tid == ter_pond_water_dp_low ||
           tid == ter_pool_water || tid == ter_pool_water_low || tid == ter_pool_water_shallow ||
           tid == ter_pool_water_outdoors || tid == ter_pool_water_outdoors_low ||
           tid == ter_pool_water_shallow_outdoors;
}

bool is_salt_pond_water_ter( const ter_id &tid )
{
    return tid == ter_salt_pond_water_sh || tid == ter_salt_pond_water_dp ||
           tid == ter_salt_pond_water_dp_low;
}

bool is_salt_pond_dry_ter( const ter_id &tid )
{
    return tid == ter_salt_pond_bottom_dry_sh || tid == ter_salt_pond_bottom_dry_dp;
}

bool is_other_water_ter( const ter_id &tid )
{
    return tid == ter_water_murky || tid == ter_water_sh_murky_underground ||
           tid == ter_sewage || tid == ter_water_hot || tid == ter_water_sh_flood ||
           tid == ter_nl_water_pool || tid == ter_nl_water_pool_low ||
           tid == ter_interstice_mutagen_sh ||
           tid == ter_interstice_mutagen_pool;
}

bool is_other_dry_ter( const ter_id &tid )
{
    return tid == ter_murky_bottom_dry || tid == ter_murky_bottom_dry_underground ||
           tid == ter_sewage_bottom_dry || tid == ter_hot_spring_bottom_dry ||
           tid == ter_flood_bottom_dry || tid == ter_nl_pool_bottom_dry ||
           tid == ter_interstice_bottom_dry_sh || tid == ter_interstice_pool_bottom_dry;
}

ter_str_id wet_terrain_for_other_dry( const ter_id &tid )
{
    if( tid == ter_murky_bottom_dry_underground ) {
        return ter_water_sh_murky_underground;
    }
    if( tid == ter_sewage_bottom_dry ) {
        return ter_sewage;
    }
    if( tid == ter_hot_spring_bottom_dry ) {
        return ter_water_hot;
    }
    if( tid == ter_flood_bottom_dry ) {
        return ter_water_sh_flood;
    }
    if( tid == ter_nl_pool_bottom_dry ) {
        return ter_nl_water_pool;
    }
    if( tid == ter_interstice_bottom_dry_sh ) {
        return ter_interstice_mutagen_sh;
    }
    if( tid == ter_interstice_pool_bottom_dry ) {
        return ter_interstice_mutagen_pool;
    }
    return ter_water_murky;
}

itype_id canonical_liquid_id( const itype_id &liquid )
{
    return liquid == itype_water_clean ? itype_water : liquid;
}

itype_id liquid_for_other_dry( const ter_id &tid )
{
    if( tid == ter_sewage_bottom_dry ) {
        return itype_water_sewage;
    }
    if( tid == ter_nl_pool_bottom_dry ) {
        return itype_salt_water;
    }
    if( tid == ter_interstice_bottom_dry_sh || tid == ter_interstice_pool_bottom_dry ) {
        return itype_mutagen_interstice;
    }
    return tid == ter_murky_bottom_dry || tid == ter_murky_bottom_dry_underground ||
           tid == ter_hot_spring_bottom_dry ? itype_water_murky : itype_water;
}

bool is_legacy_pool_ter( const ter_id &tid )
{
    return tid == ter_water_pool_legacy || tid == ter_water_pool_shallow_legacy ||
           tid == ter_water_pool_outdoors_legacy ||
           tid == ter_water_pool_shallow_outdoors_legacy;
}

ter_str_id finite_terrain_for_legacy( const ter_id &tid )
{
    if( tid == ter_swater_dp || tid == ter_swater_dp_underground ) {
        return ter_salt_pond_water_dp;
    }
    if( tid == ter_swater_sh || tid == ter_swater_sh_underground || tid == ter_swater_surf ) {
        return ter_salt_pond_water_sh;
    }
    if( tid == ter_water_dp || tid == ter_water_dp_underground ||
        tid == ter_water_moving_dp || tid == ter_water_moving_dp_underground ) {
        return ter_pond_water_dp;
    }
    if( tid == ter_water_pool_legacy ) {
        return ter_pool_water;
    }
    if( tid == ter_water_pool_shallow_legacy ) {
        return ter_pool_water_shallow;
    }
    if( tid == ter_water_pool_outdoors_legacy ) {
        return ter_pool_water_outdoors;
    }
    if( tid == ter_water_pool_shallow_outdoors_legacy ) {
        return ter_pool_water_shallow_outdoors;
    }
    if( tid == ter_water_moving_sh || tid == ter_water_moving_sh_underground ) {
        return ter_channel_water_fresh;
    }
    return ter_pond_water_sh;
}

bool is_pond_dry_ter( const ter_id &tid )
{
    return tid == ter_pond_bottom_dry_sh || tid == ter_pond_bottom_dry_dp ||
           tid == ter_pool_bottom_dry || tid == ter_pool_bottom_dry_shallow ||
           tid == ter_pool_bottom_dry_outdoors || tid == ter_pool_bottom_dry_shallow_outdoors;
}

bool is_pond_or_pool_ter( const ter_id &tid )
{
    return is_pond_water_ter( tid ) || is_pond_dry_ter( tid ) ||
           is_salt_pond_water_ter( tid ) || is_salt_pond_dry_ter( tid );
}

bool is_fresh_channel_ter( const ter_id &tid )
{
    return tid == ter_channel_water_fresh || tid == ter_channel_flowing_fresh;
}

bool is_salt_channel_ter( const ter_id &tid )
{
    return tid == ter_channel_water_salt || tid == ter_channel_flowing_salt;
}

bool is_channel_ter( const ter_id &tid )
{
    return tid == ter_channel_dry || is_fresh_channel_ter( tid ) ||
           is_salt_channel_ter( tid );
}

ter_str_id wet_terrain_for_dry( const ter_id &tid )
{
    if( tid == ter_pond_bottom_dry_dp ) {
        return ter_pond_water_dp;
    }
    if( tid == ter_pool_bottom_dry ) {
        return ter_pool_water;
    }
    if( tid == ter_pool_bottom_dry_shallow ) {
        return ter_pool_water_shallow;
    }
    if( tid == ter_pool_bottom_dry_outdoors ) {
        return ter_pool_water_outdoors;
    }
    if( tid == ter_pool_bottom_dry_shallow_outdoors ) {
        return ter_pool_water_shallow_outdoors;
    }
    return ter_pond_water_sh;
}

ter_str_id wet_terrain_for_salt_dry( const ter_id &tid )
{
    return tid == ter_salt_pond_bottom_dry_dp ? ter_salt_pond_water_dp :
           ter_salt_pond_water_sh;
}

ter_str_id terrain_for_water_level( const ter_id &tid, int charges )
{
    const bool low = charges <= 400;
    if( tid == ter_pond_water_dp || tid == ter_pond_water_dp_low ) {
        return low ? ter_pond_water_dp_low : ter_pond_water_dp;
    }
    if( tid == ter_pool_water || tid == ter_pool_water_low ) {
        return low ? ter_pool_water_low : ter_pool_water;
    }
    if( tid == ter_pool_water_outdoors || tid == ter_pool_water_outdoors_low ) {
        return low ? ter_pool_water_outdoors_low : ter_pool_water_outdoors;
    }
    if( tid == ter_salt_pond_water_dp || tid == ter_salt_pond_water_dp_low ) {
        return low ? ter_salt_pond_water_dp_low : ter_salt_pond_water_dp;
    }
    if( tid == ter_nl_water_pool || tid == ter_nl_water_pool_low ) {
        return low ? ter_nl_water_pool_low : ter_nl_water_pool;
    }
    return tid.id();
}

bool is_core_fresh_water( const ter_id &tid )
{
    return tid == ter_water_sh || tid == ter_water_sh_underground ||
           tid == ter_water_dp || tid == ter_water_dp_underground ||
           tid == ter_water_moving_sh || tid == ter_water_moving_sh_underground ||
           tid == ter_water_moving_dp || tid == ter_water_moving_dp_underground;
}

bool is_core_salt_water( const ter_id &tid )
{
    return tid == ter_swater_sh || tid == ter_swater_sh_underground ||
           tid == ter_swater_dp || tid == ter_swater_dp_underground ||
           tid == ter_swater_surf;
}

bool is_legacy_closed_water( const ter_id &tid )
{
    return tid == ter_water_sh || tid == ter_water_sh_underground ||
           tid == ter_water_dp || tid == ter_water_dp_underground ||
           tid == ter_water_moving_sh || tid == ter_water_moving_sh_underground ||
           tid == ter_water_moving_dp || tid == ter_water_moving_dp_underground ||
           is_legacy_pool_ter( tid ) || is_core_salt_water( tid );
}

bool set_terrain_at( map &here, const tripoint_abs_ms &p, const ter_id &tid );

ter_id migrate_legacy_water( map &here, const tripoint_abs_ms &p, const ter_id &tid )
{
    if( !is_legacy_closed_water( tid ) ) {
        return tid;
    }
    const oter_id omt = overmap_buffer.ter( project_to<coords::omt>( p ) );
    if( is_core_fresh_water( tid ) &&
        ( is_lake_or_river( omt ) || omt->has_flag( oter_flags::stream ) ) ) {
        return tid;
    }
    if( is_core_salt_water( tid ) && is_ocean( omt ) ) {
        return tid;
    }

    const ter_id migrated = finite_terrain_for_legacy( tid ).id();
    if( set_terrain_at( here, p, migrated ) ) {
        return migrated;
    }
    return tid;
}

tile_water_kind classify_uncached( map &here, const tripoint_abs_ms &p )
{
    ter_id tid = terrain_at( here, p );
    if( tid == ter_id() ) {
        return tile_water_kind::not_water;
    }
    tid = migrate_legacy_water( here, p, tid );
    if( tid == ter_channel_dry ) {
        return tile_water_kind::channel_dry;
    }
    if( is_fresh_channel_ter( tid ) ) {
        return tile_water_kind::channel_fresh;
    }
    if( is_salt_channel_ter( tid ) ) {
        return tile_water_kind::channel_salt;
    }
    if( is_pond_water_ter( tid ) ) {
        return tile_water_kind::pond_water;
    }
    if( is_pond_dry_ter( tid ) ) {
        return tile_water_kind::pond_dry;
    }
    if( is_salt_pond_water_ter( tid ) ) {
        return tile_water_kind::salt_pond_water;
    }
    if( is_salt_pond_dry_ter( tid ) ) {
        return tile_water_kind::salt_pond_dry;
    }
    if( is_other_water_ter( tid ) ) {
        return tile_water_kind::other_water;
    }
    if( is_other_dry_ter( tid ) ) {
        return tile_water_kind::other_dry;
    }

    // JSON-defined finite water surfaces using the same hidden-state
    // contract participate without requiring their terrain id to be added to
    // this file.  Built-in dry bottoms still have explicit reverse mappings
    // so they can be refilled after depletion.
    const ter_t &ter = tid.obj();
    const bool hidden_finite = !ter.liquid_source_item_id.is_null() &&
                               ter.liquid_source_count != std::make_pair( 0, 0 ) &&
                               !ter.dries_to.is_empty() && !ter.dries_to.is_null();
    if( hidden_finite && ( ter.liquid_source_item_id == itype_water ||
                           ter.liquid_source_item_id == itype_water_clean ) ) {
        return tile_water_kind::pond_water;
    }
    if( hidden_finite && ter.liquid_source_item_id == itype_id( "salt_water" ) ) {
        return tile_water_kind::salt_pond_water;
    }
    if( hidden_finite ) {
        return tile_water_kind::other_water;
    }

    const oter_id omt = overmap_buffer.ter( project_to<coords::omt>( p ) );
    if( is_core_fresh_water( tid ) &&
        ( is_lake_or_river( omt ) || omt->has_flag( oter_flags::stream ) ) ) {
        return tile_water_kind::natural_fresh;
    }
    if( is_core_salt_water( tid ) && is_ocean( omt ) ) {
        return tile_water_kind::natural_salt;
    }
    if( !ter.liquid_source_item_id.is_null() &&
        ter.liquid_source_count == std::make_pair( 0, 0 ) ) {
        return tile_water_kind::natural_other;
    }
    return tile_water_kind::not_water;
}

class tile_classifier
{
    public:
        explicit tile_classifier( map &here ) : here( here ) {}

        tile_water_kind get( const tripoint_abs_ms &p ) {
            const auto found = cache.find( p );
            if( found != cache.end() ) {
                return found->second;
            }
            return cache.emplace( p, classify_uncached( here, p ) ).first->second;
        }

    private:
        map &here;
        std::map<tripoint_abs_ms, tile_water_kind> cache;
};

int tile_water_capacity( const ter_t &ter )
{
    return ter.liquid_source_count == std::make_pair( 0, 0 ) ? 0 :
           ter.liquid_source_count.second;
}

bool uses_hidden_finite_liquid( const ter_t &ter )
{
    return !ter.liquid_source_item_id.is_null() &&
           ter.liquid_source_count != std::make_pair( 0, 0 ) &&
           !ter.dries_to.is_empty() && !ter.dries_to.is_null();
}

int tile_water_charges( map &here, const tripoint_abs_ms &p )
{
    tile_location loc;
    if( !locate_tile( here, p, loc ) ) {
        return 0;
    }
    const ter_t &ter = loc.sm->get_ter( loc.local ).obj();
    if( uses_hidden_finite_liquid( ter ) ) {
        if( loc.sm->has_finite_liquid( loc.local ) ) {
            return loc.sm->get_finite_liquid( loc.local );
        }

        // Lazy migration covers already-loaded legacy submaps as well as old
        // saves whose water item was missing.  Once absorbed, the liquid is no
        // longer part of the visible/pickable ground stack.
        int legacy_total = 0;
        cata::colony<item> &items = loc.sm->get_items( loc.local );
        for( auto it = items.begin(); it != items.end(); ) {
            if( it->typeId() == ter.liquid_source_item_id ) {
                legacy_total += std::max( 0, it->charges );
                it = items.erase( it );
            } else {
                ++it;
            }
        }
        const int stored = legacy_total > 0 ?
                           std::min( legacy_total, tile_water_capacity( ter ) ) :
                           tile_water_capacity( ter );
        loc.sm->set_finite_liquid( loc.local, stored );
        return stored;
    }
    int total = 0;
    for( const item &it : loc.sm->get_items( loc.local ) ) {
        if( it.typeId() == ter.liquid_source_item_id && it.charges > 0 ) {
            total += it.charges;
        }
    }
    return total;
}

bool set_terrain_at( map &here, const tripoint_abs_ms &p, const ter_id &tid )
{
    tile_location loc;
    if( !locate_tile( here, p, loc ) ) {
        return false;
    }
    if( loc.sm->get_ter( loc.local ) == tid ) {
        return true;
    }
    if( loc.in_bubble ) {
        here.ter_set( loc.bub, tid );
        return here.ter( loc.bub ) == tid;
    }
    loc.sm->player_adjusted_map = true;
    loc.sm->set_ter( loc.local, tid );
    loc.sm->clear_terrain_growth( loc.local );
    loc.sm->set_map_damage( loc.local, 0 );
    loc.sm->clear_original_ter( loc.local );
    return true;
}

bool set_water_charges( map &here, const tripoint_abs_ms &p, int charges,
                        const itype_id &liquid_id )
{
    tile_location loc;
    if( !locate_tile( here, p, loc ) ) {
        return false;
    }
    ter_id tid = loc.sm->get_ter( loc.local );
    if( tid == ter_channel_dry ) {
        if( charges <= 0 ) {
            loc.sm->set_finite_liquid( loc.local, 0 );
            return true;
        }
        const ter_id wet_channel = liquid_id == itype_salt_water ? ter_channel_water_salt.id() :
                                   ter_channel_water_fresh.id();
        if( !set_terrain_at( here, p, wet_channel ) || !locate_tile( here, p, loc ) ) {
            return false;
        }
        tid = loc.sm->get_ter( loc.local );
    }
    if( is_pond_dry_ter( tid ) && charges <= 0 ) {
        loc.sm->set_finite_liquid( loc.local, 0 );
        return true;
    }
    if( is_pond_dry_ter( tid ) && charges > 0 ) {
        if( !set_terrain_at( here, p, wet_terrain_for_dry( tid ) ) ||
            !locate_tile( here, p, loc ) ) {
            return false;
        }
        tid = loc.sm->get_ter( loc.local );
    }
    if( is_salt_pond_dry_ter( tid ) && charges <= 0 ) {
        loc.sm->set_finite_liquid( loc.local, 0 );
        return true;
    }
    if( is_salt_pond_dry_ter( tid ) && charges > 0 ) {
        if( !set_terrain_at( here, p, wet_terrain_for_salt_dry( tid ) ) ||
            !locate_tile( here, p, loc ) ) {
            return false;
        }
        tid = loc.sm->get_ter( loc.local );
    }
    if( is_other_dry_ter( tid ) && charges <= 0 ) {
        loc.sm->set_finite_liquid( loc.local, 0 );
        return true;
    }
    if( is_other_dry_ter( tid ) && charges > 0 ) {
        if( canonical_liquid_id( liquid_for_other_dry( tid ) ) !=
            canonical_liquid_id( liquid_id ) ||
            !set_terrain_at( here, p, wet_terrain_for_other_dry( tid ) ) ||
            !locate_tile( here, p, loc ) ) {
            return false;
        }
        tid = loc.sm->get_ter( loc.local );
    }

    const ter_t &ter = tid.obj();
    if( ter.liquid_source_item_id.is_null() ||
        ter.liquid_source_count == std::make_pair( 0, 0 ) ||
        canonical_liquid_id( ter.liquid_source_item_id ) != canonical_liquid_id( liquid_id ) ) {
        return false;
    }
    if( uses_hidden_finite_liquid( ter ) ) {
        loc.sm->player_adjusted_map = true;
        loc.sm->set_finite_liquid( loc.local, std::max( 0, charges ) );
        if( charges > 0 ) {
            const ter_id level_terrain = terrain_for_water_level( tid, charges ).id();
            return level_terrain == tid || set_terrain_at( here, p, level_terrain );
        }
        if( !ter.dries_to.is_empty() && !ter.dries_to.is_null() ) {
            return set_terrain_at( here, p, ter.dries_to );
        }
        return true;
    }
    cata::colony<item> &items = loc.sm->get_items( loc.local );
    for( auto it = items.begin(); it != items.end(); ) {
        if( it->typeId() == ter.liquid_source_item_id ) {
            it = items.erase( it );
        } else {
            ++it;
        }
    }
    if( charges > 0 ) {
        item water( ter.liquid_source_item_id, calendar::start_of_cataclysm );
        water.charges = charges;
        items.insert( std::move( water ) );
        return true;
    }
    if( !ter.dries_to.is_empty() && !ter.dries_to.is_null() ) {
        return set_terrain_at( here, p, ter.dries_to );
    }
    return true;
}

struct connection_state {
    bool saw_fresh = false;
    bool saw_salt = false;
    bool fresh_found = false;
    bool salt_found = false;
};

bool is_waterway_tile( tile_water_kind kind )
{
    return kind == tile_water_kind::channel_fresh || kind == tile_water_kind::channel_salt ||
           kind == tile_water_kind::channel_dry || kind == tile_water_kind::pond_water ||
           kind == tile_water_kind::pond_dry || kind == tile_water_kind::salt_pond_water ||
           kind == tile_water_kind::salt_pond_dry;
}

void record_kind( connection_state &state, tile_water_kind kind )
{
    switch( kind ) {
        case tile_water_kind::channel_fresh:
            state.saw_fresh = true;
            break;
        case tile_water_kind::channel_salt:
            state.saw_salt = true;
            break;
        case tile_water_kind::pond_water:
        case tile_water_kind::pond_dry:
            state.saw_fresh = true;
            break;
        case tile_water_kind::salt_pond_water:
        case tile_water_kind::salt_pond_dry:
            state.saw_salt = true;
            break;
        case tile_water_kind::natural_fresh:
            state.fresh_found = true;
            break;
        case tile_water_kind::natural_salt:
            state.salt_found = true;
            break;
        case tile_water_kind::not_water:
        case tile_water_kind::natural_other:
        case tile_water_kind::channel_dry:
        case tile_water_kind::other_water:
        case tile_water_kind::other_dry:
            break;
    }
}

water_source_kind finish_connection( const connection_state &state )
{
    const bool any_fresh = state.fresh_found || state.saw_fresh;
    const bool any_salt = state.salt_found || state.saw_salt;
    if( any_fresh && any_salt ) {
        return water_source_kind::conflict;
    }
    if( state.fresh_found ) {
        return water_source_kind::fresh_infinite;
    }
    if( state.salt_found ) {
        return water_source_kind::salt_infinite;
    }
    if( state.saw_fresh ) {
        return water_source_kind::fresh_finite;
    }
    if( state.saw_salt ) {
        return water_source_kind::salt_finite;
    }
    return water_source_kind::none;
}

itype_id finite_liquid_id_at( map &here, const tripoint_abs_ms &p, tile_water_kind kind )
{
    switch( kind ) {
        case tile_water_kind::channel_fresh:
        case tile_water_kind::pond_water:
        case tile_water_kind::pond_dry:
            return itype_water;
        case tile_water_kind::channel_salt:
        case tile_water_kind::salt_pond_water:
        case tile_water_kind::salt_pond_dry:
            return itype_salt_water;
        case tile_water_kind::other_water:
            return canonical_liquid_id( terrain_at( here, p )->liquid_source_item_id );
        case tile_water_kind::other_dry:
            return canonical_liquid_id( liquid_for_other_dry( terrain_at( here, p ) ) );
        case tile_water_kind::not_water:
        case tile_water_kind::natural_fresh:
        case tile_water_kind::natural_salt:
        case tile_water_kind::natural_other:
        case tile_water_kind::channel_dry:
            return itype_id::NULL_ID();
    }
    return itype_id::NULL_ID();
}

bool belongs_to_finite_body( map &here, const tripoint_abs_ms &p, tile_water_kind kind,
                             const itype_id &liquid_id )
{
    const itype_id canonical = canonical_liquid_id( liquid_id );
    if( kind == tile_water_kind::channel_dry ) {
        return canonical == itype_water || canonical == itype_salt_water;
    }
    return !canonical.is_null() && finite_liquid_id_at( here, p, kind ) == canonical;
}

std::vector<tripoint_abs_ms> collect_finite_tiles( const tripoint_abs_ms &p, bool connect_target,
        const itype_id &liquid_id )
{
    map &here = get_map();
    tile_classifier tiles( here );
    std::vector<tripoint_abs_ms> result;
    std::deque<tripoint_abs_ms> queue;
    std::set<tripoint_abs_ms> visited;

    const auto seed = [&]( const tripoint_abs_ms & candidate ) {
        const tile_water_kind kind = tiles.get( candidate );
        if( belongs_to_finite_body( here, candidate, kind, liquid_id ) ) {
            if( visited.insert( candidate ).second ) {
                queue.push_back( candidate );
            }
        }
    };
    if( connect_target ) {
        for( const point &offset : four_adjacent_offsets ) {
            seed( p + offset );
        }
    } else {
        seed( p );
    }

    while( !queue.empty() ) {
        const tripoint_abs_ms current = queue.front();
        queue.pop_front();
        result.push_back( current );
        for( const point &offset : four_adjacent_offsets ) {
            seed( current + offset );
        }
    }
    std::sort( result.begin(), result.end() );
    return result;
}

int capacity_at( map &here, const tripoint_abs_ms &p )
{
    ter_id tid = terrain_at( here, p );
    if( is_pond_dry_ter( tid ) ) {
        tid = wet_terrain_for_dry( tid ).id();
    } else if( is_salt_pond_dry_ter( tid ) ) {
        tid = wet_terrain_for_salt_dry( tid ).id();
    } else if( is_other_dry_ter( tid ) ) {
        tid = wet_terrain_for_other_dry( tid ).id();
    } else if( tid == ter_channel_dry ) {
        tid = ter_channel_water_fresh.id();
    }
    return tile_water_capacity( tid.obj() );
}

int body_total( map &here, const std::vector<tripoint_abs_ms> &tiles )
{
    int total = 0;
    for( const tripoint_abs_ms &tile : tiles ) {
        total += tile_water_charges( here, tile );
    }
    return total;
}

bool rebalance_body( map &here, const std::vector<tripoint_abs_ms> &tiles, int requested_total,
                     const itype_id &liquid_id, const tripoint_abs_ms *preferred = nullptr )
{
    if( tiles.empty() ) {
        return requested_total == 0;
    }

    std::vector<int> capacities;
    std::vector<int> previous_amounts;
    capacities.reserve( tiles.size() );
    previous_amounts.reserve( tiles.size() );
    int maximum_depth = 0;
    int total_capacity = 0;
    for( const tripoint_abs_ms &tile : tiles ) {
        const int capacity = capacity_at( here, tile );
        capacities.push_back( capacity );
        previous_amounts.push_back( tile_water_charges( here, tile ) );
        maximum_depth = std::max( maximum_depth, capacity );
        total_capacity += capacity;
    }
    const int target_total = std::clamp( requested_total, 0, total_capacity );

    // All connected squares share one surface height.  A shallow square has a
    // higher bottom than a deep square, so it loses water first as that common
    // surface falls.  This prevents one bucket from making a lone dry hole in
    // an otherwise full pond.
    const auto volume_at_level = [&]( int level ) {
        int volume = 0;
        for( const int capacity : capacities ) {
            const int bottom = maximum_depth - capacity;
            volume += std::clamp( level - bottom, 0, capacity );
        }
        return volume;
    };

    int low = 0;
    int high = maximum_depth;
    while( low < high ) {
        const int middle = low + ( high - low + 1 ) / 2;
        if( volume_at_level( middle ) <= target_total ) {
            low = middle;
        } else {
            high = middle - 1;
        }
    }

    const int common_level = low;
    std::vector<int> amounts;
    amounts.reserve( tiles.size() );
    int assigned = 0;
    for( const int capacity : capacities ) {
        const int bottom = maximum_depth - capacity;
        const int amount = std::clamp( common_level - bottom, 0, capacity );
        amounts.push_back( amount );
        assigned += amount;
    }
    int remainder = target_total - assigned;
    std::vector<size_t> remainder_candidates;
    remainder_candidates.reserve( tiles.size() );
    for( size_t i = 0; i < tiles.size(); ++i ) {
        const int bottom = maximum_depth - capacities[i];
        if( common_level >= bottom && amounts[i] < capacities[i] ) {
            remainder_candidates.push_back( i );
        }
    }
    std::stable_sort( remainder_candidates.begin(), remainder_candidates.end(),
    [&]( size_t lhs, size_t rhs ) {
        const bool lhs_wet = previous_amounts[lhs] > 0;
        const bool rhs_wet = previous_amounts[rhs] > 0;
        if( lhs_wet != rhs_wet ) {
            return lhs_wet;
        }
        if( preferred != nullptr ) {
            const int lhs_distance = std::abs( tiles[lhs].x() - preferred->x() ) +
                                     std::abs( tiles[lhs].y() - preferred->y() );
            const int rhs_distance = std::abs( tiles[rhs].x() - preferred->x() ) +
                                     std::abs( tiles[rhs].y() - preferred->y() );
            if( lhs_distance != rhs_distance ) {
                return lhs_distance < rhs_distance;
            }
        }
        if( previous_amounts[lhs] != previous_amounts[rhs] ) {
            return previous_amounts[lhs] > previous_amounts[rhs];
        }
        return tiles[lhs] < tiles[rhs];
    } );
    for( const size_t index : remainder_candidates ) {
        if( remainder <= 0 ) {
            break;
        }
        ++amounts[index];
        --remainder;
    }

    bool success = remainder == 0;
    for( size_t i = 0; i < tiles.size(); ++i ) {
        success = set_water_charges( here, tiles[i], amounts[i], liquid_id ) && success;
    }
    return success;
}

int normalize_body( map &here, const std::vector<tripoint_abs_ms> &tiles,
                    const itype_id &liquid_id,
                    const tripoint_abs_ms *preferred = nullptr )
{
    const int total = body_total( here, tiles );
    rebalance_body( here, tiles, total, liquid_id, preferred );
    return total;
}

void set_channel_flow_state( map &here, const std::vector<tripoint_abs_ms> &tiles,
                             bool flowing, bool salt )
{
    const ter_id target = salt ?
                          ( flowing ? ter_channel_flowing_salt.id() : ter_channel_water_salt.id() ) :
                          ( flowing ? ter_channel_flowing_fresh.id() : ter_channel_water_fresh.id() );
    for( const tripoint_abs_ms &tile : tiles ) {
        const ter_id tid = terrain_at( here, tile );
        if( ( salt && is_salt_channel_ter( tid ) ) ||
            ( !salt && is_fresh_channel_ter( tid ) ) ) {
            set_terrain_at( here, tile, target );
        }
    }
}

int pour_into_finite_water_impl( const tripoint_abs_ms &p, item &liquid,
                                 const itype_id &liquid_id );

} // namespace

water_source_kind check_connection( const tripoint_abs_ms &p, bool connect_target )
{
    map &here = get_map();
    tile_classifier tiles( here );
    connection_state state;
    std::deque<tripoint_abs_ms> queue;
    std::set<tripoint_abs_ms> visited;

    const auto visit = [&]( const tripoint_abs_ms & candidate ) {
        const tile_water_kind kind = tiles.get( candidate );
        record_kind( state, kind );
        if( is_waterway_tile( kind ) && visited.insert( candidate ).second ) {
            queue.push_back( candidate );
        }
    };
    if( connect_target ) {
        // The proposed tile is an excavated connector regardless of its
        // current terrain.  Once visited, all adjoining dry or wet channel
        // sections belong to the same open route.
        visited.insert( p );
        queue.push_back( p );
    } else {
        visit( p );
    }

    while( !queue.empty() ) {
        const tripoint_abs_ms current = queue.front();
        queue.pop_front();
        for( const point &offset : four_adjacent_offsets ) {
            visit( current + offset );
        }
    }
    return finish_connection( state );
}

item finite_liquid_from( const tripoint_abs_ms &p,
                         std::vector<tripoint_abs_ms> *body_tiles )
{
    if( body_tiles != nullptr ) {
        body_tiles->clear();
    }
    map &here = get_map();
    const tile_water_kind kind = classify_uncached( here, p );
    const itype_id liquid_id = finite_liquid_id_at( here, p, kind );
    if( liquid_id.is_null() ) {
        return item();
    }

    std::vector<tripoint_abs_ms> local_tiles;
    std::vector<tripoint_abs_ms> &tiles = body_tiles != nullptr ? *body_tiles : local_tiles;
    tiles = collect_finite_tiles( p, false, liquid_id );
    const int total = body_total( here, tiles );
    if( total <= 0 ) {
        return item();
    }
    if( tile_water_charges( here, p ) <= 0 ) {
        return item();
    }
    const ter_t &source_terrain = terrain_at( here, p ).obj();
    item result( source_terrain.liquid_source_item_id, calendar::turn );
    result.charges = total;
    tile_location loc;
    const units::temperature minimum = units::from_celsius( source_terrain.liquid_source_min_temp );
    result.set_item_temperature( locate_tile( here, p, loc ) && loc.in_bubble ?
                                 std::max( get_weather().get_temperature( loc.bub ), minimum ) : minimum );
    return result;
}

tripoint_abs_ms finite_liquid_body_anchor( const tripoint_abs_ms &p )
{
    map &here = get_map();
    const tile_water_kind kind = classify_uncached( here, p );
    const itype_id liquid_id = finite_liquid_id_at( here, p, kind );
    if( liquid_id.is_null() ) {
        return p;
    }
    const std::vector<tripoint_abs_ms> tiles = collect_finite_tiles( p, false, liquid_id );
    return tiles.empty() ? p : tiles.front();
}

int withdraw_finite_liquid( const tripoint_abs_ms &p, int amount,
                            bool *source_has_liquid,
                            const std::vector<tripoint_abs_ms> *body_tiles )
{
    if( source_has_liquid != nullptr ) {
        *source_has_liquid = false;
    }
    if( amount <= 0 ) {
        return 0;
    }
    map &here = get_map();
    const tile_water_kind kind = classify_uncached( here, p );
    const itype_id liquid_id = finite_liquid_id_at( here, p, kind );
    if( liquid_id.is_null() ) {
        return 0;
    }

    std::vector<tripoint_abs_ms> local_tiles;
    if( body_tiles == nullptr ) {
        local_tiles = collect_finite_tiles( p, false, liquid_id );
        body_tiles = &local_tiles;
    }
    const std::vector<tripoint_abs_ms> &tiles = *body_tiles;
    const int total = body_total( here, tiles );
    if( tile_water_charges( here, p ) <= 0 ) {
        return 0;
    }
    const int withdrawn = std::min( amount, total );
    if( withdrawn > 0 && !rebalance_body( here, tiles, total - withdrawn, liquid_id, &p ) ) {
        return 0;
    }
    if( source_has_liquid != nullptr ) {
        *source_has_liquid = tile_water_charges( here, p ) > 0;
    }
    return withdrawn;
}

int pour_into_finite_water( const tripoint_abs_ms &p, item &liquid )
{
    map &here = get_map();
    const tile_water_kind kind = classify_uncached( here, p );
    if( kind != tile_water_kind::channel_dry && kind != tile_water_kind::channel_fresh &&
        kind != tile_water_kind::channel_salt && kind != tile_water_kind::pond_water &&
        kind != tile_water_kind::pond_dry && kind != tile_water_kind::salt_pond_water &&
        kind != tile_water_kind::salt_pond_dry && kind != tile_water_kind::other_water &&
        kind != tile_water_kind::other_dry ) {
        add_msg( m_info, _( "You can't pour that there." ) );
        return 0;
    }
    itype_id liquid_id = finite_liquid_id_at( here, p, kind );
    if( kind == tile_water_kind::channel_dry ) {
        liquid_id = canonical_liquid_id( liquid.typeId() );
        if( liquid_id != itype_water && liquid_id != itype_salt_water ) {
            add_msg( m_warning, _( "That liquid does not belong in a water channel." ) );
            return 0;
        }
    }
    const water_source_kind connected = check_connection( p, false );
    const bool connected_fresh = connected == water_source_kind::fresh_infinite ||
                                 connected == water_source_kind::fresh_finite;
    const bool connected_salt = connected == water_source_kind::salt_infinite ||
                                connected == water_source_kind::salt_finite;
    if( connected == water_source_kind::conflict ||
        ( liquid_id == itype_salt_water && connected_fresh ) ||
        ( liquid_id == itype_water && connected_salt ) ) {
        add_msg( m_warning, _( "That would mix fresh water and salt water." ) );
        return 0;
    }
    return pour_into_finite_water_impl( p, liquid, liquid_id );
}

namespace
{

int pour_into_finite_water_impl( const tripoint_abs_ms &p, item &liquid,
                                 const itype_id &liquid_id )
{
    map &here = get_map();
    if( canonical_liquid_id( liquid.typeId() ) != canonical_liquid_id( liquid_id ) ) {
        add_msg( m_warning, _( "You can't pour %s into this water." ), liquid.tname() );
        return 0;
    }

    const std::vector<tripoint_abs_ms> tiles = collect_finite_tiles( p, false, liquid_id );
    if( tiles.empty() ) {
        return 0;
    }

    const int stored = normalize_body( here, tiles, liquid_id, &p );
    int total_capacity = 0;
    for( const tripoint_abs_ms &tile : tiles ) {
        total_capacity += capacity_at( here, tile );
    }
    const int free_space = total_capacity - stored;
    if( free_space <= 0 ) {
        add_msg( m_info, _( "The water is already full." ) );
        return 0;
    }

    const int poured = std::min( free_space, liquid.charges );
    if( poured <= 0 || !rebalance_body( here, tiles, stored + poured, liquid_id, &p ) ) {
        return 0;
    }
    liquid.charges -= poured;
    if( poured > 0 ) {
        add_msg( m_info, _( "You pour some %s into the water." ), liquid.tname() );
    }
    if( liquid.charges > 0 && poured == free_space ) {
        add_msg( m_info, _( "It can't hold any more, so some %s remains in your container." ),
                 liquid.tname() );
    }
    return poured;
}

} // namespace

void refresh_connected_water( const tripoint_abs_ms &p )
{
    map &here = get_map();
    const water_source_kind source = check_connection( p, false );
    const bool salt = source == water_source_kind::salt_infinite ||
                      source == water_source_kind::salt_finite;
    if( source == water_source_kind::conflict || source == water_source_kind::none ) {
        return;
    }
    const itype_id liquid_id = salt ? itype_salt_water : itype_water;
    const std::vector<tripoint_abs_ms> tiles = collect_finite_tiles( p, false, liquid_id );
    if( source == water_source_kind::fresh_finite || source == water_source_kind::salt_finite ) {
        normalize_body( here, tiles, liquid_id, &p );
        set_channel_flow_state( here, tiles, false, salt );
        return;
    }
    int total_capacity = 0;
    for( const tripoint_abs_ms &tile : tiles ) {
        total_capacity += capacity_at( here, tile );
    }
    rebalance_body( here, tiles, total_capacity, liquid_id, &p );
    set_channel_flow_state( here, tiles, true, salt );
}

void fill_channel_at( const tripoint_abs_ms &p )
{
    map &here = get_map();
    const water_source_kind kind = check_connection( p, false );
    switch( kind ) {
        case water_source_kind::fresh_infinite:
        case water_source_kind::salt_infinite:
        case water_source_kind::fresh_finite:
        case water_source_kind::salt_finite:
            refresh_connected_water( p );
            if( is_salt_channel_ter( terrain_at( here, p ) ) ) {
                add_msg( m_good, _( "The open channels fill with salt water." ) );
            } else if( is_fresh_channel_ter( terrain_at( here, p ) ) ) {
                add_msg( m_good, _( "Water flows through the open channels." ) );
            } else {
                add_msg( m_info, _( "The channel is open, but the connected source is too low to reach it." ) );
            }
            break;
        case water_source_kind::conflict:
            add_msg( m_warning, _( "Fresh and salt water would mix here, so the channel stays dry." ) );
            break;
        case water_source_kind::none:
            add_msg( m_info, _( "The channel isn't connected to any water source and stays dry." ) );
            break;
    }
}

void refresh_adjacent_waterways( const tripoint_abs_ms &p )
{
    map &here = get_map();
    for( const point &offset : four_adjacent_offsets ) {
        const tripoint_abs_ms adjacent = p + offset;
        const ter_id tid = terrain_at( here, adjacent );
        if( is_channel_ter( tid ) || is_pond_or_pool_ter( tid ) ) {
            refresh_connected_water( adjacent );
        }
    }
}

bool can_pour_into( const tripoint_abs_ms &p )
{
    map &here = get_map();
    const ter_id tid = terrain_at( here, p );
    if( is_channel_ter( tid ) || is_pond_or_pool_ter( tid ) || is_legacy_pool_ter( tid ) ) {
        return true;
    }
    const tile_water_kind kind = classify_uncached( here, p );
    return kind == tile_water_kind::channel_dry || kind == tile_water_kind::channel_fresh ||
           kind == tile_water_kind::channel_salt || kind == tile_water_kind::pond_water ||
           kind == tile_water_kind::pond_dry || kind == tile_water_kind::salt_pond_water ||
           kind == tile_water_kind::salt_pond_dry || kind == tile_water_kind::other_water ||
           kind == tile_water_kind::other_dry;
}

bool manages_liquid_source( const tripoint_abs_ms &p )
{
    map &here = get_map();
    const tile_water_kind kind = classify_uncached( here, p );
    return kind == tile_water_kind::natural_fresh || kind == tile_water_kind::natural_salt ||
           kind == tile_water_kind::channel_fresh || kind == tile_water_kind::channel_salt ||
           kind == tile_water_kind::channel_dry || kind == tile_water_kind::pond_water ||
           kind == tile_water_kind::pond_dry || kind == tile_water_kind::salt_pond_water ||
           kind == tile_water_kind::salt_pond_dry || kind == tile_water_kind::other_water ||
           kind == tile_water_kind::other_dry;
}

} // namespace finite_water
