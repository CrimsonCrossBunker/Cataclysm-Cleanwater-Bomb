#include "vehicle_uid.h"

#include <memory>
#include <ostream>

#include "game.h"
#include "json.h"

int64_t generate_next_vehicle_uid()
{
    if( !g ) {
        return 0;
    }
    return g->assign_vehicle_uid();
}

void vehicle_uid::serialize( JsonOut &jsout ) const
{
    jsout.write( value );
}

void vehicle_uid::deserialize( int64_t i )
{
    value = i;
}

std::ostream &operator<<( std::ostream &o, const vehicle_uid &id )
{
    return o << id.get_value();
}
