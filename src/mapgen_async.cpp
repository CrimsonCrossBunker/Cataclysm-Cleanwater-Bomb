#include "mapgen_async.h"

template <typename T> class string_id;

namespace mapgen_defer
{

void drain()
{
    // No-op: Lua hooks not yet ported.
}

void push_autonote( const tripoint_abs_omt & /*pos*/,
                    const string_id<map_extra> & /*extra*/ )
{
    // No-op: auto_note is main-thread-only.
    // Deferred autonote logic will be hooked in when worker mapgen is enabled.
}

} // namespace mapgen_defer
