#include "character.h"

#include "addiction.h"
#include "json.h"
#include "morale.h"

// Read-only state projection and replica restoration. These do not ingest food,
// digest it, replay morale/effect callbacks, or consume gameplay randomness.
void Character::store_needs_state( JsonOut &out ) const
{
    out.start_object();
    out.member( "stomach", stomach );
    out.member( "guts", guts );
    out.member( "history", consumption_history );
    out.member( "vitamins", vitamin_levels );
    out.member( "daily_vitamins", daily_vitamins );
    out.member( "addictions", addictions );
    out.member( "hunger", hunger );
    out.member( "thirst", thirst );
    out.member( "calories", stored_calories );
    out.member( "sleepiness", sleepiness );
    out.member( "sleep_deprivation", sleep_deprivation );
    out.member( "lifestyle", lifestyle );
    out.member( "daily_health", daily_health );
    out.member( "health_tally", health_tally );
    out.member( "stim", stim );
    out.member( "pkill", pkill );
    out.member( "sensitive", sensitive );
    out.member( "sensitive_mod", sensitive_mod );
    morale->store( out );
    out.end_object();
}

void Character::load_needs_state( const JsonObject &data )
{
    data.read( "stomach", stomach, true );
    data.read( "guts", guts, true );
    data.read( "history", consumption_history, true );
    data.read( "vitamins", vitamin_levels, true );
    data.read( "daily_vitamins", daily_vitamins, true );
    data.read( "addictions", addictions, true );
    data.read( "hunger", hunger, true );
    data.read( "thirst", thirst, true );
    data.read( "calories", stored_calories, true );
    data.read( "sleepiness", sleepiness, true );
    data.read( "sleep_deprivation", sleep_deprivation, true );
    data.read( "lifestyle", lifestyle, true );
    data.read( "daily_health", daily_health, true );
    data.read( "health_tally", health_tally, true );
    data.read( "stim", stim, true );
    data.read( "pkill", pkill, true );
    data.read( "sensitive", sensitive, true );
    data.read( "sensitive_mod", sensitive_mod, true );
    morale->load( data );
}
