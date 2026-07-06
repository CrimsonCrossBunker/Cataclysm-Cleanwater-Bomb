#pragma once
#ifndef CATA_SRC_MP_MOD_COMPAT_H
#define CATA_SRC_MP_MOD_COMPAT_H

#include <string>

// Co-op compatibility classification for content mods.  Derived from the
// 2026-06 mod audit against the fork's sync model (no EOC processing on the
// proxy, client casts/activates in its own local world, single host-centered
// reality bubble, client kills not attributed a killer).  Kept in an MP-only
// file so it never conflicts with upstream mod or worldfactory changes.
namespace cata_mp
{

enum class mod_coop {
    ok,            // safe / data-only in co-op
    warn,          // playable but something breaks or desyncs for the client
    incompatible,  // hard break — must not be enabled in co-op
};

// Classify a mod by its string ident (mod_id::str()).  Audited mods use their
// listed status; other bundled/core mods are ok; unvetted third-party mods
// (loaded from the user mods/ dir, or unknown ids) warn.
mod_coop mod_coop_status( const std::string &ident );

// The co-op note for a mod, or "" when none.  Plain text (no color tags).
std::string mod_coop_note( const std::string &ident );

// Description-panel suffix: empty unless we're in MP mode and the mod carries
// a note.  Returns a leading newline + colorized note ready to append to the
// mod information block.  Called from the SP mod-info renderer.
std::string mod_coop_info_suffix( const std::string &ident );

} // namespace cata_mp

#endif // CATA_SRC_MP_MOD_COMPAT_H
