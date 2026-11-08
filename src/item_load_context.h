#pragma once
#ifndef CATA_SRC_ITEM_LOAD_CONTEXT_H
#define CATA_SRC_ITEM_LOAD_CONTEXT_H

// Save files require historical migrations. A current simulation snapshot
// already contains authoritative quantities, phases, timers and identities.
// Pass the context down the item tree; never use process-wide loading flags.
enum class item_load_context {
    saved_game,
    current_state
};

#endif // CATA_SRC_ITEM_LOAD_CONTEXT_H
