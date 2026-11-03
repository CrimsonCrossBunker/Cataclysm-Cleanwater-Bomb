#pragma once
#ifndef CATA_SRC_MONSTER_MOVE_PROFILE_H
#define CATA_SRC_MONSTER_MOVE_PROFILE_H

#include <array>
#include <chrono>
#include <cstddef>
#include <cstdint>
#include <ostream>

enum class monster_move_stage : std::size_t {
    other, behavior, special_attacks, effects, attitude, neighbors, tracking,
    path, scent, selection, commit, attack, doors, bash, push, relocate, stumble,
    danger_search, friendly_targets, reachable_targets, plan_other,
    count
};

// Only the owner thread collects these counters. Nested scopes charge exclusive time.
template<class Clock = std::chrono::steady_clock>
class basic_monster_move_profile
{
    public:
        using stage = monster_move_stage;
        static constexpr std::size_t size = static_cast<std::size_t>( stage::count );
        struct sample {
            double milliseconds = 0;
            std::uint64_t calls = 0;
        };

        explicit basic_monster_move_profile( bool enabled ) : previous_( active_ ) {
            active_ = enabled ? this : nullptr;
        }
        ~basic_monster_move_profile() {
            active_ = previous_;
        }
        basic_monster_move_profile( const basic_monster_move_profile & ) = delete;
        basic_monster_move_profile &operator=( const basic_monster_move_profile & ) = delete;

        class scope
        {
            public:
                explicit scope( stage next ) : owner_( active_ ) {
                    if( owner_ ) {
                        previous_ = owner_->current_;
                        owner_->change( next, true );
                    }
                }
                ~scope() {
                    if( owner_ ) {
                        owner_->change( previous_, false );
                    }
                }
                scope( const scope & ) = delete;
                scope &operator=( const scope & ) = delete;
                void set( stage next ) {
                    if( owner_ ) {
                        owner_->change( next, true );
                    }
                }
            private:
                basic_monster_move_profile *owner_;
                stage previous_ = stage::count;
        };

        const sample &get( stage value ) const {
            return samples_[static_cast<std::size_t>( value )];
        }

        void write( std::ostream &out ) const {
            static constexpr std::array<const char *, size> names = {{
                    "other", "behavior", "special_attacks", "effects", "attitude", "neighbors", "tracking",
                    "path", "scent", "selection", "commit", "attack", "doors", "bash", "push", "relocate", "stumble",
                    "danger_search", "friendly_targets", "reachable_targets", "plan_other"
                }};
            std::size_t hottest = 0;
            double total = 0;
            for( std::size_t i = 0; i < size; ++i ) {
                total += samples_[i].milliseconds;
                if( samples_[i].milliseconds > samples_[hottest].milliseconds ) {
                    hottest = i;
                }
                out << ' ' << names[i] << "_ms=" << samples_[i].milliseconds
                    << ' ' << names[i] << "_calls=" << samples_[i].calls;
            }
            out << " hottest=" << names[hottest] << " hottest_pct="
                << ( total > 0 ? 100 * samples_[hottest].milliseconds / total : 0 );
        }

    private:
        void change( stage next, bool count_call ) {
            const auto now = Clock::now();
            if( current_ != stage::count ) {
                samples_[static_cast<std::size_t>( current_ )].milliseconds +=
                    std::chrono::duration<double, std::milli>( now - since_ ).count();
            }
            current_ = next;
            since_ = now;
            if( count_call && next != stage::count ) {
                ++samples_[static_cast<std::size_t>( next )].calls;
            }
        }
        inline static thread_local basic_monster_move_profile *active_ = nullptr;
        basic_monster_move_profile *previous_;
        std::array<sample, size> samples_{};
        stage current_ = stage::count;
        typename Clock::time_point since_{};
};

using monster_move_profile = basic_monster_move_profile<>;
using monster_move_scope = monster_move_profile::scope;

#endif // CATA_SRC_MONSTER_MOVE_PROFILE_H
