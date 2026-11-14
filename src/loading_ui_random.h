#pragma once
#ifndef CATA_SRC_LOADING_UI_RANDOM_H
#define CATA_SRC_LOADING_UI_RANDOM_H

#include <random>
#include <string>
#include <vector>

#include "cata_path.h"

enum class holiday : int;

namespace loading_ui
{
// Owned by one loading screen. Selecting presentation content must not advance
// simulation RNG, even when different frontends select different content.
class random_choices
{
    public:
        random_choices();
        explicit random_choices( unsigned int seed );
        std::string tip();
        cata_path image( const std::vector<cata_path> &images );
        std::string title( holiday current_holiday );

    private:
        std::mt19937 engine;
};
} // namespace loading_ui

#endif // CATA_SRC_LOADING_UI_RANDOM_H
