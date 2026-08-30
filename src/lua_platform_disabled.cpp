#include "lua_platform_mapgen_dispatch.h"

#include "lua_platform_camps.h"
#include "lua_platform_handle.h"
#include "lua_platform_hooks.h"
#include "lua_platform_world_services.h"
#include "lua_platform_world.h"

#include <optional>
#include <string>
#include <string_view>
#include <vector>

#include "dialogue.h"

namespace cata::lua_platform
{

// The disabled build has no Lua runtime or public services table.  Keep the
// installer symbol available so registration remains a complete build-time
// route without manufacturing a legacy or partially functional camp API.
void install_camp_api(
    sol::table &, std::function<game_handle_runtime()>,
    std::function<std::size_t()>, std::function<void()>,
    std::function<void()> )
{
}

// Keep the disabled route in sync with the enabled installer surface without
// creating a public services.map table in a build with no Lua Platform.
void install_map_api(
    sol::table &, std::function<game_handle_runtime()>,
    std::function<std::size_t()>, std::function<void()>,
    std::function<void()> )
{
}

// Keep the relocation move entry point linkable in a disabled build without
// manufacturing a public services.relocation table.
void install_relocation_move_api(
    sol::table &, std::function<game_handle_runtime()>,
    std::function<std::size_t()>, std::function<void()>,
    std::function<void()>, std::function<bool()> )
{
}

native_callback_entity native_callback_entity::from_creature( Creature &value )
{
    static_cast<void>( value );
    return {};
}

native_callback_entity native_callback_entity::from_item( item &value )
{
    static_cast<void>( value );
    return {};
}

native_callback_entity native_callback_entity::from_vehicle( vehicle &value )
{
    static_cast<void>( value );
    return {};
}

native_callback_entity::native_callback_entity( const Character *value )
{
    static_cast<void>( value );
}

native_callback_entity::native_callback_entity( const Creature *value )
{
    static_cast<void>( value );
}

native_callback_entity::native_callback_entity( const item *value )
{
    static_cast<void>( value );
}

native_callback_entity::native_callback_entity( const vehicle *value )
{
    static_cast<void>( value );
}

native_callback_entity_kind native_callback_entity::kind() const noexcept
{
    return native_callback_entity_kind::none;
}

bool native_callback_entity::valid() const noexcept
{
    return false;
}

safe_reference<Creature> native_callback_entity::creature_reference() const noexcept
{
    return {};
}

safe_reference<item> native_callback_entity::item_reference() const noexcept
{
    return {};
}

safe_reference<vehicle> native_callback_entity::vehicle_reference() const noexcept
{
    return {};
}

native_callback_talker snapshot_native_callback_talker( const const_talker &value )
{
    static_cast<void>( value );
    return {};
}

native_callback_value::native_callback_value( const Character *value ) :
    value_( native_callback_entity{} )
{
    static_cast<void>( value );
}

native_callback_value::native_callback_value( const Creature *value ) :
    value_( native_callback_entity{} )
{
    static_cast<void>( value );
}

native_callback_value::native_callback_value( const item *value ) :
    value_( native_callback_entity{} )
{
    static_cast<void>( value );
}

native_callback_value::native_callback_value( const vehicle *value ) :
    value_( native_callback_entity{} )
{
    static_cast<void>( value );
}

native_callback_value::native_callback_value( const const_talker *value ) :
    value_( native_callback_talker{} )
{
    static_cast<void>( value );
}

native_callback_value &native_callback_value::operator=( const Character *value )
{
    static_cast<void>( value );
    value_ = native_callback_entity{};
    return *this;
}

native_callback_value &native_callback_value::operator=( const Creature *value )
{
    static_cast<void>( value );
    value_ = native_callback_entity{};
    return *this;
}

native_callback_value &native_callback_value::operator=( const item *value )
{
    static_cast<void>( value );
    value_ = native_callback_entity{};
    return *this;
}

native_callback_value &native_callback_value::operator=( const vehicle *value )
{
    static_cast<void>( value );
    value_ = native_callback_entity{};
    return *this;
}

native_callback_value &native_callback_value::operator=( const const_talker *value )
{
    static_cast<void>( value );
    value_ = native_callback_talker{};
    return *this;
}

native_hook_result dispatch_native_hook_result(
    std::string_view, const native_callback_arguments & )
{
    return {};
}

bool dispatch_native_hook(
    std::string_view, const native_callback_arguments & )
{
    return true;
}

bool dispatch_avatar_fatal( Character &, const Creature * )
{
    return true;
}

bool dispatch_npc_fatal( Character &, const Creature * )
{
    return true;
}

void register_npc_handle_identity( npc & )
{
}

void retire_npc_handle_identity( npc & )
{
}

void register_camp_handle_identity( basecamp & )
{
}

void retire_camp_handle_identity( const basecamp & )
{
}

bool has_native_hook( std::string_view )
{
    return false;
}

bool native_hook_supports_result_field( std::string_view, std::string_view )
{
    return false;
}

bool native_hook_contract_exists( std::string_view )
{
    return false;
}

std::vector<std::string> collect_native_mapgen_factory_usages(
    const std::vector<std::string> & )
{
    return {};
}

void dispatch_native_monster_spawn(
    const Creature &, std::string_view )
{
}

void dispatch_native_npc_spawn(
    const Character &, std::string_view )
{
}

std::string dispatch_character_display_skill_info(
    const Character &, std::string_view )
{
    return {};
}

bool dispatch_character_display_skill_action(
    const Character &, std::string_view, std::string_view )
{
    return false;
}

native_hook_result dispatch_native_dialogue_hook(
    std::string_view, const const_talker &, const const_talker &,
    std::string_view, std::optional<std::string_view>,
    bool, std::optional<std::string_view> )
{
    return {};
}

void clear_dialogue_response_callbacks()
{
}

void begin_dialogue_session( dialogue & )
{
}

void end_dialogue_session( dialogue & ) noexcept
{
}

std::optional<std::string> dialogue_dynamic_line(
    dialogue &, const talk_topic & )
{
    return std::nullopt;
}

void apply_lua_dialogue_speaker_effects(
    dialogue &, const talk_topic & )
{
}

bool gen_lua_dialogue_responses(
    dialogue &, const talk_topic & )
{
    return false;
}

void extend_lua_dialogue_responses(
    dialogue &, const talk_topic & )
{
}

talk_topic apply_lua_dialogue_response(
    dialogue &, std::uint64_t, const talk_topic &fallback, const bool )
{
    return fallback;
}

bool begin_native_npc_interaction(
    const Character &, const Character & )
{
    return true;
}

bool allow_native_monster_interaction(
    const Character &, const Creature & )
{
    return true;
}

bool allow_native_elevator_use(
    const Character &, const native_callback_point &,
    const native_callback_point & )
{
    return true;
}

std::vector<native_menu_entry> collect_native_hook_menu_entries(
    std::string_view, const native_callback_arguments & )
{
    return {};
}

void dispatch_mapgen_postprocess( mapgendata & )
{
}

bool dispatch_mapgen_generate( mapgendata & )
{
    return false;
}

} // namespace cata::lua_platform
