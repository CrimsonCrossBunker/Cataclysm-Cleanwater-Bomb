#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_HOOKS_H
#define CATA_SRC_LUA_PLATFORM_HOOKS_H

#include <cstdint>
#include <cstddef>
#include <optional>
#include <string>
#include <string_view>
#include <type_traits>
#include <utility>
#include <variant>
#include <vector>

#include "coordinates.h"
#include "lua_platform_state.h"
#include "safe_reference.h"

class Character;
class Creature;
class const_talker;
class item;
class vehicle;
class mapgendata;
struct dialogue;
struct talk_topic;

namespace cata::lua_platform
{

struct native_callback_point {
    std::string coordinate_space;
    tripoint_rel_ms pos;
};

struct native_callback_id {
    std::string kind;
    std::string value;
};

struct native_callback_mission {
    int uid = 0;
    std::size_t identity_generation = 0;
};

enum class native_callback_entity_kind : int {
    none,
    creature,
    item,
    vehicle
};

/**
 * A synchronous native entity reference used while a hook is dispatched.
 *
 * This value deliberately stores only safe references.  The Lua-facing
 * conversion creates a GameHandle for the receiving Platform runtime, so a
 * callback argument never carries a borrowed native pointer across the
 * dispatch boundary.
 */
class native_callback_entity final
{
    public:
        native_callback_entity() = default;

        static native_callback_entity from_creature( Creature &value );
        static native_callback_entity from_item( item &value );
        static native_callback_entity from_vehicle( vehicle &value );

        // These constructors make existing engine call sites safe without
        // storing the transient pointer in the payload object.
        native_callback_entity( const Character *value );
        native_callback_entity( const Creature *value );
        native_callback_entity( const item *value );
        native_callback_entity( const vehicle *value );

        native_callback_entity_kind kind() const noexcept;
        bool valid() const noexcept;
        safe_reference<Creature> creature_reference() const noexcept;
        safe_reference<item> item_reference() const noexcept;
        safe_reference<vehicle> vehicle_reference() const noexcept;

    private:
        native_callback_entity_kind kind_ = native_callback_entity_kind::none;
        safe_reference<Creature> creature_;
        safe_reference<item> item_;
        safe_reference<vehicle> vehicle_;
};

/** Detached non-entity talker data, or a safe entity reference when present. */
struct native_callback_talker {
    bool present = false;
    std::optional<native_callback_entity> entity;
    std::string kind;
    std::string name;
    std::string coordinate_space = "abs_ms";
    tripoint_abs_ms pos;
    // Captured identity for callback/session liveness checks.  It is not a
    // lookup key exposed to Lua; the receiving runtime still creates the
    // generation-safe GameHandle from the safe entity reference.
    std::optional<std::int64_t> stable_id;
};

native_callback_talker snapshot_native_callback_talker( const const_talker &value );

class native_callback_value final
{
    public:
        using storage_type = std::variant <
                                  bool, std::int64_t, double, std::string,
                                  native_callback_entity, native_callback_point,
                                  native_callback_id, std::vector<std::string>,
                                  native_callback_talker, native_callback_mission >;

        native_callback_value() = default;
        native_callback_value( bool value ) : value_( value ) {}
        template<typename T,
                 std::enable_if_t<std::is_integral_v<T> &&
                                  !std::is_same_v<std::remove_cv_t<T>, bool>, int> = 0>
        native_callback_value( T value ) : value_( static_cast<std::int64_t>( value ) ) {}
        native_callback_value( double value ) : value_( value ) {}
        native_callback_value( std::string value ) : value_( std::move( value ) ) {}
        native_callback_value( std::string_view value ) : value_( std::string( value ) ) {}
        native_callback_value( const char *value ) : value_( std::string( value ? value : "" ) ) {}
        native_callback_value( native_callback_entity value ) : value_( std::move( value ) ) {}
        native_callback_value( native_callback_point value ) : value_( std::move( value ) ) {}
        native_callback_value( native_callback_id value ) : value_( std::move( value ) ) {}
        native_callback_value( std::vector<std::string> value ) : value_( std::move( value ) ) {}
        native_callback_value( native_callback_talker value ) : value_( std::move( value ) ) {}
        native_callback_value( native_callback_mission value ) : value_( std::move( value ) ) {}

        native_callback_value( const Character *value );
        native_callback_value( const Creature *value );
        native_callback_value( const item *value );
        native_callback_value( const vehicle *value );
        native_callback_value( const const_talker *value );

        native_callback_value &operator=( const Character *value );
        native_callback_value &operator=( const Creature *value );
        native_callback_value &operator=( const item *value );
        native_callback_value &operator=( const vehicle *value );
        native_callback_value &operator=( const const_talker *value );

        const storage_type &storage() const noexcept {
            return value_;
        }

    private:
        storage_type value_;
};

template<std::size_t... Index>
constexpr bool native_callback_storage_has_no_pointers(
    std::index_sequence<Index...> )
{
    return ( ... &&
             !std::is_pointer_v<std::variant_alternative_t<
                 Index, native_callback_value::storage_type>> );
}

static_assert( native_callback_storage_has_no_pointers( std::make_index_sequence<
                  std::variant_size_v<native_callback_value::storage_type>> {} ) );

struct native_callback_argument {
    std::string name;
    native_callback_value value;
};

using native_callback_arguments = std::vector<native_callback_argument>;

struct native_menu_entry {
    std::string id;
    std::string label;
    bool enabled = true;
};

struct native_hook_result {
    bool allowed = true;
    bool handled = false;
    std::string text;
    std::optional<std::string> result;
    std::vector<std::string> results;
    std::vector<native_menu_entry> menu_entries;
};

/** Return whether a named Platform hook is part of the native result contract. */
bool native_hook_contract_exists( std::string_view name );

/** Return whether a named Platform hook accepts a specific aggregate field. */
bool native_hook_supports_result_field( std::string_view name,
                                        std::string_view field );

native_hook_result dispatch_native_hook_result(
    std::string_view name,
    const native_callback_arguments &arguments = {} );
bool dispatch_native_hook(
    std::string_view name,
    const native_callback_arguments &arguments = {} );
bool dispatch_avatar_fatal( Character &character, const Creature *killer );
bool dispatch_npc_fatal( Character &character, const Creature *killer );
bool has_native_hook( std::string_view name );
std::vector<std::string> collect_native_mapgen_factory_usages(
    const std::vector<std::string> &candidates );
void dispatch_native_monster_spawn(
    const Creature &monster, std::string_view source );
void dispatch_native_npc_spawn(
    const Character &npc, std::string_view source );
std::string dispatch_character_display_skill_info(
    const Character &character, std::string_view skill );
bool dispatch_character_display_skill_action(
    const Character &character, std::string_view skill,
    std::string_view action );
native_hook_result dispatch_native_dialogue_hook(
    std::string_view name, const const_talker &speaker,
    const const_talker &interlocutor, std::string_view topic,
    std::optional<std::string_view> option = std::nullopt,
    bool by_radio = false,
    std::optional<std::string_view> reason = std::nullopt );
void clear_dialogue_response_callbacks();
void begin_dialogue_session( ::dialogue &d );
void end_dialogue_session( ::dialogue &d ) noexcept;
std::optional<std::string> dialogue_dynamic_line(
    ::dialogue &d, const talk_topic &topic );
void apply_lua_dialogue_speaker_effects(
    ::dialogue &d, const talk_topic &topic );
bool gen_lua_dialogue_responses(
    ::dialogue &d, const talk_topic &topic );
void extend_lua_dialogue_responses(
    ::dialogue &d, const talk_topic &topic );
talk_topic apply_lua_dialogue_response(
    ::dialogue &d, std::uint64_t response_id, const talk_topic &fallback,
    bool trial_success );
bool begin_native_npc_interaction(
    const Character &avatar, const Character &npc );
bool allow_native_monster_interaction(
    const Character &avatar, const Creature &monster );
bool allow_native_elevator_use(
    const Character &character,
    const native_callback_point &position,
    const native_callback_point &destination );
std::vector<native_menu_entry> collect_native_hook_menu_entries(
    std::string_view name,
    const native_callback_arguments &arguments = {} );

enum class script_hook_mode : int {
    observe,
    intercept
};

struct script_hook_spec {
    script_hook_spec( std::string_view name_in, script_hook_mode mode_in,
                      std::vector<std::string_view> payload_fields_in,
                      std::vector<std::string_view> result_fields_in = {} ) :
        name( name_in ),
        mode( mode_in ),
        payload_fields( std::move( payload_fields_in ) ),
        result_fields( std::move( result_fields_in ) ) {}

    std::string_view name;
    script_hook_mode mode = script_hook_mode::observe;
    std::vector<std::string_view> payload_fields;
    std::vector<std::string_view> result_fields;
};

const std::vector<script_hook_spec> &script_hook_specs();
const script_hook_spec *find_script_hook_spec( std::string_view name );
bool script_hook_supports_result( const script_hook_spec &spec,
                                  std::string_view field );
std::string_view script_hook_mode_name( script_hook_mode mode );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_HOOKS_H
