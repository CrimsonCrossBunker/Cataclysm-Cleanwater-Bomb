#if defined(TILES)
#include "tile_lookup.h"

#include <utility>

#include "cata_assert.h"
#include "cata_utility.h"
#include "enum_conversions.h"
#include "field_type.h"
#include "item.h"
#include "itype.h"
#include "mapdata.h"
#include "mtype.h"
#include "omdata.h"
#include "overmap.h"
#include "profiling.h"
#include "string_formatter.h"
#include "type_id.h"
#include "veh_type.h"

tile_lookup_frame::tile_lookup_frame( std::shared_ptr<const tileset> bundle,
                                      season_type season, bool cache_results ) :
    bundle_( std::move( bundle ) ), season_( season ), cache_results_( cache_results )
{
    cata_assert( bundle_ );
}

tile_lookup_frame::~tile_lookup_frame()
{
#if defined(TRACY_ENABLE)
    if( cache_results_ ) {
        CATA_PROFILE_SCOPE_NAMED( "tiles.lookup_frame_summary" );
        const std::string counts = string_format( "requests=%zu;hits=%zu;ids=%zu",
            requests_, cache_hits_, results_.size() );
        CATA_PROFILE_TEXT( counts.c_str(), counts.size() );
    }
#endif
}

bool tile_lookup_frame::entry::matches( TILE_CATEGORY requested_category,
                                        const std::string &requested_variant, int requested_limit ) const
{
    return category == requested_category && variant == requested_variant &&
           jumps_limit == requested_limit;
}

std::optional<tile_lookup_res> tile_lookup_frame::find( const std::string &id,
        TILE_CATEGORY category, const std::string &variant, int jumps_limit )
{
    ++requests_;
    if( id.empty() || jumps_limit <= 0 ) {
        return std::nullopt;
    }
    if( cache_results_ ) {
        const auto found = results_.find( id );
        if( found != results_.end() ) {
            const id_results &cached = found->second;
            if( cached.first.matches( category, variant, jumps_limit ) ) {
                ++cache_hits_;
                return cached.first.result;
            }
            for( const entry &alternative : cached.alternatives ) {
                if( alternative.matches( category, variant, jumps_limit ) ) {
                    ++cache_hits_;
                    return alternative.result;
                }
            }
        }
    }
    std::optional<tile_lookup_res> result = resolve( id, category, variant, jumps_limit );
    if( cache_results_ ) {
        // Recursive fallbacks may insert the same id at another depth, or
        // rehash the table, so find its slot again after resolution.
        entry value{ category, variant, jumps_limit, result };
        const auto inserted = results_.try_emplace( id, id_results{ value, {} } );
        if( !inserted.second ) {
            inserted.first->second.alternatives.push_back( std::move( value ) );
        }
    }
    return result;
}

std::optional<tile_lookup_res> tile_lookup_frame::find_with_season( const std::string &id ) const
{
    return bundle_->find_tile_type_by_season( id, season_ );
}

template<typename T>
std::optional<tile_lookup_res> tile_lookup_frame::find_by_string_id( std::string_view id,
        TILE_CATEGORY category, int jumps_limit )
{
    const string_id<T> s_id( id );
    if( !s_id.is_valid() ) {
        return std::nullopt;
    }
    return find( s_id.obj().looks_like, category, "", jumps_limit - 1 );
}

std::optional<tile_lookup_res>
tile_lookup_frame::resolve( const std::string &id, TILE_CATEGORY category,
                            const std::string &variant,
                            const int looks_like_jumps_limit )
{
    if( id.empty() || looks_like_jumps_limit <= 0 ) {
        return std::nullopt;
    }

    // Every returned id/tile belongs to the bundle pinned by this frame.
    // Try the variant first
    if( !variant.empty() ) {
        if( category != TILE_CATEGORY::VEHICLE_PART ) {
            //indicates a sprite suffix
            if( variant[0] == '_' ) {
                if( auto ret = find_with_season( id + variant ) ) {
                    return ret; // with variant
                }
            } else if( auto ret = find_with_season( id + "_var_" + variant ) ) {
                return ret; // with variant
            }
        } else {
            std::string_view variant_chunk = variant;
            while( !variant_chunk.empty() ) {
                if( auto ret = find_with_season( id + "_" + std::string( variant_chunk ) ) ) {
                    return ret; // with variant, but vehicle parts have weird variant suffixes
                }
                const size_t next_start = variant_chunk.rfind( '_' );
                if( next_start != std::string::npos ) {
                    variant_chunk = variant_chunk.substr( 0, next_start );
                } else {
                    variant_chunk = variant_chunk.substr( 0, 0 );
                }
            }
        }
    }
    if( auto ret = find_with_season( id ) ) {
        return ret; // no variant
    }

    // Then do looks_like
    switch( category ) {
        case TILE_CATEGORY::FURNITURE:
            return find_by_string_id<furn_t>( id, category,
                                              looks_like_jumps_limit );
        case TILE_CATEGORY::TERRAIN:
            return find_by_string_id<ter_t>( id, category, looks_like_jumps_limit );
        case TILE_CATEGORY::FIELD:
            return find_by_string_id<field_type>( id, category,
                                                  looks_like_jumps_limit );
        case TILE_CATEGORY::MONSTER:
            return find_by_string_id<mtype>( id, category, looks_like_jumps_limit );
        case TILE_CATEGORY::OVERMAP_VISION_LEVEL: {
            size_t id_end = id.find( '$' );
            om_vision_level level = io::string_to_enum<om_vision_level>( id.substr( id_end + 1 ) );
            oter_vision_id vision_id( id.substr( 0, id_end ) );
            // This shouldn't fail, but better safe than sorry
            const oter_vision::level *viewed = vision_id->viewed( level );
            if( viewed != nullptr && !viewed->looks_like.empty() ) {
                return find( viewed->looks_like, TILE_CATEGORY::OVERMAP_TERRAIN, variant,
                             looks_like_jumps_limit - 1 );
            }
            return std::nullopt;
        }
        case TILE_CATEGORY::OVERMAP_TERRAIN: {
            std::optional<tile_lookup_res> ret;
            const oter_type_str_id type_tmp( id );
            if( !type_tmp.is_valid() ) {
                return ret;
            }

            int jump_limit = looks_like_jumps_limit;
            for( const std::string &looks_like : type_tmp.obj().looks_like ) {

                ret = find( looks_like, category, "", jump_limit - 1 );
                if( ret.has_value() ) {
                    return ret;
                }

                jump_limit--;
                if( jump_limit <= 0 ) {
                    return ret;
                }
            }

            return ret;
        }

        case TILE_CATEGORY::VEHICLE_PART: {
            const int lljl = looks_like_jumps_limit - 1;
            // vehicle parts start with vp_ for their tiles, but not their IDs
            const vpart_id vpid( id.substr( 3 ) );
            if( !vpid.is_valid() ) {
                return std::nullopt;
            }
            const std::string &looks_like = vpid->looks_like;
            if( looks_like.empty() ) {
                return std::nullopt;
            }
            if( auto ret = find( "vp_" + looks_like, category, variant, lljl ) ) {
                return ret;
            }
            if( auto ret = find( looks_like, category, variant, lljl ) ) {
                return ret;
            }
            if( auto ret = find( looks_like, TILE_CATEGORY::FURNITURE, variant, lljl ) ) {
                return ret;
            }
            return std::nullopt;
        }

        case TILE_CATEGORY::ITEM: {
            if( !item::type_is_defined( itype_id( id ) ) ) {
                if( string_starts_with( id, "corpse_" ) ) {
                    return find(
                               "corpse", category, "", looks_like_jumps_limit - 1
                           );
                }
                return std::nullopt;
            }
            const itype *new_it = item::find_type( itype_id( id ) );
            return find( new_it->looks_like.str(), category, "",
                         looks_like_jumps_limit - 1 );
        }

        default:
            return std::nullopt;
    }
}

#endif // TILES
