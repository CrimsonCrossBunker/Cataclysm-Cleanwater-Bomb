local content = require("ccb").content

content.add(content.Scenario {
    id = "scenario_warper_unique_paths",
    name = content.text("Warper, Rarities and B-Sides", "scenario_male"),
    female_name = content.text("Warper, Rarities and B-Sides", "scenario_female"),
    description = content.text("As if the world ending wasn't enough, it seems some kind of extradimensional powers that be have taken an interest in you.  You have been placed on a floating island high above the Earth, safe but isolated.  Only by using the reality-bending powers of warp technology can you visit the world below in brief, randomly-targeted excursions.  Venture down, gather supplies, and return with only what you can carry to upgrade your home base and your stash over time.  The powers of the warp make you unable to ever truly die, so on failing such an expedition, you will simply lose all items and equipment you were carrying and be swiftly returned home at low health.  Given your uniqueness is it any wonder whatever power guides this island summoned you?", "scen_desc_male"),
    female_description = content.text("As if the world ending wasn't enough, it seems some kind of extradimensional powers that be have taken an interest in you.  You have been placed on a floating island high above the Earth, safe but isolated.  Only by using the reality-bending powers of warp technology can you visit the world below in brief, randomly-targeted excursions.  Venture down, gather supplies, and return with only what you can carry to upgrade your home base and your stash over time.  The powers of the warp make you unable to ever truly die, so on failing such an expedition, you will simply lose all items and equipment you were carrying and be swiftly returned home at low health.  Given your uniqueness is it any wonder whatever power guides this island summoned you?", "scen_desc_female"),
    start_name = content.text("Warper", "start_name"),
    points = 0, locations = { "sloc_skyisland" },
    flags = { "LONE_START", "CHALLENGE" },
    professions = { "xedra_chronomancer_profession", "xedra_bloodthorne_druid_profession" },
    on_start = "sky_island_start",
})

return "scenario_warper_unique_paths"
