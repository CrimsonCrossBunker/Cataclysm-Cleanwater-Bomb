#pragma once
#ifndef CATA_SRC_ITEM_ROT_H
#define CATA_SRC_ITEM_ROT_H

#include "units.h"

struct item_rot_rates {
    bool cryogenic = false;
    float normal = 0;
    float cold = 0;
};

float hourly_item_rotpoints( const units::temperature &temp, bool cryogenic );

#endif // CATA_SRC_ITEM_ROT_H
