#pragma once
#ifndef CATA_SRC_DRAW_CACHE_REBUILD_GUARD_H
#define CATA_SRC_DRAW_CACHE_REBUILD_GUARD_H

// Owner-only readiness scope. Preserve the old clean-during-build behavior,
// but retry incomplete work after an exception. A new invalidation during a
// successful build must remain dirty. No allocation, world access or worker.
class draw_cache_rebuild_guard
{
    public:
        explicit draw_cache_rebuild_guard( bool &dirty ) noexcept : dirty_( dirty ) {
            dirty_ = false;
        }
        ~draw_cache_rebuild_guard() {
            if( !complete_ ) {
                dirty_ = true;
            }
        }
        draw_cache_rebuild_guard( const draw_cache_rebuild_guard & ) = delete;
        draw_cache_rebuild_guard &operator=( const draw_cache_rebuild_guard & ) = delete;
        void complete() noexcept {
            complete_ = true;
        }
    private:
        bool &dirty_;
        bool complete_ = false;
};

#endif // CATA_SRC_DRAW_CACHE_REBUILD_GUARD_H
