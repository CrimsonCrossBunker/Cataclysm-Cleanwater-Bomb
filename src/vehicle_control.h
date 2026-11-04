#pragma once
#ifndef CATA_SRC_VEHICLE_CONTROL_H
#define CATA_SRC_VEHICLE_CONTROL_H

class Character;
class map;
class vehicle;

// Controller state belongs to its character. Queries never reuse another
// character's connection or a cached vehicle pointer from an earlier map state.
vehicle *resolve_remote_vehicle( const Character &who, map &here );
vehicle *get_remote_vehicle( Character &who, map &here );
bool set_remote_vehicle( Character &who, map &here, vehicle *target );
#endif // CATA_SRC_VEHICLE_CONTROL_H
