local ccb = require("ccb")
local content = ccb.content

do
    -- The nether misunderstanding a jig, and applying sci-fi tech it 'knows' from other worlds.  Uselessly high VISE quality.
    local item = content.Item {
        id = "nl_grav_aware_jig",
        name = ccb.content.plural_text("otherworldly clamp-set", "otherworldly clamp-sets"),
        description = ccb.content.text("A set of 7 small clamps set upon a metal guide-board, each capable of rotating around in a circular configuration.  The board itself has several depressed marks, as if they're made to guide cuts, but they don't span any obvious units you're aware of.  The clamps slide in and out, toward each other, with unnatural ease.  You don't know this tool's original purpose, but you think it could clamp things quite efficiently."),
        mass_milligrams = 640000,
        volume_ml = 600,
        price_cents = 0,
        price_postapoc_cents = 700,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:quality("VISE", 10)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    content.add(item)
end

do
    -- A ROBOTIC_SURGICAL_APPARATUS for the labyrinth safehouse autodoc.
    local item = content.Item {
        id = "nl_robo_surg_app",
        name = ccb.content.plural_text("mass of robotic arms", "masses of robotic arms"),
        description = ccb.content.text("A set 6 robotic arms, folded in on themselves like a dead spider.  There are two large arms.  One ends in a human-like hand with 7 fingers, and the other in what appears to be a dome-like security camera.  The smaller arms are capped with a mix of surgical and construction tools, including a scalpel, a circular saw, some sort of suction device, and a soldering iron."),
        mass_milligrams = 20000000,
        volume_ml = 20000,
        price_cents = 0,
        price_postapoc_cents = 6000,
        symbol = ";",
        color = "yellow",
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:material("cyber_bone", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool()
    content.add(item)
end
