#pragma once
#ifndef CATA_SRC_SPRITE_ALPHA_PROFILE_H
#define CATA_SRC_SPRITE_ALPHA_PROFILE_H

#include <vector>

// Outer opaque pixel of each column and row, or -1 for an empty scanline.
struct sprite_alpha_profile {
    std::vector<int> top;
    std::vector<int> bottom;
    std::vector<int> left;
    std::vector<int> right;
};

#endif // CATA_SRC_SPRITE_ALPHA_PROFILE_H
