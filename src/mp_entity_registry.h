#pragma once
#ifndef CATA_SRC_MP_ENTITY_REGISTRY_H
#define CATA_SRC_MP_ENTITY_REGISTRY_H

#include <climits>
#include <cstddef>
#include <cstdint>
#include <memory>

class creature_tracker;
class monster;
class vehicle;

namespace cata_mp
{
// Simulation-owner-only wire identities for one replication session. Native
// UIDs identify saved entities; weak references also distinguish incarnations.
// This registry neither owns native objects nor authorizes incoming messages:
// callers must first validate the enclosing peer/session admission epoch.
class entity_registry
{
    public:
        // The wire decoder uses signed JSON integers. Never wrap or reuse an ID
        // within a session, including when an earlier native object is gone.
        explicit entity_registry( uint32_t limit = INT_MAX );
        ~entity_registry();
        entity_registry( entity_registry && ) noexcept;
        entity_registry &operator=( entity_registry && ) noexcept;
        entity_registry( const entity_registry & ) = delete;
        entity_registry &operator=( const entity_registry & ) = delete;

        uint32_t assign( monster &value );
        uint32_t assign( vehicle &value );
        uint32_t known_id( const monster &value ) const;
        monster *find_monster( uint32_t id, const creature_tracker &tracker ) const;

        // Includes expired entries awaiting amortized pruning, not native owners.
        std::size_t retained_entries() const;

    private:
        struct impl;
        std::unique_ptr<impl> impl_;
};

// Client-only association of a host's wire IDs with local native incarnations.
// A fresh client replication state starts empty, even if native monsters remain.
// begin_sync retires unloaded objects before applying a packet; dead objects
// still in the tracker remain addressable for the existing death-report policy.
class monster_mirrors
{
    public:
        monster_mirrors();
        ~monster_mirrors();
        monster_mirrors( monster_mirrors && ) noexcept;
        monster_mirrors &operator=( monster_mirrors && ) noexcept;
        monster_mirrors( const monster_mirrors & ) = delete;
        monster_mirrors &operator=( const monster_mirrors & ) = delete;

        void begin_sync( const creature_tracker &tracker );
        bool bind( uint32_t id, monster &value );
        uint32_t known_id( const monster &value ) const;
        monster *find( uint32_t id ) const;

    private:
        struct impl;
        std::unique_ptr<impl> impl_;
};
} // namespace cata_mp

#endif // CATA_SRC_MP_ENTITY_REGISTRY_H
