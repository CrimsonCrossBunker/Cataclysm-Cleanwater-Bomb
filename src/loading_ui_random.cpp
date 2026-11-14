#include "loading_ui_random.h"

#include <chrono>

#include "options.h"
#include "path_info.h"
#include "text_snippets.h"
#include "translation.h"

loading_ui::random_choices::random_choices() :
    random_choices( static_cast<unsigned int>(
                        std::chrono::steady_clock::now().time_since_epoch().count() ) )
{
}

loading_ui::random_choices::random_choices( unsigned int seed ) : engine( seed )
{
}

std::string loading_ui::random_choices::tip()
{
    return SNIPPET.random_from_category( "tip", engine() ).value_or( translation() ).translated();
}

cata_path loading_ui::random_choices::image( const std::vector<cata_path> &images )
{
    if( images.empty() ) {
        return cata_path();
    }
    return images[std::uniform_int_distribution<size_t>( 0, images.size() - 1 )( engine )];
}

std::string loading_ui::random_choices::title( holiday current_holiday )
{
    const bool alternate = std::uniform_int_distribution<int>( 0, 99 )( engine ) <
                           get_option<int>( "ALT_TITLE" );
    return PATH_INFO::title( current_holiday, alternate );
}
