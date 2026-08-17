#pragma once
#ifndef CATA_SRC_VEHICLE_PRICE_H
#define CATA_SRC_VEHICLE_PRICE_H

class vehicle;

/** Sum the base-item value of all installed, non-removed vehicle parts. */
int vehicle_part_base_price( const vehicle &veh, bool post_cataclysm );

/** Value liquid engine fuels carried in the vehicle's tanks after the Cataclysm. */
int vehicle_tank_fuel_price_postapoc( const vehicle &veh );

#endif // CATA_SRC_VEHICLE_PRICE_H
