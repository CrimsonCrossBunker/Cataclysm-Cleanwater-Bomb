#include "map_view_cache_state.h"

#include <limits>

#include "map.h"

void map_view_cache_state::observe( map &source, character_id observer )
{
    const uint64_t revision = source.draw_cache_revision();
    if( source_.get() != &source || observer_ != observer || revision_ != revision ||
        revision == std::numeric_limits<uint64_t>::max() ) {
        dirty = true;
        source_ = source.get_context_reference();
        revision_ = revision;
        observer_ = observer;
    }
}
