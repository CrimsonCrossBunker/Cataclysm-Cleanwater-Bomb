#pragma once
#ifndef CATA_SRC_SAVE_SNAPSHOT_H
#define CATA_SRC_SAVE_SNAPSHOT_H

#include <cstdint>
#include <string>
#include <vector>

class cata_path;

/**
 * Snapshot-based multi-save system.
 *
 * Because NPCs, factions, missions, the map and the overmap are all
 * world-level state in CDDA (stored in master.gsav / maps/ / overmaps/),
 * the only way to capture a self-consistent, isolated save is to snapshot
 * the ENTIRE world directory. A snapshot is therefore a recursive copy of
 * a world's folder (excluding the snapshots/ subfolder itself).
 *
 * This pairs with the one-character-per-world enforcement: one world holds
 * exactly one character plus its world state, so a world snapshot is a clean
 * "save slot".
 *
 * These functions operate purely on disk and are decoupled from any running
 * game: callers that have a live game must persist it (game::save) before
 * snapshotting and reload it (game::reload_active_save) after restoring.
 */
namespace save_snapshot
{

// Metadata describing a single snapshot slot, read back from its meta file
// for display in the snapshot menu.
struct snapshot_info {
    // Folder name of the snapshot under <world>/snapshots/ (sanitized slot name).
    std::string dir_name;
    // Human-readable slot name as entered by the player.
    std::string name;
    // Name of the character at snapshot time.
    std::string character_name;
    // In-game turn at snapshot time (calendar::turn), 0 if unknown.
    int turn = 0;
    // Real-world unix timestamp when the snapshot was taken, 0 if unknown.
    int64_t real_time = 0;

    // Menu label: "<name> — <date> (<character>)", omitting unknown parts.
    std::string display_label() const;
};

// What the user chose in the shared snapshot menu.
enum class menu_action {
    none,   // cancelled
    create, // make a new snapshot (see new_name)
    load,   // restore the chosen snapshot (see chosen)
    remove, // delete the chosen snapshot (see chosen)
};

struct menu_selection {
    menu_action action = menu_action::none;
    std::string new_name;   // for create: the raw name the player entered
    snapshot_info chosen;   // for load/remove: the selected snapshot
};

/**
 * Build and run the snapshot list menu for @p world_dir once, returning the
 * user's intent. Shared by the in-game and main-menu entry points; the caller
 * performs the context-specific work (saving/reloading vs. plain file ops).
 * @param title menu title text.
 * @param restore_verb label for the restore action ("Load" in-game, "Restore"
 *        from the main menu).
 */
menu_selection query_snapshot_menu( const cata_path &world_dir,
                                    const std::string &title,
                                    const std::string &restore_verb );

/**
 * Copy the entire world directory at @p world_dir into a new snapshot slot
 * named @p slot_name (replacing any existing slot of that name) and write a
 * meta file describing it. Does NOT save the running game first.
 * @return true on success.
 */
bool make_snapshot( const cata_path &world_dir, const std::string &slot_name,
                    const std::string &character_name, int turn );

/**
 * Scan <world_dir>/snapshots/ and return info for every snapshot found,
 * ordered by real-world capture time (newest first).
 */
std::vector<snapshot_info> list_snapshots( const cata_path &world_dir );

/**
 * Whether a snapshot slot whose folder matches @p slot_name (after the same
 * filename sanitization make_snapshot applies) already exists. Lets the UI warn
 * before make_snapshot silently replaces a slot — including the case where two
 * distinct display names sanitize to the same folder.
 */
bool snapshot_exists( const cata_path &world_dir, const std::string &slot_name );

/**
 * Replace the world files at @p world_dir with the snapshot's copy
 * (preserving the snapshots/ folder). Does NOT reload the running game.
 * @return true on success.
 */
bool restore_snapshot( const cata_path &world_dir, const std::string &dir_name );

/**
 * Permanently delete the snapshot @p dir_name under @p world_dir.
 * @return true on success.
 */
bool delete_snapshot( const cata_path &world_dir, const std::string &dir_name );

} // namespace save_snapshot

#endif // CATA_SRC_SAVE_SNAPSHOT_H
