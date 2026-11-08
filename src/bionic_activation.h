#pragma once
#ifndef CATA_SRC_BIONIC_ACTIVATION_H
#define CATA_SRC_BIONIC_ACTIVATION_H

#include <optional>
#include "coordinates.h"
#include "type_id.h"

class Character;
struct bionic;

// Choices are collected by the owning frontend; costs and effects stay native.
struct bionic_activation_choices {
    std::optional<tripoint_abs_ms> target;
};
bool bionic_requires_adjacent_target( const bionic_id &id );
bool supports_owned_bionic_activation( const bionic &bio );
bool valid_bionic_activation_choices( const Character &who, const bionic &bio,
                                      const bionic_activation_choices &choices );
std::optional<bionic_activation_choices> query_bionic_activation_choices(
    Character &who, const bionic &bio );
bool execute_owned_bionic_activation( Character &who, unsigned int uid,
                                      const bionic_id &expected_type,
                                      const bionic_activation_choices &choices );

#endif // CATA_SRC_BIONIC_ACTIVATION_H
