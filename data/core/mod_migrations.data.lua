local ccb = require("ccb")

ccb.content.define_mod_migration { id = "dda", replace_with = "ccb" }

-- Removed in 0.I
ccb.content.define_mod_migration { id = "Graphical_Overmap", removal_reason = ccb.content.text("Superseded by proper support for overmap tilesets through \"Use tiles to display overmap\" option under Graphics -> Tileset Options.") }

-- Removed in 0.I
ccb.content.define_mod_migration { id = "no_fungal_growth", removal_reason = ccb.content.text("Changes merged with vanilla making this mod redundant.") }

-- Removed in 0.I
ccb.content.define_mod_migration { id = "StatsThroughSkills", removal_reason = ccb.content.text("Hardcode that enabled this was removed and it doesn't meet repo inclusion criteria, non-hardcoded alternatives are available out of repo.") }

-- Removed in 0.J
ccb.content.define_mod_migration { id = "stats_through_kills", removal_reason = ccb.content.text("Does not meet repo requirements of offering a different, curated gameplay experience.") }

-- Removed in 0.I
ccb.content.define_mod_migration { id = "sees_player_retro", removal_reason = ccb.content.text("Superseded by \"Show overlay icons over creatures\" option under Graphics -> Tileset Options.") }

-- Removed in 0.I
ccb.content.define_mod_migration { id = "sees_player_hitbutton", removal_reason = ccb.content.text("Superseded by \"Show overlay icons over creatures\" option under Graphics -> Tileset Options.") }

-- Removed in 0.H
ccb.content.define_mod_migration { id = "No_Rail_Stations", removal_reason = ccb.content.text("Railway stations removed from vanilla and moved to \"Railroads\" mod making this mod redundant.") }

-- Removed in 0.I
ccb.content.define_mod_migration { id = "speedydex", removal_reason = ccb.content.text("Does not meet repo requirements of offering a different, curated gameplay experience.  Mod can trivially be reproduced in JSON with enchantments.") }

-- Removed in 0.J
ccb.content.define_mod_migration { id = "aftershock", removal_reason = ccb.content.text("Aftershock has been merged with \"Aftershock: Exoplanet\" as Exoplanet's mapgen is at a level where it's no longer considered WIP.  If your world is using Exoplanet already you can remove this without issue.  Adding Exoplanet to saves without it would not work well because it drastically changes world gen, consider finishing your save on the version you were using before.") }

ccb.content.define_mod_migration { id = "cdda_delight", replace_with = "cata_delight" }
