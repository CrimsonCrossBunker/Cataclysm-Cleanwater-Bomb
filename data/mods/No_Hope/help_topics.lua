local ccb = require("ccb")
local content = ccb.content

-- Native stable-id help topics
do
local definition = content.HelpTopic {
    id = "no_hope_help_0",
    title = ccb.content.text("No Hope: Features"),
}
definition:paragraph(ccb.content.text("Alters domestic mapgen palettes to increase damage and messiness."))
definition:paragraph(ccb.content.text("Adds item difficulty settings that reduce the spawn rates for common item categories without reducing rare items.  See EoCs.md for category breakdowns and customisation or EoCs.json for exact numbers used for each difficulty."))
definition:paragraph(ccb.content.text("Most vehicles spawn damaged and without fuel.  Intact cars now are much, much harder to find, though not impossible (Originally the \"Cars to Wrecks\" mod)."))
definition:paragraph(ccb.content.text("Removed all turrets from military vehicles."))
definition:paragraph(ccb.content.text("More miserable weather, expect long spells of rain and fog."))
definition:paragraph(ccb.content.text("Greatly ups bandit presence (Originally the \"Extra Bandit\" mod)."))
definition:paragraph(ccb.content.text("Most LMOE shelters now have a rather high chance to spawn bandits inside.  Empty LMOEs now has a lower chance (1 for every 3 occupied) to spawn."))
definition:paragraph(ccb.content.text("Reduced chance to drop military gear from zombie soldiers."))
definition:paragraph(ccb.content.text("Gave all mechas ability to protect their operators from melee and ranged damage."))
definition:paragraph(ccb.content.text("Makes wooden walls hard to set on fire.  Fire is a very powerful out in alot of situations, this tries to make it slightly less abusable."))
definition:paragraph(ccb.content.text("Returned CBM loot in most places it was removed from (electronic stores, toxic dumps, sewage treatment plants etc)."))
definition:paragraph(ccb.content.text("Returned some cut vanilla content, including, but not limited to: laser turret (rewrote description to mention it's working not on the solar panels, but rather on compact yet powerful storage batteries; updated drop list to reflect that), chickenbot, tankbot and tripod and made it spawn in some military locations, moose's legendary aggression and flaming eye's ray of destruction.  Removed flaming eye's STARE attack.  Added almost identical monster - staring eye with STARE attack."))
definition:paragraph(ccb.content.text("Adds mutant random NPCs (Originally the \"Mutant NPCs\" mod)."))
content.add(definition)
end
do
local definition = content.HelpTopic {
    id = "no_hope_help_1",
    title = ccb.content.text("No Hope: Difficulty Options"),
}
definition:paragraph(ccb.content.text("No Hope adds 3 difficulties that allow you to pick between increasingly more harsh multipliers to spawn rates split by item category intended to make basic survival less trivial and progression slower and in turn require more exploration leading to greater risk while less powerful without decreasing the spawn rates of items such as mutagens and bionics that are intended as rewards for exploring more dangerous locations and are already rare and as such shouldn't be punished."))
definition:paragraph(ccb.content.text("The difficulty options can be used alongside the regular item spawn rate setting if desired with expected results."))
definition:paragraph(ccb.content.text("For exact numerical breakdowns of the options see difficulty.lua along with DIFFICULTY_OPTIONS.md for a barebones breakdown of which categories are affected and why."))
definition:paragraph(ccb.content.text("To change the selected option on an existing save, open Debug menu -> Console -> Lua, select No Hope, and run require(\"difficulty\").choose().  This notably won't change already generated item spawns anywhere that your reality bubble has touched."))
content.add(definition)
end
