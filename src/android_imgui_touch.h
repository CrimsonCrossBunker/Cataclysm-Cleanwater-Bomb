#ifndef CATA_SRC_ANDROID_IMGUI_TOUCH_H
#define CATA_SRC_ANDROID_IMGUI_TOUCH_H

#include <cstdint>

namespace android_imgui_touch
{

enum class gesture_mode : int {
    idle = 0,
    pending,
    pointer_drag,
    vertical_scroll,
    inertia
};

struct motion_result {
    bool begin_pointer_drag = false;
    bool cancel_pointer_drag = false;
    bool begin_vertical_scroll = false;
    float scroll_delta_y = 0.0F;
};

struct release_result {
    motion_result motion;
    bool tap = false;
    bool release_pointer = false;
};

struct animation_result {
    float scroll_delta_y = 0.0F;
    bool active = false;
};

class gesture
{
    public:
        void press( float x, float y, std::uint32_t now );
        motion_result move( float x, float y, std::uint32_t now,
                            float touch_slop, bool can_scroll_vertically );
        release_result release( float x, float y, std::uint32_t now,
                                float touch_slop, bool can_scroll_vertically );
        animation_result animate( std::uint32_t now );
        void cancel();
        void stop_inertia();

        gesture_mode mode() const;
        bool touching() const;
        bool pointer_is_down() const;
        bool animating() const;

    private:
        gesture_mode mode_ = gesture_mode::idle;
        float start_x_ = 0.0F;
        float start_y_ = 0.0F;
        float last_x_ = 0.0F;
        float last_y_ = 0.0F;
        float velocity_y_ = 0.0F;
        std::uint32_t last_sample_time_ = 0;
        std::uint32_t animation_time_ = 0;

        void update_velocity( float delta_y, std::uint32_t now );
};

} // namespace android_imgui_touch

#endif // CATA_SRC_ANDROID_IMGUI_TOUCH_H
