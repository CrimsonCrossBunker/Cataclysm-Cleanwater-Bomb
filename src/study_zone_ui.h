#pragma once
#ifndef CATA_SRC_STUDY_ZONE_UI_H
#define CATA_SRC_STUDY_ZONE_UI_H

#include <map>
#include <set>
#include <string>

#include "type_id.h"

enum class study_zone_ui_result {
    canceled,
    successful,
    changed,
};

class study_zone_options;

// The menu edits a detached copy and applies choices only on confirmation.
study_zone_ui_result query_study_zone_skills( study_zone_options &options );

#endif // CATA_SRC_STUDY_ZONE_UI_H
