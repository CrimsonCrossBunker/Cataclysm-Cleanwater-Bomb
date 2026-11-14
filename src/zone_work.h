#pragma once
#ifndef CATA_SRC_ZONE_WORK_H
#define CATA_SRC_ZONE_WORK_H

#include <string>

#include "clzones.h"

class Character;

// Resolve the operator's active zone job, including its auto-resume parent.
// Outside a job, personal zones are relative to this character's current position.
zone_query_context active_zone_query( const Character &who );

// The command contains only a named native job. Actors, costs and targets are
// created on the authority from that operator's current zones and equipment.
bool start_owned_zone_work( Character &who, const std::string &action );

#endif // CATA_SRC_ZONE_WORK_H
