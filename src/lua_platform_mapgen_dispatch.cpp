#include "lua_platform_mapgen_dispatch.h"

#include "lua_platform_runtime.h"
#include "thread_pool.h"

namespace cata::lua_platform
{

void dispatch_mapgen_postprocess( mapgendata &data )
{
    if( !is_pool_worker_thread() ) {
        dispatch_platform_mapgen_postprocess( data );
    }
}

bool dispatch_mapgen_generate( mapgendata &data )
{
    return !is_pool_worker_thread() && dispatch_platform_mapgen_generate( data );
}

} // namespace cata::lua_platform
