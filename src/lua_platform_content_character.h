#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_CONTENT_CHARACTER_H
#define CATA_SRC_LUA_PLATFORM_CONTENT_CHARACTER_H

#include <cstddef>
#include <cstdint>
#include <functional>
#include <memory>
#include <set>
#include <string>
#include <string_view>

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    #include "lua_platform_sol.h"
#endif

namespace cata::lua_platform
{

class runtime;

/**
 * Native/staged ids supplied by neighbouring content domains.
 *
 * Character and progression definitions intentionally receive predicates
 * rather than reaching into another transaction's private journals.
 */
struct character_content_validation_index {
    std::function<bool( std::string_view )> defines_item;
    std::function<bool( std::string_view )> defines_item_group;
    std::function<bool( std::string_view )> defines_skill;
    std::function<bool( std::string_view )> defines_proficiency;
    std::function<bool( std::string_view )> defines_recipe;
    std::function<bool( std::string_view )> defines_requirement;
    std::function<bool( std::string_view )> defines_material;
    std::function<bool( std::string_view )> defines_json_flag;
    std::function<bool( std::string_view )> defines_damage_type;
    std::function<bool( std::string_view )> defines_vitamin;
    std::function<bool( std::string_view )> defines_weapon_category;
    std::function<bool( std::string_view )> defines_monster;
    std::function<bool( std::string_view )> defines_species;
    std::function<bool( std::string_view )> defines_body_part;
    std::function<bool( std::string_view )> defines_body_graph;
    std::function<bool( std::string_view )> defines_effect_type;
    std::function<bool( std::string_view )> defines_emission;
    std::function<bool( std::string_view )> defines_field_type;
    std::function<bool( std::string_view )> defines_trait;
    std::function<bool( std::string_view )> defines_addiction;
    std::function<bool( std::string_view )> defines_achievement;
    std::function<bool( std::string_view )> defines_trait_group;
    std::function<bool( std::string_view )> defines_attack_vector;
    std::function<bool( std::string_view )> defines_explosion_light;
    std::function<bool( std::string_view )> defines_limb_score;
};

/**
 * Apply order follows the original runtime's native dependency order.  The
 * outer transaction may call each phase at its original insertion point.
 */
enum class character_content_apply_phase : int {
    profession,
    profession_group,
    widget,
    enchantment,
    bionic,
    spell,
    mission_definition,
    profession_item,
    technique,
    martial_art,
    magic_type,
    movement_mode
};

/** Original monolithic rollback order used by the outer transaction. */
enum class character_content_rollback_phase : int {
    movement_mode,
    magic_type,
    technique,
    martial_art,
    mission_definition,
    spell,
    bionic,
    enchantment,
    widget,
    profession_group,
    profession,
    profession_item
};

/**
 * Fingerprint insertion order is deliberately separate from apply order;
 * it matches the legacy monolithic runtime field order exactly.
 */
enum class character_content_fingerprint_phase : int {
    technique,
    martial_art,
    profession,
    profession_group,
    widget,
    enchantment,
    bionic,
    spell,
    mission_definition,
    profession_item,
    magic_type,
    movement_mode
};

class character_content_transaction
{
    public:
        character_content_transaction( std::string owner, std::size_t generation );
        ~character_content_transaction();

        character_content_transaction( const character_content_transaction & ) = delete;
        character_content_transaction &operator=( const character_content_transaction & ) = delete;

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
        void install_lua_api( sol::state &lua, sol::table &ccb, sol::table &content );
        bool register_definition( const sol::object &value, int operation );
#endif

        bool validate( const runtime &owner_runtime, bool check_engine_state,
                       const character_content_validation_index &index,
                       std::string &error ) const;
        bool apply_phase( character_content_apply_phase phase, std::string &error );
        bool validate_finalized( std::string &error ) const;
        void rollback_phase( character_content_rollback_phase phase );
        void rollback_all();
        void commit();
        void seal();
        void discard();
        void append_fingerprint( character_content_fingerprint_phase phase,
                                 std::uint64_t &state ) const;

        bool was_applied() const;

        bool defines_profession( std::string_view id ) const;
        bool defines_profession_group( std::string_view id ) const;
        bool defines_widget( std::string_view id ) const;
        bool defines_enchantment( std::string_view id ) const;
        bool defines_bionic( std::string_view id ) const;
        bool defines_spell( std::string_view id ) const;
        bool defines_mission_definition( std::string_view id ) const;
        bool defines_profession_item_substitution( std::string_view id ) const;
        bool defines_profession_item_bonus( std::string_view id ) const;
        bool defines_technique( std::string_view id ) const;
        bool defines_martial_art( std::string_view id ) const;
        bool defines_magic_type( std::string_view id ) const;
        bool defines_movement_mode( std::string_view id ) const;

        bool find_magic_type_handler( std::string_view magic_type_id,
                                      std::string_view phase,
                                      std::string &handler_id ) const;
        bool find_martial_art_handler( std::string_view martial_art_id,
                                       std::string_view phase,
                                       std::string &handler_id ) const;

    private:
        struct impl;
        std::unique_ptr<impl> pimpl_;
};

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_CONTENT_CHARACTER_H
