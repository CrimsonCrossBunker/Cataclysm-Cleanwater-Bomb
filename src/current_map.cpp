#include <memory>
#include <stdexcept>

#include "current_map.h"
#include "game.h"

current_map::current_map( map &initial ) : current( &initial ), base( &initial )
{
}

void current_map::set( map *new_map )
{
    base = new_map;
    if( !top ) {
        current = base;
    }
}

map &current_map::get_map()
{
    if( !current ) {
        throw std::logic_error( "Map context has no selected map" );
    }
    return *current;
}

current_map &swap_map::active_context()
{
    if( !g ) {
        throw std::logic_error( "No active game map context" );
    }
    return g->current_map;
}

swap_map::swap_map( map &new_map ) : swap_map( active_context(), new_map )
{
}

swap_map::swap_map( current_map &context, map &new_map ) :
    owner( context.lifetime.reference_to( &context ) ), target( &new_map ), previous( context.top )
{
    if( previous ) {
        previous->next = this;
    }
    context.top = this;
    context.current = target;
}

swap_map::~swap_map()
{
    if( current_map *context = owner.get() ) {
        if( previous ) {
            previous->next = next;
        }
        if( next ) {
            next->previous = previous;
        } else {
            context->top = previous;
            context->current = previous ? previous->target : context->base;
        }
    }
}

