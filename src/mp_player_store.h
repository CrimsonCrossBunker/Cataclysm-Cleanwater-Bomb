#pragma once
#ifndef CATA_SRC_MP_PLAYER_STORE_H
#define CATA_SRC_MP_PLAYER_STORE_H

#include <map>
#include <optional>
#include <string>
#include <vector>

#include "cata_path.h"
#include "character_id.h"
#include "mp_player_identity.h"

namespace cata_mp
{
// OS entropy only; does not advance the simulation RNG. Persist before joining.
player_credentials load_or_create_player_credentials( const cata_path &path );
// Scope capabilities to the connection's canonical endpoint, never a world
// name/realm supplied by the remote host. Moving a server requires an explicit
// trusted profile transfer; a different host must not receive the old secret.
player_credentials load_server_player_credentials( const cata_path &config_directory,
        const std::string &authority );

// Accessed only by the world's simulation owner. The index contains identities,
// not borrowed NPC pointers or copies of every player's inventory. All records
// are written atomically through the repository's save-file writer.
class player_store
{
    public:
        explicit player_store( cata_path world_directory );
        // Missing identity means a new player. Corruption, unsupported schemas
        // and a wrong capability throw; they must never become a fresh actor.
        std::optional<std::string> load( const player_credentials &credentials );
        void save( const player_credentials &credentials, const std::string &character_json );
        // Only an explicit host choice may associate a legacy file with a
        // player. Names are not searched or matched; the original is retained.
        void import_legacy( const player_credentials &credentials, const cata_path &source );
        std::vector<cata_path> legacy_records() const;
        std::vector<character_id> actor_ids();

    private:
        struct owner {
            character_id actor;
            std::string secret;
        };
        cata_path root_;
        bool indexed_ = false;
        std::map<player_id, owner> owners_;
        void index();
        cata_path record_path( const player_id &id ) const;
        void authorize( const player_credentials &credentials ) const;
};
} // namespace cata_mp

#endif // CATA_SRC_MP_PLAYER_STORE_H
