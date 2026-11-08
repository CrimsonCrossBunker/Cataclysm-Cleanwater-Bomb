#pragma once
#ifndef CATA_SRC_MP_ITEM_SOURCE_H
#define CATA_SRC_MP_ITEM_SOURCE_H

#include "item_source.h"

namespace cata_mp
{
// Network operations share the native actor-relative item identity resolver.
using ::item_source;
using ::capture_item_source;
using ::resolve_item_source;
} // namespace cata_mp
#endif // CATA_SRC_MP_ITEM_SOURCE_H
