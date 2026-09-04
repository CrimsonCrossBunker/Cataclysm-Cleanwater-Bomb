#pragma once
#ifndef CATA_SRC_HOVER_MOUSE_INPUT_H
#define CATA_SRC_HOVER_MOUSE_INPUT_H

class hover_mouse_input_state
{
    public:
        void activate() {
            active_ = true;
        }

        void deactivate() {
            active_ = false;
        }

        bool active() const {
            return active_;
        }

    private:
        bool active_ = false;
};

#endif // CATA_SRC_HOVER_MOUSE_INPUT_H
