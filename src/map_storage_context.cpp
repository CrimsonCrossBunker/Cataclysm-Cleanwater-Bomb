#include "map_storage_context.h"

#include <filesystem>
#include <stdexcept>
#include <utility>

map_storage_context::map_storage_context( world_id world, dimension_id dimension,
        const cata_path &world_directory, bool compressed ) :
    world_( std::move( world ) ), dimension_( std::move( dimension ) ), compressed_( compressed )
{
    const std::filesystem::path dimension_path = std::filesystem::u8path( dimension_.str() );
    if( !world_.valid() || dimension_path.empty() || dimension_path.has_parent_path() ||
        dimension_path == "." || dimension_path == ".." ) {
        throw std::invalid_argument( "Invalid map storage namespace" );
    }
    const cata_path root( cata_path::root_path::unknown,
                          std::filesystem::absolute( world_directory.get_unrelative_path() ).lexically_normal() );
    directory_ = dimension_.str() == "default" ? root : root / "dimensions" / dimension_path;
    dictionary_ = root / "maps.dict";
}
