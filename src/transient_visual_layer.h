#pragma once
#ifndef CATA_SRC_TRANSIENT_VISUAL_LAYER_H
#define CATA_SRC_TRANSIENT_VISUAL_LAYER_H

/** Forward skeleton for a unified transient-effect catalogue.
 *
 *  Currently the handle index, bubble helpers, and per-effect containers
 *  live directly in cata_tiles.  Once the rendering layer is split into a
 *  separate compilation unit this class will become the authoritative owner
 *  of all transient visual effects and their lifecycle management.
 *
 *  TODO: migrate alloc_handle / cancel_effect / bubble helpers and
 *        container ownership from cata_tiles into this class.
 */
class transient_visual_layer
{
};

#endif // CATA_SRC_TRANSIENT_VISUAL_LAYER_H
