#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_CONTENT_CREATURES_H
#define CATA_SRC_LUA_PLATFORM_CONTENT_CREATURES_H

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
 * Native ids already staged by neighbouring content domains.
 *
 * Creature definitions contain references into items, damage, and other
 * catalogues.  The component intentionally receives predicates instead of
 * exposing any of those mutable registries or their native objects.
 */
struct creatures_content_validation_index {
    std::function<bool( std::string_view )> defines_item;
    std::function<bool( std::string_view )> defines_material;
    std::function<bool( std::string_view )> defines_damage_type;
    std::function<bool( std::string_view )> defines_skill;
    std::function<bool( std::string_view )> defines_proficiency;
    std::function<bool( std::string_view )> defines_vitamin;
    std::function<bool( std::string_view )> defines_trait;
    std::function<bool(
        const std::vector<std::pair<std::string, std::int64_t>> &,
        std::string & )> validate_scaled_requirements;
};

/**
 * Apply order for the creature/content registries.
 *
 * These are deliberately one native registry at a time.  The outer content
 * transaction interleaves them with the neighbouring domains at the same
 * points as the original runtime apply pass.
 */
enum class creatures_content_apply_phase : int {
    foundations,
    mutation,
    behavior,
    effect_type,
    sub_body_part,
    wound_type,
    body_part,
    anatomy,
    body_graph,
    field_type,
    monster_attack,
    weakpoint_set,
    morale_type,
    disease_type,
    wound_fix,
    monster,
    finalize
};

/**
 * Reverse registry order used when one phase fails or a candidate is
 * discarded.  Each call only restores its own undo journal and is idempotent;
 * the outer transaction can therefore place these calls around other domain
 * journals without losing the original rollback ordering.
 */
enum class creatures_content_rollback_phase : int {
    monster,
    wound_fix,
    disease_type,
    morale_type,
    weakpoint_set,
    monster_attack,
    field_type,
    body_graph,
    anatomy,
    body_part,
    wound_type,
    sub_body_part,
    effect_type,
    behavior,
    mutation,
    mutation_category,
    connect_group,
    mutation_type,
    monster_faction,
    emission,
    species,
    monster_flag,
    finalize
};

/**
 * Fingerprint insertion points matching the original runtime's global field
 * order.  Unlike apply, this order is intentionally not just the dependency
 * order: mutation and the foundation registries are separated by unrelated
 * content in the runtime fingerprint.
 */
enum class creatures_content_fingerprint_phase : int {
    foundations,
    mutation,
    behavior,
    effect_type,
    sub_body_part,
    wound_type,
    body_part,
    anatomy,
    monster,
    field_type,
    monster_attack,
    weakpoint_set,
    morale_type,
    disease_type,
    wound_fix
};

/**
 * Transactional Lua-first definitions for the creature and combat domains.
 *
 * The implementation owns all definition data behind a Pimpl.  Handles are
 * generation checked and become unusable after commit/discard, while native
 * registries are touched only during the explicit apply phases.
 */
class creatures_content_transaction
{
    public:
        creatures_content_transaction( std::string owner, std::size_t generation );
        ~creatures_content_transaction();

        creatures_content_transaction( const creatures_content_transaction & ) = delete;
        creatures_content_transaction &operator=(
            const creatures_content_transaction & ) = delete;

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
        void install_lua_api( sol::state &lua, sol::table &ccb, sol::table &content );
        bool register_definition( const sol::object &value, int operation );
#endif

        bool validate( const runtime &owner_runtime, bool check_engine_state,
                       const creatures_content_validation_index &index,
                       std::string &error ) const;
        bool apply_phase( creatures_content_apply_phase phase, std::string &error );
        bool validate_finalized( std::string &error ) const;
        void prepare_rollback( bool external_requirement_changes );
        void rollback_phase( creatures_content_rollback_phase phase );
        void rollback_all();
        void commit();
        void seal();
        void discard();
        void append_fingerprint( creatures_content_fingerprint_phase phase,
                                 std::uint64_t &state ) const;

        bool was_applied() const;
        std::set<std::string> staged_field_type_ids() const;

        bool defines_behavior( std::string_view id ) const;
        bool defines_effect_type( std::string_view id ) const;
        bool defines_monster_attack( std::string_view id ) const;
        bool defines_weakpoint_set( std::string_view id ) const;
        bool defines_field_type( std::string_view id ) const;
        bool defines_sub_body_part( std::string_view id ) const;
        bool defines_body_part( std::string_view id ) const;
        bool defines_wound( std::string_view id ) const;
        bool defines_wound_fix( std::string_view id ) const;
        bool defines_anatomy( std::string_view id ) const;
        bool defines_body_graph( std::string_view id ) const;
        bool defines_monster( std::string_view id ) const;
        bool defines_morale_type( std::string_view id ) const;
        bool defines_disease_type( std::string_view id ) const;
        bool defines_monster_flag( std::string_view id ) const;
        bool defines_species( std::string_view id ) const;
        bool defines_emission( std::string_view id ) const;
        bool defines_monster_faction( std::string_view id ) const;
        bool defines_mutation_type( std::string_view id ) const;
        bool defines_connect_group( std::string_view id ) const;
        bool defines_mutation_category( std::string_view id ) const;
        bool defines_mutation( std::string_view id ) const;

        bool find_behavior_handler( std::string_view behavior_id,
                                    std::string_view phase,
                                    std::string &handler_id ) const;
        bool find_monster_attack_handler( std::string_view monster_id,
                                          std::string_view attack_id,
                                          std::string &handler_id ) const;
        bool find_monster_death_handler( std::string_view monster_id,
                                         std::string &handler_id ) const;
        bool find_emission_handler( std::string_view emission_id,
                                    std::string &handler_id ) const;
        bool find_weakpoint_handler( std::string_view weakpoint_set_id,
                                     std::string_view weakpoint_id,
                                     std::size_t effect_index,
                                     std::string &handler_id ) const;

    private:
        struct impl;
        std::unique_ptr<impl> pimpl_;
};

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_CONTENT_CREATURES_H
