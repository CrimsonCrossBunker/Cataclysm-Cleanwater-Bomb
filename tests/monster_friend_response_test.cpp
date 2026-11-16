#include <string>
#include <utility>
#include <vector>

#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "game.h"
#include "json.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monfaction.h"
#include "monster.h"
#include "mtype.h"
#include "type_id.h"

TEST_CASE( "monster_friend_attacked_matches_ordered_full_scan", "[monster][friend_response]" )
{
    const int population = GENERATE( 16, 300 );
    const bool source_reacts = GENERATE( false, true );
    clear_map();
    restore_on_out_of_scope<time_point> restore_time( calendar::turn );
    calendar::turn = calendar::turn_zero + 12_hours;
    map &here = get_map();
    std::vector<mtype> types( 8, mtype_id( "mon_zombie" ).obj() );
    for( int i = 0; i < 8; ++i ) {
        const auto triggers = []( bool enabled ) -> std::string {
            return enabled ? "[\"FRIEND_ATTACKED\"]" : "[]";
        };
        const std::string definition = "{\"anger_triggers\":" + triggers( i & 1 ) +
                                       ",\"fear_triggers\":" + triggers( i & 2 ) +
                                       ",\"placate_triggers\":" + triggers( i & 4 ) + "}";
        types[i].load( json_loader::from_string( definition ).get_object(), "test" );
    }
    struct restore_monster_types {
        std::vector<std::pair<monster *, const mtype *>> originals;
        ~restore_monster_types() {
            for( const auto &entry : originals ) {
                entry.first->type = entry.second;
            }
        }
    } restore;
    std::vector<monster *> crowd;
    for( int i = 0; i < population; ++i ) {
        monster &mon = spawn_test_monster( "mon_zombie", { 10 + i % 20 * 5, 10 + i / 20 * 5, 0 } );
        restore.originals.emplace_back( &mon, mon.type );
        mon.type = &types[i % 8];
        mon.anger = 100;
        mon.morale = 100;
        crowd.push_back( &mon );
    }
    monster &source = *crowd.front();
    source.type = &types[source_reacts ? 7 : 0];
    for( int y = 0; y < 40; ++y ) {
        here.ter_set( tripoint_bub_ms( 28, y, 0 ), ter_str_id( "t_wall" ) );
    }
    g->reset_light_level();
    here.build_map_cache( 0 );
    const int light = g->light_level( 0 );
    std::vector<std::pair<int, int>> expected;
    for( monster *mon : crowd ) {
        int anger = mon->anger;
        int morale = mon->morale;
        if( source_reacts && mon->faction->attitude( source.faction ) == MFA_FRIENDLY &&
            here.sees( mon->pos_bub( here ), source.pos_bub( here ), light ) ) {
            if( mon->type->has_anger_trigger( mon_trigger::FRIEND_ATTACKED ) ) {
                anger += 15;
            } else if( mon->type->has_fear_trigger( mon_trigger::FRIEND_ATTACKED ) ) {
                morale -= 15;
            } else if( mon->type->has_placate_trigger( mon_trigger::FRIEND_ATTACKED ) ) {
                anger -= 15;
            }
        }
        expected.emplace_back( anger, morale );
    }
    source.on_hit( &here, nullptr, bodypart_id(), 0.0f, nullptr );
    for( std::size_t i = 0; i < crowd.size(); ++i ) {
        CAPTURE( population, source_reacts, i );
        CHECK( crowd[i]->anger == expected[i].first );
        CHECK( crowd[i]->morale == expected[i].second );
    }
}
