#pragma once
#ifndef CATA_SRC_MP_ADMISSION_H
#define CATA_SRC_MP_ADMISSION_H

#include <atomic>
#include <cstdint>
#include <memory>

namespace cata_mp
{
// Native capability for one authenticated admission. Neither a persistent
// player ID nor a wire credential. Retaining it cannot keep a server alive.
class peer_admission
{
    public:
        static peer_admission create( uint64_t peer ) {
            peer_admission result;
            if( peer != 0 ) {
                result.state_ = std::make_shared<state>( peer );
            }
            return result;
        }
        uint64_t peer_id() const {
            return state_ ? state_->peer : 0;
        }
        bool active() const {
            return state_ && state_->active.load();
        }
        void retire() const {
            if( state_ ) {
                state_->active = false;
            }
        }
        bool matches( const peer_admission &other ) const {
            return state_ && state_ == other.state_;
        }

    private:
        struct state {
            explicit state( uint64_t value ) : peer( value ) {}
            const uint64_t peer;
            std::atomic<bool> active{ true };
        };
        std::shared_ptr<state> state_;
};
} // namespace cata_mp

#endif // CATA_SRC_MP_ADMISSION_H
