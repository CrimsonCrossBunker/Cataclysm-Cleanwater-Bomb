#pragma once
#ifndef CATA_SRC_REGIONAL_CLIMATE_H
#define CATA_SRC_REGIONAL_CLIMATE_H

#include <array>
#include <optional>
#include <string>

class JsonObject;

namespace regional_climate
{
struct coordinates {
    double latitude;
    double longitude;
};

enum class rain_system { frontal, monsoon, convective, trade_wind, count };

struct monthly_normal {
    double low_c = 0;
    double high_c = 0;
    double precipitation_mm = 0;
    double wet_days = 0;
    std::array<double, static_cast<unsigned>( rain_system::count )> system_weights{};

    rain_system dominant_system() const;
};

struct normals {
    std::array<monthly_normal, 12> months;

    double annual_precipitation_mm() const;
};

// WGS84 latitude/longitude in degrees. East and north are positive.
// This coarse lookup is intended for the United States, including Alaska and Hawaii.
std::optional<normals> at( coordinates location );
std::optional<coordinates> station_location( const std::string &id );
// Local geodetic offsets from the starting station. One map square is one metre.
coordinates offset_metres( coordinates origin, double east, double north );

// Water-equivalent rate for a deterministic weather event. hour is local time in [0, 24).
double precipitation_rate( const monthly_normal &normal, double days_in_game_month,
                           double hour, int day, unsigned seed, double spatial_phase = 0 );

void load_station( const JsonObject &jo, const std::string &src );
void reset();
} // namespace regional_climate

#endif // CATA_SRC_REGIONAL_CLIMATE_H
