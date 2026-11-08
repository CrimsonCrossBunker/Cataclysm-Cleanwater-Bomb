#pragma once
#ifndef CATA_SRC_BIONIC_WORLD_EFFECTS_H
#define CATA_SRC_BIONIC_WORLD_EFFECTS_H

class Character;
class map;

// Native world operations. Activation costs and player requests belong to the
// caller; false means a callback retired the operating character.
bool bionic_resonance( Character &who, map &here );
bool bionic_magnetic_attraction( Character &who, map &here );

#endif // CATA_SRC_BIONIC_WORLD_EFFECTS_H
