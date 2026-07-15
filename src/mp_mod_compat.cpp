#include "mp_mod_compat.h"

#include <map>
#include <utility>

#include "cata_path.h"
#include "color.h"
#include "mod_manager.h"
#include "mp_gamestate.h"
#include "translations.h"
#include "type_id.h"

namespace cata_mp
{

namespace
{

struct coop_entry {
    mod_coop status;
    const char *note;
};

// Generic note for any enabled mod we don't ship and haven't vetted.  These are
// dropped into the user's mods/ folder; we can't reason about their sync safety,
// and a mod mismatch between host and client is a common cause of client crashes.
const char *third_party_note = translate_marker(
                                   "CO-OP: untested third-party mod.  This mod is not bundled with the game and has not been vetted for co-op; it may desync or crash the joining player.  Both players must have the exact same mods installed." );

// True when a mod is NOT shipped with the game.  Bundled (and core) mods load
// from the data dir; downloaded/third-party mods load from the user mods/ dir.
// Unknown or unresolvable ids are treated as third-party (warn, not silently ok).
bool is_third_party_mod( const std::string &ident )
{
    const mod_id mid( ident );
    if( !mid.is_valid() ) {
        return true;
    }
    const MOD_INFORMATION &info = mid.obj();
    if( info.core ) {
        return false;
    }
    return info.path.get_logical_root() == cata_path::root_path::user;
}

// Keyed by mod_id::str().  See the 2026-06 audit for the per-mod reasoning.
const std::map<std::string, coop_entry> &coop_table()
{
    static const std::map<std::string, coop_entry> table = {
        // -- Hard breaks: dimension/instanced-map travel or wholesale scripted
        //    power sets that don't run on the remote player. ----------------
        {
            "skyisland", {
                mod_coop::incompatible,
                translate_marker( "CO-OP: NOT COMPATIBLE.  Moves between the island and the mainland as separate dimensions; co-op shares one world and cannot place the two players in different dimensions." )
            }
        },
        {
            "Isolation_Protocol", {
                mod_coop::incompatible,
                translate_marker( "CO-OP: NOT COMPATIBLE.  Every elevator descent teleports you into a freshly generated instanced level; co-op's single shared map can't hold two players on different levels." )
            }
        },
        {
            "magiclysm", {
                mod_coop::incompatible,
                translate_marker( "CO-OP: NOT COMPATIBLE.  Leans heavily on teleport spells and scripted (effect-on-condition) effects that don't apply to the remote player, and long-range teleports break the shared map." )
            }
        },
        {
            "mindovermatter", {
                mod_coop::incompatible,
                translate_marker( "CO-OP: NOT COMPATIBLE.  Psionic powers are scripted and run only on your own client; teleportation powers break the shared map and self-heals desync from the host." )
            }
        },
        {
            "mom_knacks_only", {
                mod_coop::incompatible,
                translate_marker( "CO-OP: NOT COMPATIBLE.  Built on Mind Over Matter, which is not co-op compatible." )
            }
        },
        {
            "xedra_evolved", {
                mod_coop::incompatible,
                translate_marker( "CO-OP: NOT COMPATIBLE.  Paraclesian, vampire and dream powers are scripted and run only on your own client, and several mechanics teleport you to separate maps (dream realm, pocket dungeons)." )
            }
        },

        // -- Plays, but breaks or desyncs for the client. -------------------
        {
            "xedra_evolved_innawoods", {
                mod_coop::warn,
                translate_marker( "CO-OP: may break.  Inherits Xedra Evolved's scripted powers, which don't apply to the remote player." )
            }
        },
        {
            "bombastic_perks", {
                mod_coop::warn,
                translate_marker( "CO-OP: may break.  Perk leveling is driven by kill events that aren't credited to the remote player, so the joining player gains no perks." )
            }
        },
        {
            "perk_melee_system", {
                mod_coop::warn,
                translate_marker( "CO-OP: may break.  Perk bonuses are applied by scripting that doesn't reach the remote player, so the joining player's bonuses won't apply in shared combat." )
            }
        },
        {
            "package_bionic_professions", {
                mod_coop::warn,
                translate_marker( "CO-OP: may break.  Bionics aren't synced, so a joining player's passive bonuses and active bionic powers won't apply on the host." )
            }
        },
        {
            "extra_mut_scens", {
                mod_coop::warn,
                translate_marker( "CO-OP: may break.  The mutagen-gland system runs only on your own client and won't sync to the remote player." )
            }
        },
        {
            "sorcerer", {
                mod_coop::warn,
                translate_marker( "CO-OP: may break.  Spell effects run only on your own client; only direct damage reaches the shared world." )
            }
        },
        {
            "crazy_cataclysm", {
                mod_coop::warn,
                translate_marker( "CO-OP: may break.  Some scripted effects (e.g. the immortal snail instant-kill) don't apply to the remote player." )
            }
        },
        {
            "deadly_bites", {
                mod_coop::warn,
                translate_marker( "CO-OP: may break.  Infection applies correctly, but its status and death-warning UI may not show for the remote player." )
            }
        },
        {
            "Tamable_Wildlife", {
                mod_coop::warn,
                translate_marker( "CO-OP: may break.  Pet ownership and control across two players is unresolved; the joining player's tamed pets may be uncontrollable." )
            }
        },
        // personal_portal_storms: intentionally NOT listed (treated as ok).
        // It's a default mod ~all co-op players run, and the impact is benign.
        // The mod is just a monster-faction override (storm nether monsters hate
        // "player" = the avatar, neutral to "human" = NPCs).  Portal storms run
        // per-instance and aren't synced anyway, so each player still gets hit by
        // their own local storm — nobody "misses" one.  It's arguably net-positive:
        // without it the host's storm monsters would attack the client's proxy NPC
        // and (with host->proxy HP/effect sync) deal the client phantom damage from
        // a storm not on their screen.  Don't re-add a warn here — it would nag on
        // nearly every co-op world for no real benefit.
        {
            "hunvre", {
                mod_coop::warn,
                translate_marker( "CO-OP: may break.  The scripted intro and the sleep-death mechanic run only on the host and are skipped for the remote player." )
            }
        },
        {
            "MMA", {
                mod_coop::warn,
                translate_marker( "CO-OP: minor issues.  Most works, but on-kill style buffs aren't credited to the remote player." )
            }
        },
    };
    return table;
}

} // namespace

mod_coop mod_coop_status( const std::string &ident )
{
    // Explicit per-mod classification from the audit always wins.
    const auto it = coop_table().find( ident );
    if( it != coop_table().end() ) {
        return it->second.status;
    }
    // Anything else: bundled mods are fine; unvetted third-party mods warn.
    return is_third_party_mod( ident ) ? mod_coop::warn : mod_coop::ok;
}

std::string mod_coop_note( const std::string &ident )
{
    const auto it = coop_table().find( ident );
    if( it != coop_table().end() ) {
        return _( it->second.note );
    }
    return is_third_party_mod( ident ) ? _( third_party_note ) : std::string();
}

std::string mod_coop_info_suffix( const std::string &ident )
{
    if( !is_mp_mode() ) {
        return std::string();
    }
    const std::string note = mod_coop_note( ident );
    if( note.empty() ) {
        return std::string();
    }
    // Red for hard-incompatible, orange (CDDA's c_brown) for warn / third-party.
    const nc_color col = mod_coop_status( ident ) == mod_coop::incompatible ? c_red : c_brown;
    return "\n" + colorize( note, col );
}

} // namespace cata_mp
