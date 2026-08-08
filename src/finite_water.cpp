#include "finite_water.h"

#include <algorithm>
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

namespace finite_water
{

namespace
{

const ter_str_id ter_pond_water_sh( "t_pond_water_sh" );
const ter_str_id ter_pond_water_dp( "t_pond_water_dp" );
const ter_str_id ter_pond_bottom_dry_sh( "t_pond_bottom_dry_sh" );
const ter_str_id ter_pond_bottom_dry_dp( "t_pond_bottom_dry_dp" );
const ter_str_id ter_pool_water( "t_pool_water" );
const ter_str_id ter_pool_water_shallow( "t_pool_water_shallow" );
const ter_str_id ter_pool_water_outdoors( "t_pool_water_outdoors" );
const ter_str_id ter_pool_water_shallow_outdoors( "t_pool_water_shallow_outdoors" );
const ter_str_id ter_pool_bottom_dry( "t_pool_bottom_dry" );
const ter_str_id ter_pool_bottom_dry_shallow( "t_pool_bottom_dry_shallow" );
const ter_str_id ter_pool_bottom_dry_outdoors( "t_pool_bottom_dry_outdoors" );
const ter_str_id ter_pool_bottom_dry_shallow_outdoors( "t_pool_bottom_dry_shallow_outdoors" );
const ter_str_id ter_channel_dry( "t_channel_dry" );
const ter_str_id ter_channel_water_fresh( "t_channel_water_fresh" );
const ter_str_id ter_channel_water_salt( "t_channel_water_salt" );

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

const itype_id itype_water( "water" );
const itype_id itype_water_clean( "water_clean" );

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
    return tid == ter_pond_water_sh || tid == ter_pond_water_dp ||
           tid == ter_pool_water || tid == ter_pool_water_shallow ||
           tid == ter_pool_water_outdoors || tid == ter_pool_water_shallow_outdoors;
}

bool is_pond_dry_ter( const ter_id &tid )
{
    return tid == ter_pond_bottom_dry_sh || tid == ter_pond_bottom_dry_dp ||
           tid == ter_pool_bottom_dry || tid == ter_pool_bottom_dry_shallow ||
           tid == ter_pool_bottom_dry_outdoors || tid == ter_pool_bottom_dry_shallow_outdoors;
}

bool is_pond_or_pool_ter( const ter_id &tid )
{
    return is_pond_water_ter( tid ) || is_pond_dry_ter( tid );
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

tile_water_kind classify_uncached( map &here, const tripoint_abs_ms &p )
{
    const ter_id tid = terrain_at( here, p );
    if( tid == ter_id() ) {
        return tile_water_kind::not_water;
    }
    if( tid == ter_channel_dry ) {
        return tile_water_kind::channel_dry;
    }
    if( tid == ter_channel_water_fresh ) {
        return tile_water_kind::channel_fresh;
    }
    if( tid == ter_channel_water_salt ) {
        return tile_water_kind::channel_salt;
    }
    if( is_pond_water_ter( tid ) ) {
        return tile_water_kind::pond_water;
    }
    if( is_pond_dry_ter( tid ) ) {
        return tile_water_kind::pond_dry;
    }

    const oter_id omt = overmap_buffer.ter( project_to<coords::omt>( p ) );
    if( is_core_fresh_water( tid ) &&
        ( is_lake_or_river( omt ) || omt->has_flag( oter_flags::stream ) ) ) {
        return tile_water_kind::natural_fresh;
    }
    if( is_core_salt_water( tid ) && is_ocean( omt ) ) {
        return tile_water_kind::natural_salt;
    }
    const ter_t &ter = tid.obj();
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

bool set_water_charges( map &here, const tripoint_abs_ms &p, int charges, bool salt = false )
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
        const ter_id wet_channel = salt ? ter_channel_water_salt.id() :
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

    const ter_t &ter = tid.obj();
    if( ter.liquid_source_item_id.is_null() ||
        ter.liquid_source_count == std::make_pair( 0, 0 ) ) {
        return false;
    }
    if( uses_hidden_finite_liquid( ter ) ) {
        loc.sm->player_adjusted_map = true;
        loc.sm->set_finite_liquid( loc.local, std::max( 0, charges ) );
        if( charges > 0 ) {
            return true;
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
    bool passed_pond = false;
    bool fresh_found = false;
    bool salt_found = false;
};

bool is_waterway_tile( tile_water_kind kind )
{
    return kind == tile_water_kind::channel_fresh || kind == tile_water_kind::channel_salt ||
           kind == tile_water_kind::channel_dry || kind == tile_water_kind::pond_water ||
           kind == tile_water_kind::pond_dry;
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
            state.passed_pond = true;
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
    if( state.saw_fresh && state.passed_pond ) {
        return water_source_kind::fresh_finite;
    }
    return water_source_kind::none;
}

bool belongs_to_finite_body( tile_water_kind kind, bool salt )
{
    if( salt ) {
        return kind == tile_water_kind::channel_salt || kind == tile_water_kind::channel_dry;
    }
    return kind == tile_water_kind::channel_fresh || kind == tile_water_kind::channel_dry ||
           kind == tile_water_kind::pond_water || kind == tile_water_kind::pond_dry;
}

std::vector<tripoint_abs_ms> collect_finite_tiles( const tripoint_abs_ms &p, bool connect_target,
        bool salt = false )
{
    map &here = get_map();
    tile_classifier tiles( here );
    std::vector<tripoint_abs_ms> result;
    std::deque<tripoint_abs_ms> queue;
    std::set<tripoint_abs_ms> visited;

    const auto seed = [&]( const tripoint_abs_ms & candidate ) {
        const tile_water_kind kind = tiles.get( candidate );
        if( belongs_to_finite_body( kind, salt ) ) {
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
                     bool salt = false )
{
    if( tiles.empty() ) {
        return requested_total == 0;
    }

    std::vector<int> capacities;
    capacities.reserve( tiles.size() );
    int maximum_depth = 0;
    int total_capacity = 0;
    for( const tripoint_abs_ms &tile : tiles ) {
        const int capacity = capacity_at( here, tile );
        capacities.push_back( capacity );
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
    for( size_t i = 0; i < tiles.size() && remainder > 0; ++i ) {
        const int bottom = maximum_depth - capacities[i];
        if( common_level >= bottom && amounts[i] < capacities[i] ) {
            ++amounts[i];
            --remainder;
        }
    }

    bool success = remainder == 0;
    for( size_t i = 0; i < tiles.size(); ++i ) {
        success = set_water_charges( here, tiles[i], amounts[i], salt ) && success;
    }
    return success;
}

int normalize_body( map &here, const std::vector<tripoint_abs_ms> &tiles, bool salt = false )
{
    const int total = body_total( here, tiles );
    rebalance_body( here, tiles, total, salt );
    return total;
}

int pour_into_finite_water_impl( const tripoint_abs_ms &p, item &liquid );

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

item finite_liquid_from( const tripoint_abs_ms &p )
{
    map &here = get_map();
    const tile_water_kind kind = classify_uncached( here, p );
    const bool salt = kind == tile_water_kind::channel_salt;
    if( !salt && kind != tile_water_kind::channel_fresh &&
        kind != tile_water_kind::pond_water && kind != tile_water_kind::pond_dry ) {
        return item();
    }

    const std::vector<tripoint_abs_ms> tiles = collect_finite_tiles( p, false, salt );
    const int total = normalize_body( here, tiles, salt );
    if( total <= 0 ) {
        return item();
    }
    if( tile_water_charges( here, p ) <= 0 ) {
        return item();
    }
    item result( salt ? itype_id( "salt_water" ) : itype_water, calendar::turn );
    result.charges = total;
    return result;
}

int withdraw_finite_liquid( const tripoint_abs_ms &p, int amount )
{
    if( amount <= 0 ) {
        return 0;
    }
    map &here = get_map();
    const tile_water_kind kind = classify_uncached( here, p );
    const bool salt = kind == tile_water_kind::channel_salt;
    if( !salt && kind != tile_water_kind::channel_fresh &&
        kind != tile_water_kind::pond_water && kind != tile_water_kind::pond_dry ) {
        return 0;
    }

    const std::vector<tripoint_abs_ms> tiles = collect_finite_tiles( p, false, salt );
    const int total = normalize_body( here, tiles, salt );
    if( tile_water_charges( here, p ) <= 0 ) {
        return 0;
    }
    const int withdrawn = std::min( amount, total );
    if( withdrawn > 0 && !rebalance_body( here, tiles, total - withdrawn, salt ) ) {
        return 0;
    }
    return withdrawn;
}

int pour_into_finite_water( const tripoint_abs_ms &p, item &liquid )
{
    map &here = get_map();
    if( !is_pond_or_pool_ter( terrain_at( here, p ) ) ) {
        add_msg( m_info, _( "You can't pour that there." ) );
        return 0;
    }
    return pour_into_finite_water_impl( p, liquid );
}

namespace
{

int pour_into_finite_water_impl( const tripoint_abs_ms &p, item &liquid )
{
    map &here = get_map();
    if( liquid.typeId() != itype_water && liquid.typeId() != itype_water_clean ) {
        add_msg( m_warning, _( "You can't pour %s into this water." ), liquid.tname() );
        return 0;
    }

    const std::vector<tripoint_abs_ms> tiles = collect_finite_tiles( p, false );
    if( tiles.empty() ) {
        return 0;
    }

    const int stored = normalize_body( here, tiles );
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
    if( poured <= 0 || !rebalance_body( here, tiles, stored + poured ) ) {
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
    const bool salt = source == water_source_kind::salt_infinite;
    if( source == water_source_kind::conflict || source == water_source_kind::none ) {
        return;
    }
    const std::vector<tripoint_abs_ms> tiles = collect_finite_tiles( p, false, salt );
    if( source == water_source_kind::fresh_finite ) {
        normalize_body( here, tiles );
        return;
    }
    int total_capacity = 0;
    for( const tripoint_abs_ms &tile : tiles ) {
        total_capacity += capacity_at( here, tile );
    }
    rebalance_body( here, tiles, total_capacity, salt );
}

void fill_channel_at( const tripoint_abs_ms &p )
{
    map &here = get_map();
    const water_source_kind kind = check_connection( p, false );
    switch( kind ) {
        case water_source_kind::fresh_infinite:
        case water_source_kind::salt_infinite:
        case water_source_kind::fresh_finite:
            refresh_connected_water( p );
            if( terrain_at( here, p ) == ter_channel_water_salt ) {
                add_msg( m_good, _( "The open channels fill with salt water." ) );
            } else if( terrain_at( here, p ) == ter_channel_water_fresh ) {
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

bool is_pond_or_pool_tile( const tripoint_abs_ms &p )
{
    return is_pond_or_pool_ter( terrain_at( get_map(), p ) );
}

} // namespace finite_water
