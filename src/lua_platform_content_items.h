#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_CONTENT_ITEMS_H
#define CATA_SRC_LUA_PLATFORM_CONTENT_ITEMS_H

#include <cstddef>
#include <cstdint>
#include <functional>
#include <memory>
#include <set>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    #include "lua_platform_sol.h"
#endif

namespace cata::lua_platform
{

class runtime;

/**
 * Cross-domain staged definitions consulted while validating item content.
 *
 * These predicates deliberately expose membership only.  Native definitions
 * and the transaction's mutable containers remain private to the Pimpl.
 */
struct items_content_validation_context {
    std::function<bool( std::string_view )> defines_furniture;
    std::function<bool( std::string_view )> defines_explosion_light;
};

struct items_content_staged_ids {
    std::set<std::string> tool_qualities;
    std::set<std::string> skill_displays;
    std::set<std::string> skills;
    std::set<std::string> vitamins;
    std::set<std::string> json_flags;
    std::set<std::string> math_functions;
    std::set<std::string> damage_types;
    std::set<std::string> materials;
    std::set<std::string> proficiencies;
    std::set<std::string> proficiency_categories;
    std::set<std::string> weapon_categories;
    std::set<std::string> ammunition_types;
    std::set<std::string> item_categories;
    std::set<std::string> crafting_categories;
    std::set<std::string> items;
    std::set<std::string> item_groups;
    std::set<std::string> recipes;
    std::set<std::string> requirements;
    std::set<std::string> scent_types;
    std::set<std::string> ammo_effects;
    std::set<std::string> butchery_requirements;
    std::set<std::string> item_actions;
};

enum class items_content_apply_phase : int {
    foundations,
    materials,
    catalogs,
    ammunition_effects,
    metadata,
    item_groups,
    requirements,
    recipe_groups,
    definitions,
    recipes
};

enum class items_content_rollback_phase : int {
    foundations,
    materials,
    catalogs,
    ammunition_effects,
    metadata,
    item_groups,
    requirements,
    recipe_groups,
    definitions,
    recipes
};

enum class items_content_fingerprint_phase : int {
    foundations,
    damage_types,
    materials,
    catalogs,
    ammunition_effects,
    metadata,
    item_groups,
    requirements,
    recipe_groups,
    definitions,
    recipes
};

/**
 * Transactional Platform-Lua definitions for item and crafting content.
 *
 * Apply, rollback, and fingerprint are phased because the engine's existing
 * registries have deliberate dependency ordering with combat and world
 * content.  The outer content transaction remains the phase orchestrator.
 */
class items_content_transaction
{
    public:
        items_content_transaction( std::string owner, std::size_t generation );
        ~items_content_transaction();

        items_content_transaction( const items_content_transaction & ) = delete;
        items_content_transaction &operator=( const items_content_transaction & ) = delete;

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
        void install_lua_api( sol::state &lua, sol::table &ccb, sol::table &content );
        bool register_definition( const sol::object &value, int operation );
#endif

        bool validate( const runtime &owner_runtime, bool check_engine_state,
                       const items_content_validation_context &context,
                       std::string &error ) const;
        bool validate_scaled_requirement_set(
            const std::vector<std::pair<std::string, std::int64_t>> &requirements,
            std::string &error ) const;

        bool apply_phase( items_content_apply_phase phase, std::string &error );
        bool validate_finalized( std::string &error ) const;
        void rollback_phase( items_content_rollback_phase phase );
        void rollback_all();
        void commit();
        void seal();
        void discard();
        void append_fingerprint( items_content_fingerprint_phase phase,
                                 std::uint64_t &state ) const;

        bool was_applied() const;
        bool has_requirements() const;
        bool has_requirement_changes() const;
        items_content_staged_ids staged_ids() const;

        bool defines_tool_quality( std::string_view id ) const;
        bool defines_skill( std::string_view id ) const;
        bool defines_vitamin( std::string_view id ) const;
        bool defines_json_flag( std::string_view id ) const;
        bool defines_math_function( std::string_view id ) const;
        bool defines_damage_type( std::string_view id ) const;
        bool defines_material( std::string_view id ) const;
        bool defines_proficiency( std::string_view id ) const;
        bool defines_item( std::string_view id ) const;
        bool defines_item_group( std::string_view id ) const;
        bool defines_recipe( std::string_view id ) const;
        bool defines_requirement( std::string_view id ) const;
        bool defines_scent_type( std::string_view id ) const;

        bool find_item_handler( std::string_view item_id,
                                std::string_view phase,
                                std::string &handler_id ) const;
        bool find_damage_handler( std::string_view damage_id,
                                  std::string_view phase,
                                  std::string &handler_id ) const;
        bool find_ammo_effect_handler( std::string_view ammo_effect_id,
                                       std::string &handler_id ) const;
        bool find_plant_lifecycle_handler( std::string_view target,
                                           std::string_view target_id,
                                           std::string_view phase,
                                           std::string &handler_id ) const;

    private:
        struct impl;
        std::unique_ptr<impl> pimpl_;
};

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_CONTENT_ITEMS_H
