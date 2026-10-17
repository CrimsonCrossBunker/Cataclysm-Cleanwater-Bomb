#pragma once
#ifndef CATA_SRC_RENDER_COMMAND_ORDER_H
#define CATA_SRC_RENDER_COMMAND_ORDER_H

#include <cstdint>
#include <limits>
#include <optional>

struct render_resource_stamp {
    std::uint64_t renderer = 0;
    std::uint64_t sprite_sheets = 0;
    bool operator==( const render_resource_stamp &other ) const {
        return renderer == other.renderer && sprite_sheets == other.sprite_sheets;
    }
};

// A command's identity is value data. An owner begins one stream for a frame,
// emits commands in painter order and accepts each command once. A reset with
// the same resource epoch still expires all tickets from the previous frame.
struct render_command_ticket {
    render_resource_stamp resources;
    std::uint64_t owner = 0;
    std::uint64_t stream = 0;
    std::uint64_t sequence = 0;
};

class render_command_order
{
    public:
        bool begin( render_resource_stamp resources, std::uint64_t owner ) noexcept {
            if( stream_ == std::numeric_limits<std::uint64_t>::max() ) {
                cancel();
                return false;
            }
            if( owner == 0 ) {
                cancel();
                return false;
            }
            owner_ = owner;
            ++stream_;
            resources_ = resources;
            issued_ = next_ = 0;
            cancelled_ = false;
            return true;
        }
        std::optional<render_command_ticket> issue() noexcept {
            if( cancelled_ || issued_ == std::numeric_limits<std::uint64_t>::max() ) {
                cancel();
                return std::nullopt;
            }
            return render_command_ticket{ resources_, owner_, stream_, issued_++ };
        }
        bool accept( const render_command_ticket &ticket, render_resource_stamp current ) noexcept {
            if( cancelled_ || !( resources_ == current ) || !( ticket.resources == current ) ||
                ticket.owner != owner_ || ticket.stream != stream_ || ticket.sequence != next_ ||
                next_ == issued_ ) {
                cancel();
                return false;
            }
            ++next_;
            return true;
        }
        void cancel() noexcept {
            cancelled_ = true;
        }
        bool cancelled() const noexcept {
            return cancelled_;
        }
        std::uint64_t accepted() const noexcept {
            return next_;
        }
    private:
        render_resource_stamp resources_;
        std::uint64_t owner_ = 0;
        std::uint64_t stream_ = 0;
        std::uint64_t issued_ = 0;
        std::uint64_t next_ = 0;
        bool cancelled_ = true;
};

#endif // CATA_SRC_RENDER_COMMAND_ORDER_H
