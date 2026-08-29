#include "monster_uid.h"

#include <ostream>

#include "game.h"
#include "json.h"

int64_t generate_next_monster_uid()
{
    if( !g ) {
        return 0;
    }
    return g->assign_monster_uid();
}

void monster_uid::serialize( JsonOut &jsout ) const
{
    jsout.write( value );
}

void monster_uid::deserialize( int64_t i )
{
    value = i;
}

std::ostream &operator<<( std::ostream &o, const monster_uid &id )
{
    return o << id.get_value();
}
