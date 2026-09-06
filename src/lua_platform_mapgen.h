#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_MAPGEN_H
#define CATA_SRC_LUA_PLATFORM_MAPGEN_H

#include <cstddef>
#include <cstdint>
#include <functional>
#include <memory>
#include <optional>
#include <string>
#include <vector>

#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_sol.h"
#include "type_id.h"

class mapgendata;
struct platform_mapgen_transaction_report;

namespace cata::lua_platform
{

/**
 * A value-only identity for one registered update-mapgen definition.
 *
 * The token retains only the typed update-mapgen id and runtime/world
 * generation snapshots.  It has no target footprint or native pointer.
 */
class mapgen_update_token
{
    public:
        mapgen_update_token() = default;
        mapgen_update_token( const update_mapgen_id &id,
                             const game_handle_runtime &runtime,
                             std::size_t world_generation );

        const update_mapgen_id &native_id() const noexcept;
        script_game_id id() const;
        std::size_t runtime_generation() const noexcept;
        std::size_t world_generation() const noexcept;
        bool owner_is_current() const noexcept;
        bool runtime_matches( const game_handle_runtime &runtime ) const noexcept;
        bool world_matches( std::size_t world_generation ) const noexcept;
        std::string to_string() const;

        friend bool operator==( const mapgen_update_token &lhs,
                                const mapgen_update_token &rhs ) noexcept;

    private:
        update_mapgen_id id_;
        game_handle_runtime runtime_;
        std::size_t world_generation_ = 0;
};

std::optional<game_handle_error> validate_mapgen_update_token(
    const mapgen_update_token &token,
    const game_handle_runtime &runtime_generation,
    std::size_t world_generation );

/**
 * A callback-scoped view of one OMT mapgen operation.
 *
 * The wrapper deliberately does not expose mapgendata, map, or any native
 * pointer to Lua.  Every coordinate is restricted to the current 24x24 OMT,
 * mutations require the active Platform write boundary, and retained wrappers
 * stop working as soon
 * as their callback returns.
 */
class script_mapgen_context
{
    public:
        static constexpr int map_width = 24;
        static constexpr int map_height = 24;
        static constexpr std::size_t maximum_operations = 8192;

        script_mapgen_context( mapgendata &data, bool allow_write,
                               std::uint64_t deterministic_seed,
                               std::string platform_mod_id = {} );

        bool valid() const noexcept;
        void invalidate() noexcept;
        // Native-only publication after the map transaction commits. Never exposed to Lua.
        bool publish_deferred( const platform_mapgen_transaction_report &report );
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
        void set_item_faction( int x1, int y1, int x2, int y2,
                               const std::string &faction );
        void place_item( int x, int y, const std::string &item_id,
                         int quantity, int charges,
                         const std::string &faction_id );
        void place_item_group( int x1, int y1, int x2, int y2,
                               const std::string &group_id, int chance,
                               const std::string &faction_id );
        void place_liquid( int x, int y, const std::string &item_id,
                           int charges );
        void place_toilet( int x, int y, int charges );
        bool add_field( int x, int y, const std::string &field_id,
                        int intensity, std::int64_t age_turns );
        bool remove_field( int x, int y, const std::string &field_id );
        void place_vending_machine( int x, int y,
                                    const std::string &item_group_id,
                                    bool reinforced, bool lootable,
                                    bool powered, bool networked );
        void place_gas_pump( int x, int y, int charges,
                             const std::string &fuel_id );
        void place_monster_group( int x1, int y1, int x2, int y2,
                                  const std::string &group_id, int chance,
                                  double density, bool individual,
                                  bool friendly, const std::string &name,
                                  bool mission_target );
        void place_monster( int x, int y, const std::string &monster_id,
                            int count, bool friendly,
                            const std::string &name, bool mission_target );
        void place_corpse( int x, int y, const std::string &monster_id,
                           int age_days );
        void place_corpse_from_group( int x, int y,
                                      const std::string &group_id,
                                      int age_days );
        void make_rubble( int x, int y, const std::string &furniture_id,
                          bool items, const std::string &floor_terrain_id,
                          bool overwrite );
        bool place_computer( int x, int y, const std::string &name,
                             int security, const std::string &access_denied,
                             bool mission_target );
        void add_computer_option( int x, int y, const std::string &name,
                                  const std::string &action, int security );
        void add_computer_failure( int x, int y,
                                   const std::string &failure );
        void add_computer_eoc( int x, int y, const std::string &eoc_id );
        void set_computer_access_handler( int x, int y,
                                          const std::string &handler_id );
        void add_computer_chat_topic( int x, int y,
                                      const std::string &topic_id );
        void place_sealed_item( int x, int y,
                                const std::string &furniture_id,
                                const std::string &item_id, int quantity,
                                int charges, const std::string &item_group_name,
                                int item_group_chance,
                                const std::string &faction_id );
        void place_sign( int x, int y, const std::string &text,
                         const std::string &furniture_id );
        void set_graffiti( int x, int y, const std::string &text );
        [[noreturn]] void place_zone( int x1, int y1, int x2, int y2,
                                      const std::string &zone_type,
                                      const std::string &faction,
                                      const std::string &name,
                                      const std::string &filter );
        [[noreturn]] std::int64_t place_npc( int x, int y,
                                             const std::string &template_id,
                                             const std::string &unique_id );
        [[noreturn]] std::int64_t place_npc_configured(
            int x, int y, const std::string &template_id,
            const std::string &unique_id,
            const std::vector<std::string> &traits,
            bool mission_target );
        [[noreturn]] bool place_vehicle( int x, int y,
                                         const std::string &prototype_or_group_id,
                                         int rotation_degrees, int fuel_percent,
                                         int status, const std::string &faction );
        [[noreturn]] void apply_faction_ownership( int x1, int y1, int x2, int y2,
                const std::string &faction );
        [[noreturn]] void transform( int x1, int y1, int x2, int y2,
                                     const std::string &transform_id );
        [[noreturn]] std::size_t remove_vehicles( int x1, int y1, int x2, int y2,
                const std::vector<std::string> &prototype_ids );
        [[noreturn]] std::size_t remove_npcs( const std::string &template_id,
                                              const std::string &unique_id );
        [[noreturn]] void remove_all( int x1, int y1, int x2, int y2 );
        void queue_point( const std::string &name, int x, int y );
        void queue_npc( int x, int y, const std::string &template_id,
                        const std::string &unique_id );
        void queue_zone( int x1, int y1, int x2, int y2,
                         const std::string &zone_type, const std::string &faction,
                         const std::string &name, const std::string &filter );

        void fill_groundcover();
        [[noreturn]] void nest( const std::string &id, int x, int y );
        [[noreturn]] void generate( const std::string &id );

    private:
        struct context_state;

        std::shared_ptr<context_state> state_;

        context_state &require_state() const;
        context_state &require_write_state() const;
        [[noreturn]] void reject_external_mutation() const;
        void consume( std::size_t amount ) const;
        std::uint64_t next_random();
};

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
void install_mapgen_service_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

void install_script_mapgen_context_api( sol::state &lua );
#endif

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_MAPGEN_H
