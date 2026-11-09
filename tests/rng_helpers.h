#pragma once
#ifndef CATA_TESTS_RNG_HELPERS_H
#define CATA_TESTS_RNG_HELPERS_H

#include <random>
#include <sstream>
#include <string>

#include "rng.h"

inline std::string capture_rng_state()
{
    std::ostringstream state;
    state << rng_get_engine();
    return state.str();
}

inline void restore_rng_state( const std::string &state )
{
    std::istringstream saved( state );
    saved >> rng_get_engine();
}

#endif
