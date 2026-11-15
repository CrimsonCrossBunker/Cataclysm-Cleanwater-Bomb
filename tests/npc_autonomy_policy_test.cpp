#include "cata_catch.h"
#include "npc_autonomy.h"

TEST_CASE( "npc_autonomy_supply_quotas", "[npc][autonomy][policy]" )
{
    CHECK( npc_autonomy::missing_units( 0, 6 ) == 6 );
    CHECK( npc_autonomy::missing_units( 5, 6 ) == 1 );
    CHECK( npc_autonomy::missing_units( 6, 6 ) == 0 );
    CHECK( npc_autonomy::missing_units( 100, 6 ) == 0 );
    CHECK( npc_autonomy::missing_units( 0, 240, 5 ) == 48 );
    CHECK( npc_autonomy::missing_units( 239, 240, 5 ) == 1 );
    CHECK( npc_autonomy::missing_units( 240, 240, 5 ) == 0 );
    CHECK( npc_autonomy::missing_units( 0, 240, 0 ) == 0 );
    CHECK( npc_autonomy::missing_units( 0, 240, -5 ) == 0 );
}

TEST_CASE( "npc_autonomy_action_window", "[npc][autonomy][policy]" )
{
    CHECK_FALSE( npc_autonomy::action_window( 1, 100, 100, 100 ) );
    CHECK_FALSE( npc_autonomy::action_window( 8, 100, 200, 300 ) );
    CHECK( npc_autonomy::action_window( 8, 100, 100, 300 ) );
    CHECK_FALSE( npc_autonomy::action_window( 8, 100, 100, 1000 ) );
    CHECK_FALSE( npc_autonomy::action_window( 8, 0, 100, 100 ) );
    CHECK_FALSE( npc_autonomy::action_window( 8, 100, 0, 100 ) );
    CHECK_FALSE( npc_autonomy::action_window( 8, 100, 100, -1 ) );
}

TEST_CASE( "npc_autonomy_equipment_hysteresis", "[npc][autonomy][policy]" )
{
    CHECK_FALSE( npc_autonomy::worthwhile_upgrade( 20, 20 ) );
    CHECK_FALSE( npc_autonomy::worthwhile_upgrade( 20, 22 ) );
    CHECK_FALSE( npc_autonomy::worthwhile_upgrade( 100, 110 ) );
    CHECK( npc_autonomy::worthwhile_upgrade( 20, 30 ) );
    CHECK( npc_autonomy::worthwhile_upgrade( 100, 116 ) );
    CHECK_FALSE( npc_autonomy::worthwhile_upgrade( 0, 3 ) );
    CHECK( npc_autonomy::worthwhile_upgrade( 0, 4 ) );
}

TEST_CASE( "npc_autonomy_work_is_bounded_and_never_free", "[npc][autonomy][policy]" )
{
    CHECK( npc_autonomy::work_slice( 500, 1000, 0 ) == 100 );
    CHECK( npc_autonomy::work_slice( 40, 1000, 0 ) == 40 );
    CHECK( npc_autonomy::work_slice( 100, 150, 140 ) == 10 );
    CHECK( npc_autonomy::work_slice( 0, 150, 0 ) == 0 );
    CHECK( npc_autonomy::work_slice( -100, 150, 0 ) == 0 );
    CHECK( npc_autonomy::work_slice( 100, 150, 150 ) == 0 );
    CHECK( npc_autonomy::work_slice( 100, 150, 200 ) == 0 );
    int paid = 0;
    while( paid < 1234 ) {
        paid += npc_autonomy::work_slice( 100, 1234, paid );
    }
    CHECK( paid == 1234 );
}

TEST_CASE( "npc_autonomy_sharing_cannot_overshoot_balance", "[npc][autonomy][policy]" )
{
    CHECK( npc_autonomy::balanced_units( 12, 0 ) == 6 );
    CHECK( npc_autonomy::balanced_units( 6, 6 ) == 0 );
    CHECK( npc_autonomy::balanced_units( 0, 6 ) == 0 );
    CHECK( npc_autonomy::balanced_units( 4, 3 ) == 0 );
    CHECK( npc_autonomy::balanced_units( 3600, 0, 1200 ) == 1 );
    CHECK( npc_autonomy::balanced_units( 2400, 1200, 1200 ) == 0 );
    CHECK( npc_autonomy::balanced_units( 100, 0, 0 ) == 0 );
    CHECK( npc_autonomy::balanced_units( 100, 0, -1 ) == 0 );
}

TEST_CASE( "npc_autonomy_maintenance_is_staggered", "[npc][autonomy][policy]" )
{
    CHECK( to_seconds<int>( npc_autonomy::cadence( 30_seconds, 1 ) ) == 31 );
    CHECK( to_seconds<int>( npc_autonomy::cadence( 30_seconds, 4 ) ) == 34 );
    CHECK( to_seconds<int>( npc_autonomy::cadence( 30_seconds, 5 ) ) == 30 );
    CHECK( to_seconds<int>( npc_autonomy::cadence( 30_seconds, -1 ) ) == 30 );
}

TEST_CASE( "npc_autonomy_care_ranks_critical_injuries_before_routine_wounds",
           "[npc][autonomy][policy][medical]" )
{
    CHECK( npc_autonomy::care_priority( 15, false, false, false ) >
           npc_autonomy::care_priority( 70, true, false, false ) );
    CHECK( npc_autonomy::care_priority( 70, true, false, false ) >
           npc_autonomy::care_priority( 70, false, true, false ) );
    CHECK( npc_autonomy::care_priority( 70, false, true, false ) >
           npc_autonomy::care_priority( 70, false, false, true ) );
    CHECK( npc_autonomy::care_priority( 70, false, false, true ) >
           npc_autonomy::care_priority( 70, false, false, false ) );
    CHECK( npc_autonomy::care_priority( 100, false, false, false ) == 0 );
    CHECK( npc_autonomy::care_priority( -20, false, false, false ) == 1000 );
    CHECK( npc_autonomy::care_priority( 200, false, false, false ) == 0 );
}

TEST_CASE( "npc_autonomy_arbitration_preserves_commitment_but_not_over_emergencies",
           "[npc][autonomy][policy][scheduling]" )
{
    CHECK( npc_autonomy::action_score( 0.5, 100, 0, true ) >
           npc_autonomy::action_score( 0.52, 100, 0, false ) );
    CHECK( npc_autonomy::action_score( 0.9, 1000, 0, false ) >
           npc_autonomy::action_score( 0.8, 100, 0, true, 600 ) );
    CHECK( npc_autonomy::action_score( 0.5, 100, 0, false ) >
           npc_autonomy::action_score( 0.5, 1000, 0.5, false ) );
}

TEST_CASE( "npc_autonomy_hit_estimates_account_for_range_and_size",
           "[npc][autonomy][policy][combat]" )
{
    CHECK( npc_autonomy::hit_estimate( 5, 10, 0.5 ) >
           npc_autonomy::hit_estimate( 20, 10, 0.5 ) );
    CHECK( npc_autonomy::hit_estimate( 10, 10, 1.0 ) >
           npc_autonomy::hit_estimate( 10, 10, 0.25 ) );
    CHECK( npc_autonomy::hit_estimate( 0, 0, 0 ) >= 0 );
    CHECK( npc_autonomy::hit_estimate( 0, 100, 10 ) <= 1 );
}

TEST_CASE( "npc_autonomy_effective_damage_preserves_penetration_and_multipliers",
           "[npc][autonomy][policy][combat]" )
{
    CHECK( npc_autonomy::effective_damage( 30, 20, 0, 1, 1 ) == 10 );
    CHECK( npc_autonomy::effective_damage( 30, 20, 15, 1, 1 ) == 25 );
    CHECK( npc_autonomy::effective_damage( 10, 20, 0, 1, 1 ) == 0 );
    CHECK( npc_autonomy::effective_damage( 30, 20, 0, 0.5, 2 ) == 40 );
}

TEST_CASE( "npc_autonomy_combat_utility_accounts_for_time_risk_and_saturation",
           "[npc][autonomy][policy][combat]" )
{
    const double ready = npc_autonomy::attack_utility( 40, 0.8, 100, 100, 0, 0 );
    CHECK( ready > npc_autonomy::attack_utility( 40, 0.8, 400, 100, 0, 0 ) );
    CHECK( ready > npc_autonomy::attack_utility( 40, 0.8, 100, 100, 0, 300 ) );
    CHECK( ready > npc_autonomy::attack_utility( 40, 0.8, 100, 100, 100, 0 ) );
    CHECK( npc_autonomy::attack_utility( 40, 0.8, 100, 100, 100, 0 ) > 0 );
    CHECK( npc_autonomy::attack_utility( 100, 1, 100, 10, 0, 0 ) ==
           npc_autonomy::attack_utility( 10, 1, 100, 10, 0, 0 ) );
}

TEST_CASE( "npc_autonomy_expedition_stock_is_bounded", "[npc][autonomy][policy][supplies]" )
{
    CHECK( npc_autonomy::expedition_stock( 2400, false ) == 2400 );
    CHECK( npc_autonomy::expedition_stock( 2400, true ) == 4800 );
    CHECK( npc_autonomy::expedition_stock( -100, true ) == 0 );
}

TEST_CASE( "npc_combat_weapon_opportunity_counts_closing_and_retrieval_time",
           "[npc][autonomy][policy][weapon]" )
{
    const double crowbar = npc_autonomy::combat_weapon_value( 3.0, 20, 1, 0 );
    CHECK( npc_autonomy::combat_weapon_value( 0.4, 20, 20, 200 ) > crowbar * 1.15 );
    CHECK( npc_autonomy::combat_weapon_value( 0.4, 1, 20, 200 ) <
           npc_autonomy::combat_weapon_value( 3.0, 1, 1, 0 ) );
    CHECK( npc_autonomy::combat_weapon_value( 0.4, 20, 1, 200 ) < crowbar );
    CHECK( npc_autonomy::combat_weapon_value( 0.4, 20, 20, 1000 ) < crowbar );
    CHECK( npc_autonomy::combat_weapon_value( 0.0, 20, 20, 0 ) == 0.0 );
}
