#pragma once
#ifndef CATA_SRC_VEHICLE_TURNING_H
#define CATA_SRC_VEHICLE_TURNING_H

#include <algorithm>
#include <cmath>
#include <optional>

// A circular arc tangent to the initial heading, through a point in front of
// the vehicle.  Angles are radians; distances are map squares.  This is steering
// guidance, not pathfinding or a collision-free route.
struct vehicle_turning_arc {
    double remaining = 0.0;
    double curvature = 0.0;

    static std::optional<vehicle_turning_arc> through( double forward, double lateral );

    double advance( double heading ) {
        constexpr double max_step = 3.14159265358979323846 / 12.0;
        // A diagonal tileray step covers more ground than an axial step.
        const double distance = 1.0 / std::max( std::abs( std::cos( heading ) ),
                                                std::abs( std::sin( heading ) ) );
        const double step = std::copysign( std::min( { std::abs( remaining ),
                                           std::abs( curvature ) * distance, max_step } ), remaining );
        remaining -= step;
        return step;
    }

    bool finished() const {
        return std::abs( remaining ) < 0.000001;
    }
};

#endif // CATA_SRC_VEHICLE_TURNING_H
