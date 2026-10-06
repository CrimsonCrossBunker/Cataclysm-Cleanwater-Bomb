#include "talker_furniture.h"

#include <vector>

#include "character.h"
#include "computer.h"
#include "coordinates.h"
#include "map.h"
#include "math_parser_diag_value.h"
#include "point.h"

talker_furniture_const::talker_furniture_const( computer *new_me )
{
    if( new_me ) {
        me_comp = new_me->get_safe_reference();
        last_name = new_me->name;
        last_position = new_me->loc;
    }
}

std::string talker_furniture_const::disp_name() const
{
    return me_comp ? me_comp->name : last_name;
}

int talker_furniture_const::posx( const map &here ) const
{
    return pos_bub( here ).x();
}

int talker_furniture_const::posy( const map &here ) const
{
    return pos_bub( here ).y();
}

int talker_furniture_const::posz() const
{
    return pos_abs().z();
}

tripoint_bub_ms talker_furniture_const::pos_bub( const map &here ) const
{
    return here.get_bub( pos_abs() );
}

tripoint_abs_ms talker_furniture_const::pos_abs() const
{
    return me_comp ? me_comp->loc : last_position;
}

tripoint_abs_omt talker_furniture_const::pos_abs_omt() const
{
    return project_to<coords::omt>( pos_abs() );
}

diag_value const *talker_furniture_const::maybe_get_value( const std::string &var_name ) const
{
    return me_comp ? me_comp->maybe_get_value( var_name ) : nullptr;
}

void talker_furniture::set_value( const std::string &var_name, diag_value const &value )
{
    if( computer *comp = get_computer() ) {
        comp->set_value( var_name, value );
    }
}

void talker_furniture::remove_value( const std::string &var_name )
{
    if( computer *comp = get_computer() ) {
        comp->remove_value( var_name );
    }
}

std::vector<std::string> talker_furniture_const::get_topics( bool ) const
{
    return me_comp ? me_comp->chat_topics : std::vector<std::string> {};
}

bool talker_furniture_const::will_talk_to_u( const Character &you, bool ) const
{
    return !you.is_dead_state();
}
