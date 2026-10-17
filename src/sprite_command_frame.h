#pragma once
#ifndef CATA_SRC_SPRITE_COMMAND_FRAME_H
#define CATA_SRC_SPRITE_COMMAND_FRAME_H

#if defined(TILES)
#include <memory>
#include <optional>

#include "render_command_order.h"

class tileset;
struct sprite_draw_command;
struct sprite_asset_binding;

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
        // Validate the immediate binding once at the last owner boundary and
        // pass that exact stamp into the ordered backend acceptance.
        bool submit( const sprite_draw_command &command, const sprite_asset_binding &binding,
                     const std::shared_ptr<const tileset> &current, int &height_3d );
        render_command_order &order() {
            return order_;
        }
        void cancel() {
            order_.cancel();
        }
        // One issued command must either submit or close its stream. Keep this
        // hot owner scope concrete rather than type-erasing a callback per sprite.
        class submission_guard
        {
            public:
                explicit submission_guard( sprite_command_frame &frame ) noexcept : frame_( frame ) {}
                ~submission_guard() {
                    if( !accepted_ ) {
                        frame_.cancel();
                    }
                }
                submission_guard( const submission_guard & ) = delete;
                submission_guard &operator=( const submission_guard & ) = delete;
                void accepted() noexcept {
                    accepted_ = true;
                }
            private:
                sprite_command_frame &frame_;
                bool accepted_ = false;
        };
        static render_resource_stamp current_resources();
    private:
        bool valid( const std::shared_ptr<const tileset> &current,
                    render_resource_stamp resources ) const;
        std::shared_ptr<const tileset> bundle_;
        render_resource_stamp resources_;
        render_command_order order_;
};
#endif // TILES
#endif // CATA_SRC_SPRITE_COMMAND_FRAME_H
