#include "mp_queue.h"

namespace cata_mp
{

event_queue &get_mp_queue()
{
    static event_queue instance;
    return instance;
}

} // namespace cata_mp
