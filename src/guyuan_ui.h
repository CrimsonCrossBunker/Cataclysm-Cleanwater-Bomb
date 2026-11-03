#pragma once
#ifndef CATA_SRC_GUYUAN_UI_H
#define CATA_SRC_GUYUAN_UI_H

#include <algorithm>

namespace guyuan_ui
{
struct window_layout {
    float x;
    float y;
    float width;
    float height;
};

inline window_layout fit_window( float width, float height )
{
    width = std::max( 1.0F, width );
    height = std::max( 1.0F, height );
    const float margin_x = std::min( 32.0F, width * 0.035F );
    const float margin_y = std::min( 28.0F, height * 0.045F );
    const float window_width = std::min( 1600.0F, width - margin_x * 2 );
    const float window_height = std::min( 1040.0F, height - margin_y * 2 );
    return { ( width - window_width ) * 0.5F, ( height - window_height ) * 0.5F,
             window_width, window_height };
}

class scoped_style
{
    public:
        scoped_style();
        ~scoped_style();
        scoped_style( const scoped_style & ) = delete;
        scoped_style &operator=( const scoped_style & ) = delete;
    private:
        bool active = false;
};
}

#endif

