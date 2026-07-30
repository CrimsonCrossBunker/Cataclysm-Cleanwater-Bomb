#pragma once
#ifndef CATA_SRC_CATALUA_UI_CALLBACKS_H
#define CATA_SRC_CATALUA_UI_CALLBACKS_H

#include <cstddef>
#include <cstdint>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

namespace cata::lua_ui
{

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

struct script_callback_method_spec {
    std::string_view name;
    bool decision = false;
    bool consuming = false;
};

struct script_callback_kind_spec {
    std::string_view kind;
    std::string_view target_id_kind;
    std::vector<script_callback_method_spec> methods;
};

const std::vector<script_callback_kind_spec> &script_callback_kind_specs();
const script_callback_kind_spec *find_script_callback_kind_spec( std::string_view kind );
const script_callback_method_spec *find_script_callback_method_spec(
    const script_callback_kind_spec &kind, std::string_view method );

struct script_callback_registration {
    std::uint64_t id = 0;
    std::string kind;
    std::string target;
    std::vector<std::string> methods;
    int priority = 0;
    std::size_t source_index = 0;
    std::uint64_t sequence = 0;
    bool once = false;
};

class script_callback_registry
{
    public:
        static constexpr std::size_t maximum_registrations = 1024;
        static constexpr std::size_t maximum_registrations_per_target = 64;
        static constexpr int minimum_priority = -10000;
        static constexpr int maximum_priority = 10000;

        std::uint64_t subscribe(
            std::string kind, std::string target,
            std::vector<std::string> methods, int priority,
            std::size_t source_index, bool once );
        bool unsubscribe( std::uint64_t id, std::size_t source_index );
        bool unsubscribe_unchecked( std::uint64_t id );
        std::vector<script_callback_registration> matching(
            std::string_view kind, std::string_view target,
            std::string_view method ) const;
        bool contains( std::uint64_t id ) const;
        std::size_t size() const;
        const std::vector<script_callback_registration> &all() const;
        void clear();

    private:
        std::vector<script_callback_registration> registrations_;
        std::uint64_t next_id_ = 1;
        std::uint64_t next_sequence_ = 1;
};

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_CALLBACKS_H
