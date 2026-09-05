#pragma once
#ifndef CATA_SRC_MOUSE_BUTTON_CAPTURE_H
#define CATA_SRC_MOUSE_BUTTON_CAPTURE_H

#include <bitset>

// A UI owns the release of a button it consumed, even if the UI closes
// between the press and release.  Otherwise that release clicks the map.
class mouse_button_capture
{
    public:
        bool process( unsigned int button, bool pressed, bool captured ) {
            if( button >= owned.size() ) {
                return captured;
            }
            if( pressed ) {
                owned.set( button, captured );
                return captured;
            }
            const bool consume = captured || owned.test( button );
            owned.reset( button );
            return consume;
        }

        void clear() {
            owned.reset();
        }

    private:
        std::bitset<32> owned;
};

#endif // CATA_SRC_MOUSE_BUTTON_CAPTURE_H
