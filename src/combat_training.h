#pragma once
#ifndef CATA_SRC_COMBAT_TRAINING_H
#define CATA_SRC_COMBAT_TRAINING_H

// Match practice()'s cap: the cap level can still train, but higher levels cannot.
// A reduced nonzero rate would let arbitrarily weak opponents train every level.
inline double combat_training_multiplier( double skill_level, double training_level )
{
    return skill_level <= training_level ? 1.0 : 0.0;
}

#endif // CATA_SRC_COMBAT_TRAINING_H
