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

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_MAPGEN_H
