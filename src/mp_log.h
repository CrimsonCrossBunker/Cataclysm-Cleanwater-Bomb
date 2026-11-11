#pragma once
#ifndef CATA_SRC_MP_LOG_H
#define CATA_SRC_MP_LOG_H

#include <string>

namespace cata_mp
{
void mp_log_host( const std::string &msg );
void mp_log_client( const std::string &msg );
} // namespace cata_mp

#endif // CATA_SRC_MP_LOG_H

