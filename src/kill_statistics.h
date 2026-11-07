#pragma once
#ifndef CATA_SRC_KILL_STATISTICS_H
#define CATA_SRC_KILL_STATISTICS_H

#include <cstdint>
#include <map>
#include <string>
#include <vector>

#include "type_id.h"

class JsonObject;
class JsonOut;

// Owned by a Character. Event delivery and player/follower attribution live in
// kill_tracker; loading or projecting these values never awards XP or practice.
class kill_statistics
{
    public:
        void reset( const std::map<mtype_id, int> &monsters,
                    const std::vector<std::string> &characters );
        void record_monster( const mtype_id &type );
        void record_character( const std::string &name );
        void take_over( kill_statistics &previous );
        int kill_count( const mtype_id &type ) const;
        int kill_count( const species_id &species ) const;
        int guilt_kill_count( const mtype_id &type ) const;
        int monster_kill_count() const;
        int npc_kill_count() const;
        int total_kill_count() const;
        void clear();
        const std::map<mtype_id, int> &monster_kills() const {
            return kills;
        }
        const std::vector<std::string> &character_kills() const {
            return npc_kills;
        }
        std::uint64_t revision() const {
            return revision_;
        }
        void serialize( JsonOut &out ) const;
        void deserialize( const JsonObject &data );

    private:
        std::map<mtype_id, int> kills;
        std::vector<std::string> npc_kills;
        // Presentation invalidation only; not part of a save or gameplay RNG.
        // NOLINTNEXTLINE(cata-serialize)
        std::uint64_t revision_ = 1;
        void changed();
};

#endif // CATA_SRC_KILL_STATISTICS_H
