#pragma once
#ifndef CATA_SRC_BIONIC_ACTIVATION_H
#define CATA_SRC_BIONIC_ACTIVATION_H

#include <optional>
#include "coordinates.h"
#include "item_source.h"
#include "item_disposition.h"
#include "item_activation.h"
#include "martial_style_selection.h"
#include "type_id.h"

class Character;
struct bionic;

// Choices are collected by the owning frontend; costs and effects stay native.
struct bionic_activation_choices {
    std::optional<tripoint_abs_ms> target;
    std::optional<martial_style_choice> martial_style = std::nullopt;
    std::optional<item_source> water_corpse = std::nullopt;
    int64_t weapon = 0;
    std::optional<item_disposition> unwield = std::nullopt;
    std::optional<item_activation_choices> remote_vehicle = std::nullopt;
    std::optional<int> radio = std::nullopt;
};
enum class bionic_action {
    activate,
    deactivate
};
bool bionic_requires_adjacent_target( const bionic_id &id );
bool supports_owned_bionic_action( const bionic &bio, bionic_action action );
bool valid_bionic_activation_choices( Character &who, const bionic &bio,
                                      const bionic_activation_choices &choices );
bool execute_bionic_remote_choices( Character &who, unsigned int uid,
                                    const bionic_activation_choices &choices );
std::optional<bionic_activation_choices> query_bionic_activation_choices(
    Character &who, const bionic &bio );
bool execute_owned_bionic_action( Character &who, unsigned int uid,
                                  const bionic_id &expected_type,
                                  const bionic_activation_choices &choices,
                                  bionic_action action = bionic_action::activate );

#endif // CATA_SRC_BIONIC_ACTIVATION_H
