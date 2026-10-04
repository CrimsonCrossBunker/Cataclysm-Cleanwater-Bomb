#pragma once
#ifndef CATA_SRC_COMBAT_TRAINING_H
#define CATA_SRC_COMBAT_TRAINING_H

#include <algorithm>

// Easier opponents still teach something; each excess level reduces the rate.
inline double combat_training_multiplier( double skill_level, double training_level )
{
    return 1.0 / ( 1.0 + std::max( 0.0, skill_level - training_level ) );
}

#endif // CATA_SRC_COMBAT_TRAINING_H
