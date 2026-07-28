#include "android_imgui_touch.h"

#include <algorithm>
#include <cmath>

namespace android_imgui_touch
{

namespace
{

constexpr float direction_change_ratio = 1.25F;
constexpr float velocity_blend = 0.35F;
constexpr float maximum_velocity = 8000.0F;
constexpr float minimum_fling_velocity = 80.0F;
constexpr float stop_velocity = 24.0F;
constexpr float fling_friction = 5.5F;
constexpr std::uint32_t maximum_animation_step_ms = 32;
constexpr std::uint32_t maximum_velocity_sample_gap_ms = 100;

} // namespace

void gesture::press( const float x, const float y, const std::uint32_t now )
{
    mode_ = gesture_mode::pending;
    start_x_ = last_x_ = x;
    start_y_ = last_y_ = y;
    velocity_y_ = 0.0F;
    last_sample_time_ = now;
    animation_time_ = now;
}

motion_result gesture::move( const float x, const float y, const std::uint32_t now,
                             const float touch_slop, const bool can_scroll_vertically )
{
    motion_result result;
    if( !touching() ) {
        return result;
    }

    const float total_x = x - start_x_;
    const float total_y = y - start_y_;
    const float delta_y = y - last_y_;
    const float threshold = std::max( 1.0F, touch_slop );
    const bool passed_slop = std::hypot( total_x, total_y ) > threshold;
    const bool vertical_intent = std::abs( total_y ) > std::abs( total_x );

    if( mode_ == gesture_mode::pending && passed_slop ) {
        if( can_scroll_vertically && vertical_intent ) {
            mode_ = gesture_mode::vertical_scroll;
            result.begin_vertical_scroll = true;
        } else {
            mode_ = gesture_mode::pointer_drag;
            result.begin_pointer_drag = true;
        }
    } else if( mode_ == gesture_mode::pointer_drag && can_scroll_vertically &&
               std::abs( total_y ) > std::abs( total_x ) * direction_change_ratio ) {
        mode_ = gesture_mode::vertical_scroll;
        result.cancel_pointer_drag = true;
        result.begin_vertical_scroll = true;
        velocity_y_ = 0.0F;
    }

    if( mode_ == gesture_mode::vertical_scroll ) {
        result.scroll_delta_y = delta_y;
        update_velocity( delta_y, now );
    }

    last_x_ = x;
    last_y_ = y;
    if( mode_ != gesture_mode::vertical_scroll ) {
        last_sample_time_ = now;
    }
    return result;
}

release_result gesture::release( const float x, const float y, const std::uint32_t now,
                                 const float touch_slop, const bool can_scroll_vertically )
{
    release_result result;
    result.motion = move( x, y, now, touch_slop, can_scroll_vertically );

    switch( mode_ ) {
        case gesture_mode::pending:
            result.tap = true;
            mode_ = gesture_mode::idle;
            break;
        case gesture_mode::pointer_drag:
            result.release_pointer = true;
            mode_ = gesture_mode::idle;
            break;
        case gesture_mode::vertical_scroll: {
            if( std::abs( velocity_y_ ) >= minimum_fling_velocity ) {
                mode_ = gesture_mode::inertia;
                animation_time_ = now;
            } else {
                mode_ = gesture_mode::idle;
                velocity_y_ = 0.0F;
            }
            break;
        }
        case gesture_mode::idle:
        case gesture_mode::inertia:
            break;
    }

    return result;
}

animation_result gesture::animate( const std::uint32_t now )
{
    animation_result result;
    if( mode_ != gesture_mode::inertia ) {
        return result;
    }

    const std::uint32_t elapsed_ms = std::min( now - animation_time_,
                                     maximum_animation_step_ms );
    if( elapsed_ms == 0 ) {
        result.active = true;
        return result;
    }

    const float elapsed = static_cast<float>( elapsed_ms ) / 1000.0F;
    result.scroll_delta_y = velocity_y_ * elapsed;
    velocity_y_ *= std::exp( -fling_friction * elapsed );
    animation_time_ = now;

    if( std::abs( velocity_y_ ) < stop_velocity ) {
        mode_ = gesture_mode::idle;
        velocity_y_ = 0.0F;
    } else {
        result.active = true;
    }
    return result;
}

void gesture::cancel()
{
    mode_ = gesture_mode::idle;
    velocity_y_ = 0.0F;
}

void gesture::stop_inertia()
{
    if( mode_ == gesture_mode::inertia ) {
        cancel();
    }
}

gesture_mode gesture::mode() const
{
    return mode_;
}

bool gesture::touching() const
{
    return mode_ == gesture_mode::pending ||
           mode_ == gesture_mode::pointer_drag ||
           mode_ == gesture_mode::vertical_scroll;
}

bool gesture::pointer_is_down() const
{
    return mode_ == gesture_mode::pointer_drag;
}

bool gesture::animating() const
{
    return mode_ == gesture_mode::inertia;
}

void gesture::update_velocity( const float delta_y, const std::uint32_t now )
{
    const std::uint32_t elapsed_ms = now - last_sample_time_;
    if( elapsed_ms > 0 ) {
        const float sample = std::clamp(
                                 delta_y * 1000.0F / static_cast<float>( elapsed_ms ),
                                 -maximum_velocity, maximum_velocity );
        velocity_y_ = velocity_y_ == 0.0F ||
                      elapsed_ms > maximum_velocity_sample_gap_ms ? sample :
                      velocity_y_ * ( 1.0F - velocity_blend ) +
                      sample * velocity_blend;
    }
    last_sample_time_ = now;
}

} // namespace android_imgui_touch
