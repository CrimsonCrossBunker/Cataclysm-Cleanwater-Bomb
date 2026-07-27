#pragma once
#ifndef CATA_SRC_CATALUA_UI_SCHEDULER_H
#define CATA_SRC_CATALUA_UI_SCHEDULER_H

#include <cstddef>
#include <cstdint>
#include <vector>

namespace cata::lua_ui
{

struct scheduled_script_task {
    std::uint64_t id = 0;
    std::int64_t due_turn = 0;
    std::int64_t interval = 0;
    std::size_t source_index = 0;
    std::uint64_t sequence = 0;
};

// A game-turn scheduler with no wall-clock dependency.  It stores only task
// metadata; the Lua callback remains owned by the transactional runtime.
class deterministic_turn_scheduler
{
    public:
        static constexpr std::size_t maximum_tasks = 256;
        static constexpr std::size_t maximum_callbacks_per_turn = 64;
        static constexpr std::int64_t maximum_delay_turns = 1000000000;

        std::uint64_t schedule_after( std::int64_t now, std::int64_t delay,
                                      std::size_t source_index );
        std::uint64_t schedule_every( std::int64_t now, std::int64_t interval,
                                      std::size_t source_index );
        bool cancel( std::uint64_t id, std::size_t source_index );
        bool cancel_unchecked( std::uint64_t id );

        std::vector<scheduled_script_task> take_due( std::int64_t now );
        bool contains( std::uint64_t id ) const;
        std::size_t size() const;
        void clear();

    private:
        std::vector<scheduled_script_task> tasks_;
        std::uint64_t next_id_ = 1;
        std::uint64_t next_sequence_ = 1;

        std::uint64_t schedule( std::int64_t now, std::int64_t delay,
                                std::int64_t interval, std::size_t source_index );
};

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_SCHEDULER_H
