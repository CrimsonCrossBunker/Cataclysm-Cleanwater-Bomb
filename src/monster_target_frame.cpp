#include "monster_target_frame.h"

#include <cstdint>
#include <unordered_map>
#include <utility>

#include "cpu_scheduler.h"
#include "creature_tracker.h"
#include "monster.h"
#include "monster_target_index.h"
#include "monster_target_selection.h"

struct monster_target_frame::impl {
    struct entry {
        shared_ptr_fast<monster> actor;
        tripoint position;
        bool indexed;
    };
    struct window {
        bool ready = false;
        std::vector<std::size_t> candidates;
    };
    creature_tracker &tracker;
    std::vector<entry> entries;
    std::unordered_map<const Creature *, std::size_t> ids;
    monster_target_index index;
    std::unordered_map<tripoint, window> windows;
    std::uint64_t revision = 0;
    bool dirty = true;
    static constexpr std::size_t max_windows = 128;

    explicit impl( creature_tracker &source ) : tracker( source ) {}

    void prepare() {
        std::vector<std::pair<tripoint, window *>> pending;
        for( auto &item : windows ) {
            if( !item.second.ready ) {
                pending.emplace_back( item.first, &item.second );
            }
        }
        // Distinct windows write distinct results. The index is immutable until
        // the blocking join; workers never read any creature or map object.
        cpu_parallel_for( cpu_task_kind::monster_target_index, pending.size(), 1,
        [&]( std::size_t begin, std::size_t end ) {
            for( std::size_t i = begin; i < end; ++i ) {
                pending[i].second->candidates = index.candidates( pending[i].first );
            }
        } );
        for( const auto &item : pending ) {
            item.second->ready = true;
        }
    }

    void rebuild() {
        dirty = true;
        entries.clear();
        ids.clear();
        windows.clear();
        index = monster_target_index{};
        const auto &monsters = tracker.get_monsters_list();
        entries.reserve( monsters.size() );
        ids.reserve( monsters.size() );
        for( const auto &actor : monsters ) {
            const std::size_t id = entries.size();
            const tripoint position = actor->pos_abs().raw();
            const bool indexed = actor->friendly == 0;
            entries.push_back( { actor, position, indexed } );
            ids.emplace( actor.get(), id );
            if( indexed ) {
                // Keep low anger/morale and dead entries conservatively: live
                // qualification below also handles resurrection and fresh anger.
                index.insert( id, position );
            } else if( windows.size() < max_windows ) {
                windows.try_emplace( monster_target_index::cell( position ) );
            }
        }
        revision = monster_friendliness::revision();
        prepare();
        dirty = false;
    }

    void move( const Creature *actor, const tripoint &position ) {
        if( dirty || revision != monster_friendliness::revision() ) {
            return;
        }
        const auto found = ids.find( actor );
        if( found == ids.end() ) {
            return;
        }
        entry &target = entries[found->second];
        const tripoint old_cell = monster_target_index::cell( target.position );
        const tripoint new_cell = monster_target_index::cell( position );
        if( target.indexed && old_cell != new_cell ) {
            // On allocation failure the next query rebuilds rather than using
            // partially updated membership.
            dirty = true;
            index.erase( found->second, target.position );
            index.insert( found->second, position );
            for( auto &item : windows ) {
                // If both cells overlap, the ordered candidate IDs are unchanged;
                // current positions are read later by the individual observer.
                if( monster_target_index::overlaps( item.first, old_cell ) !=
                    monster_target_index::overlaps( item.first, new_cell ) ) {
                    item.second.ready = false;
                }
            }
            dirty = false;
        }
        target.position = position;
    }
};

monster_target_frame::monster_target_frame( creature_tracker &tracker ) :
    impl_( std::make_unique<impl>( tracker ) ), previous_( active_ )
{
    active_ = this;
}

monster_target_frame::~monster_target_frame()
{
    active_ = previous_;
}

bool monster_target_frame::collect( const monster &observer,
                                   std::vector<shared_ptr_fast<monster>> &out )
{
    if( !active_ || &active_->impl_->tracker != &get_creature_tracker() ) {
        return false;
    }
    impl &state = *active_->impl_;
    if( state.dirty || state.revision != monster_friendliness::revision() ) {
        state.rebuild();
    }
    const tripoint cell = monster_target_index::cell( observer.pos_abs().raw() );
    auto found = state.windows.find( cell );
    if( found == state.windows.end() ) {
        if( state.windows.size() >= impl::max_windows ) {
            state.windows.clear();
        }
        found = state.windows.try_emplace( cell ).first;
    }
    if( !found->second.ready ) {
        state.prepare();
    }
    for( const std::size_t id : found->second.candidates ) {
        const auto &actor = state.entries[id].actor;
        if( hostile_to_player_ally( actor->friendly, actor->morale, actor->anger ) &&
            !actor->is_dead() ) {
            out.push_back( actor );
        }
    }
    return true;
}

void monster_target_frame::population_changed( const creature_tracker &tracker )
{
    for( auto *frame = active_; frame; frame = frame->previous_ ) {
        if( &frame->impl_->tracker == &tracker ) {
            frame->impl_->dirty = true;
        }
    }
}

void monster_target_frame::moved( const Creature *actor, const tripoint_abs_ms &position )
{
    for( auto *frame = active_; frame; frame = frame->previous_ ) {
        frame->impl_->move( actor, position.raw() );
    }
}
