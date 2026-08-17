#pragma once
#ifndef CATA_SRC_CATALUA_UI_MAPGEN_H
#define CATA_SRC_CATALUA_UI_MAPGEN_H

#include <cstddef>
#include <cstdint>
#include <memory>
#include <optional>
#include <string>

#include "catalua_bindings_values.h"

class mapgendata;

namespace cata::lua_ui
{

/**
 * A callback-scoped view of one OMT mapgen operation.
 *
 * The wrapper deliberately does not expose mapgendata, map, or any native
 * pointer to Lua.  Every coordinate is restricted to the current 24x24 OMT,
 * mutations are capability-gated, and retained wrappers stop working as soon
 * as their callback returns.
 */
class script_mapgen_context
{
    public:
        static constexpr int map_width = 24;
        static constexpr int map_height = 24;
        static constexpr std::size_t maximum_operations = 8192;
        static constexpr std::size_t maximum_nested_generators = 32;
        static constexpr std::size_t maximum_full_generators = 4;

        script_mapgen_context( mapgendata &data, bool allow_write,
                               std::uint64_t deterministic_seed );

        bool valid() const noexcept;
        void invalidate() noexcept;
        std::size_t operations_used() const;
        std::size_t operations_remaining() const;

        script_game_id id() const;
        script_game_id north() const;
        script_game_id east() const;
        script_game_id south() const;
        script_game_id west() const;
        script_game_id neast() const;
        script_game_id seast() const;
        script_game_id swest() const;
        script_game_id nwest() const;
        script_game_id above() const;
        script_game_id below() const;
        script_game_id get_nesw( int index ) const;

        int zlevel() const;
        int get_direction( int index ) const;
        void set_dir( int index, int value );
        int get_rotation() const;
        std::string get_rot_suffix() const;

        int random_int( int minimum, int maximum );
        bool random_chance( std::uint64_t numerator,
                            std::uint64_t denominator );

        script_game_id terrain_at( int x, int y ) const;
        std::optional<script_game_id> furniture_at( int x, int y ) const;
        std::optional<script_game_id> trap_at( int x, int y ) const;
        bool set_terrain( int x, int y, const script_game_id &id );
        bool set_furniture( int x, int y,
                            const std::optional<script_game_id> &id );
        bool set_trap( int x, int y,
                       const std::optional<script_game_id> &id );

        bool set_terrain_id( int x, int y, const std::string &id );
        bool set_furniture_id( int x, int y, const std::string &id );
        bool set_trap_id( int x, int y, const std::string &id );
        void reset( const std::string &terrain_id );
        void place_item( int x, int y, const std::string &item_id,
                         int quantity, int charges,
                         const std::string &faction_id );
        void place_item_group( int x1, int y1, int x2, int y2,
                               const std::string &group_id, int chance,
                               const std::string &faction_id );
        void place_liquid( int x, int y, const std::string &item_id,
                           int charges );
        void place_toilet( int x, int y, int charges );
        void place_sign( int x, int y, const std::string &text,
                         const std::string &furniture_id );
        void place_zone( int x1, int y1, int x2, int y2,
                         const std::string &zone_type,
                         const std::string &faction,
                         const std::string &name,
                         const std::string &filter );
        std::int64_t place_npc( int x, int y,
                                const std::string &template_id,
                                const std::string &unique_id );
        bool place_vehicle( int x, int y,
                            const std::string &prototype_or_group_id,
                            int rotation_degrees, int fuel_percent,
                            int status, const std::string &faction );
        void apply_faction_ownership( int x1, int y1, int x2, int y2,
                                      const std::string &faction );

        void fill_groundcover();
        void nest( const std::string &id, int x, int y );
        void generate( const std::string &id );

    private:
        struct context_state;
        std::shared_ptr<context_state> state_;

        context_state &require_state() const;
        context_state &require_write_state() const;
        void consume( std::size_t amount ) const;
        std::uint64_t next_random();
};

#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI
void install_script_mapgen_context_api( sol::state &lua );
#endif

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_MAPGEN_H
