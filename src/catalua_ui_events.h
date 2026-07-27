#pragma once
#ifndef CATA_SRC_CATALUA_UI_EVENTS_H
#define CATA_SRC_CATALUA_UI_EVENTS_H

#include <cstddef>
#include <cstdint>
#include <string>
#include <string_view>
#include <vector>

namespace cata::lua_ui
{

struct script_event_subscription {
    std::uint64_t id = 0;
    std::string event_name;
    int priority = 0;
    std::size_t source_index = 0;
    std::uint64_t sequence = 0;
    bool once = false;
};

class script_event_registry
{
    public:
        static constexpr std::size_t maximum_subscriptions = 1024;
        static constexpr int minimum_priority = -10000;
        static constexpr int maximum_priority = 10000;

        std::uint64_t subscribe( std::string event_name, int priority,
                                 std::size_t source_index, bool once );
        bool unsubscribe( std::uint64_t id, std::size_t source_index );
        bool unsubscribe_unchecked( std::uint64_t id );
        std::vector<script_event_subscription> matching( std::string_view event_name ) const;
        bool contains( std::uint64_t id ) const;
        std::size_t size() const;
        void clear();

    private:
        std::vector<script_event_subscription> subscriptions_;
        std::uint64_t next_id_ = 1;
        std::uint64_t next_sequence_ = 1;
};

bool is_safe_custom_event_segment( std::string_view value );
bool is_lifecycle_event_name( std::string_view value );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_EVENTS_H
