#pragma once
#ifndef CATA_SRC_GUYUAN_HUD_H
#define CATA_SRC_GUYUAN_HUD_H

class avatar;

namespace guyuan_hud
{
bool enabled();
void draw( avatar &player );
}

#endif
