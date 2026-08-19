#pragma once
#ifndef CATA_SRC_EVENT_STATISTICS_H
#define CATA_SRC_EVENT_STATISTICS_H

#include <memory>
#include <string>
#include <string_view>
#include <unordered_map>
#include <utility>
#include <vector>

#include "clone_ptr.h"
#include "translation.h"
#include "type_id.h"

class JsonObject;
class cata_variant;
class event_statistic;
class event_transformation;
class event_multiset;
class stats_tracker;
class stats_tracker_state;
enum class cata_variant_type : int;
enum class monotonically : int;
template<typename T>
class generic_factory;

namespace cata::lua_platform
{
class content_transaction;
namespace detail
{
struct event_statistic_native_definition;
struct event_transformation_native_definition;
event_statistic make_event_statistic( const event_statistic_native_definition &definition );
event_transformation make_event_transformation(
    const event_transformation_native_definition &definition );
} // namespace detail
}

using event_fields_type = std::unordered_map<std::string, cata_variant_type>;

// event_transformations and event_statistics are both functions of events.
// They are intended to be calculated via a stats_tracker object.
// They can be defined in json, and are useful therein for the creation of
// scores and achievements.
// An event_transformation yields an event_multiset, while an event_statistic
// yields a single cata_variant value (usually an int).
// The values can be accessed in two ways:
// - By direct calculation, by calling stats_tracker::get_events or
//   stats_tracker::value_of.
// - On a 'live updating' basis, by calling stats_tracker::add_watcher.
//
// For details on how watching values is implemented, see the comment in
// event_statistics.cpp.

// A transformation from one multiset of events to another
class event_transformation
{
    public:
        event_multiset value( stats_tracker & ) const;
        std::unique_ptr<stats_tracker_state> watch( stats_tracker & ) const;

        void load( const JsonObject &, std::string_view );
        void check() const;
        static void load_transformation( const JsonObject &, const std::string & );
        static void finalize_all();
        static void check_consistency();
        static const std::vector<event_transformation> &get_all();
        static void reset();

        string_id<event_transformation> id;
        std::vector<std::pair<string_id<event_transformation>, mod_id>> src;
        bool was_loaded = false;

        event_fields_type fields() const;
        monotonically monotonicity() const;

        class impl;

    private:
        friend event_transformation cata::lua_platform::detail::make_event_transformation(
            const cata::lua_platform::detail::event_transformation_native_definition &definition );
        cata::clone_ptr<impl> impl_;
};

// A value computed from events somehow
class event_statistic
{
    public:
        cata_variant value( stats_tracker & ) const;
        std::unique_ptr<stats_tracker_state> watch( stats_tracker & ) const;

        void load( const JsonObject &, std::string_view );
        void check() const;
        static void load_statistic( const JsonObject &, const std::string & );
        static void finalize_all();
        static void check_consistency();
        static const std::vector<event_statistic> &get_all();
        static void reset();

        string_id<event_statistic> id;
        std::vector<std::pair<string_id<event_statistic>, mod_id>> src;
        bool was_loaded = false;

        const translation &description() const {
            return description_;
        }

        cata_variant_type type() const;
        monotonically monotonicity() const;

        class impl;

    private:
        friend event_statistic cata::lua_platform::detail::make_event_statistic(
            const cata::lua_platform::detail::event_statistic_native_definition &definition );
        translation description_;
        cata::clone_ptr<impl> impl_;
};

class score
{
    public:
        score() = default;
        // Returns translated description including value
        std::string description( stats_tracker & ) const;
        cata_variant value( stats_tracker & ) const;

        void load( const JsonObject &, std::string_view );
        void check() const;
        static void load_score( const JsonObject &, const std::string & );
        static void finalize_all();
        static void check_consistency();
        static const std::vector<score> &get_all();
        static void reset();

        string_id<score> id;
        std::vector<std::pair<string_id<score>, mod_id>> src;
        bool was_loaded = false;
    private:
        friend class cata::lua_platform::content_transaction;
        translation description_;
        string_id<event_statistic> stat_;
};

#endif // CATA_SRC_EVENT_STATISTICS_H
