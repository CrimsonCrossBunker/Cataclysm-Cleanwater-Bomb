local content = require("ccb").content

content.set_martial_art_handler("style_none", "static", "perk_style_static")
content.set_martial_art_handler("style_none", "move", "perk_style_moved")
content.set_martial_art_handler("style_none", "pause", "perk_style_paused")
content.set_martial_art_handler("style_none", "hit", "perk_style_hit")
content.set_martial_art_handler("style_none", "dodge", "perk_style_dodged")
content.set_martial_art_handler("style_none", "block", "perk_style_blocked")
content.set_martial_art_handler("style_none", "kill", "perk_style_killed")
