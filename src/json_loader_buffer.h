#pragma once
#ifndef CATA_SRC_JSON_LOADER_BUFFER_H
#define CATA_SRC_JSON_LOADER_BUFFER_H

#include <memory>

class JsonValue;

// Owner-thread entry point for preloaded bytes. Uses the same flexbuffer parser
// as json_loader, retaining an immutable, null-terminated source allocation for
// error reporting without copying it or accessing world state on the I/O worker.
JsonValue json_from_owned_buffer( std::shared_ptr<const char[]> buffer );

#endif // CATA_SRC_JSON_LOADER_BUFFER_H
