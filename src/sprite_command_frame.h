#pragma once
#ifndef CATA_SRC_SPRITE_COMMAND_FRAME_H
#define CATA_SRC_SPRITE_COMMAND_FRAME_H

#if defined(TILES)
#include <memory>
#include <optional>

#include "render_command_order.h"

class tileset;

// Immediate owner binding for one draw frame. Metadata lifetime is pinned here;
// tickets/commands contain values only. SDL calls and validity checks stay on
// the renderer owner. This does not authorize asynchronous frame submission.
class sprite_command_frame
{
    public:
        explicit sprite_command_frame( std::shared_ptr<const tileset> bundle );
        ~sprite_command_frame();
        sprite_command_frame( const sprite_command_frame & ) = delete;
        sprite_command_frame &operator=( const sprite_command_frame & ) = delete;
        bool valid( const std::shared_ptr<const tileset> &current ) const;
        std::optional<render_command_ticket> issue( const std::shared_ptr<const tileset> &current );
        render_command_order &order() {
            return order_;
        }
        void cancel() {
            order_.cancel();
        }
        static render_resource_stamp current_resources();
    private:
        std::shared_ptr<const tileset> bundle_;
        render_resource_stamp resources_;
        render_command_order order_;
};
#endif // TILES
#endif // CATA_SRC_SPRITE_COMMAND_FRAME_H
