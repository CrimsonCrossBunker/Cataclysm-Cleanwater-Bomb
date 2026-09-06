#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_CANVAS_H
#define CATA_SRC_LUA_PLATFORM_CANVAS_H

#include <cstddef>
#include <cstdint>
#include <string>

namespace cata::lua_platform
{

/** A single canvas frame, invalidated when its Lua callback returns. */
class platform_canvas_context
{
    public:
        platform_canvas_context( int width, int height, std::int64_t elapsed_ms,
                                 std::int64_t delta_ms, float origin_x = 0.0F,
                                 float origin_y = 0.0F, float scale = 1.0F );

        void invalidate();
        int width() const;
        int height() const;
        std::int64_t elapsed_ms() const;
        std::int64_t delta_ms() const;
        bool is_open() const;
        void close();

        void rect( float x, float y, float w, float h,
                   float r, float g, float b, float a );
        void text( float x, float y, const std::string &value,
                   float r, float g, float b, float a );
        bool sprite( const std::string &id, float x, float y, float w, float h );
        bool button( const std::string &id, const std::string &label,
                     float x, float y, float w, float h, bool request_focus );

    private:
        void require_active() const;
        void operation( float x, float y, float w, float h );

        int width_;
        int height_;
        std::int64_t elapsed_ms_;
        std::int64_t delta_ms_;
        float origin_x_;
        float origin_y_;
        float scale_;
        std::size_t operations_ = 0;
        bool active_ = true;
        bool open_ = true;
};

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_CANVAS_H
