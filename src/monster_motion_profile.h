#pragma once
#ifndef CATA_SRC_MONSTER_MOTION_PROFILE_H
#define CATA_SRC_MONSTER_MOTION_PROFILE_H

#include <array>
#include <chrono>
#include <cstddef>
#include <cstdint>

namespace monster_motion_profile
{
enum class stage : std::size_t {
    plan_setup, plan_player, plan_friendly, plan_npcs, plan_hostile,
    plan_vehicle, plan_group, plan_goal, rate_target,
    move_setup, move_behavior, move_specials, move_effects, move_attitude,
    move_neighbors, move_path, move_scent_sound, move_selection, move_commit,
    attack, bash, push, step, stumble, position, count
};
inline constexpr std::array<const char *, static_cast<std::size_t>( stage::count )> names = {{
    "plan_setup", "plan_player", "plan_friendly", "plan_npcs", "plan_hostile",
    "plan_vehicle", "plan_group", "plan_goal", "rate_target",
    "move_setup", "move_behavior", "move_specials", "move_effects", "move_attitude",
    "move_neighbors", "move_path", "move_scent_sound", "move_selection", "move_commit",
    "attack", "bash", "push", "step", "stumble", "position"
}};
enum class counter : std::size_t {
    friendly_visits, npc_visits, hostile_visits, group_visits,
    ratings, routes, straight_routes, neighbor_checks, position_fallbacks, count
};
inline constexpr std::array<const char *, static_cast<std::size_t>( counter::count )> counter_names = {{
    "friendly_visits", "npc_visits", "hostile_visits", "group_visits",
    "ratings", "routes", "straight_routes", "neighbor_checks", "position_fallbacks"
}};
struct sample {
    std::chrono::steady_clock::duration elapsed{};
    std::uint64_t calls = 0;
};
struct frame;
class scope;
inline thread_local frame *active = nullptr;
struct frame {
    std::array<sample, names.size()> samples{};
    std::array<std::uint64_t, counter_names.size()> counters{};
    scope *top = nullptr;
    frame *previous = active;
    frame() { active = this; }
    ~frame() { active = previous; }
    frame( const frame & ) = delete;
    frame &operator=( const frame & ) = delete;
};
inline void increment( counter value )
{
    if( active ) {
        ++active->counters[static_cast<std::size_t>( value )];
    }
}
// Nested scopes charge exclusive time, including recursive push/movement calls.
class scope
{
    public:
        explicit scope( stage value ) : owner_( active ), value_( value ) {
            if( owner_ ) {
                const auto now = std::chrono::steady_clock::now();
                parent_ = owner_->top;
                if( parent_ ) {
                    parent_->charge( now );
                }
                owner_->top = this;
                started_ = now;
                ++owner_->samples[static_cast<std::size_t>( value_ )].calls;
            }
        }
        ~scope() {
            if( owner_ ) {
                const auto now = std::chrono::steady_clock::now();
                charge( now );
                owner_->top = parent_;
                if( parent_ ) {
                    parent_->started_ = now;
                }
            }
        }
        void next( stage value ) {
            if( owner_ ) {
                const auto now = std::chrono::steady_clock::now();
                charge( now );
                started_ = now;
                value_ = value;
                ++owner_->samples[static_cast<std::size_t>( value_ )].calls;
            }
        }
        scope( const scope & ) = delete;
        scope &operator=( const scope & ) = delete;
    private:
        void charge( std::chrono::steady_clock::time_point now ) {
            owner_->samples[static_cast<std::size_t>( value_ )].elapsed += now - started_;
        }
        frame *owner_;
        scope *parent_ = nullptr;
        stage value_;
        std::chrono::steady_clock::time_point started_;
};
} // namespace monster_motion_profile
#endif // CATA_SRC_MONSTER_MOTION_PROFILE_H
