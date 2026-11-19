local ccb = require("ccb")
local content = ccb.content

-- Native stable-id help topics
do
local definition = content.HelpTopic {
    id = "xedra_evolved_help_0",
    title = ccb.content.text("Xedra Evolved: Basics"),
}
definition:paragraph(ccb.content.text("Welcome to Xedra Evolved, the urban fantasy mod for Cataclysm.  This mod adds folklore based enemies, experiences and magicks to the Cataclysm.  Humans who experience particularly vivid dreams might learn how to wield them into strange magicks.  Former Xedra employees include cyborgs with stolen bionics, magick wielders and even a Gracken or two."))
definition:paragraph(ccb.content.text("The world of Xedra Evolved had decades of dimensional seepage and places where our world connected to other realities.  During these years before the Cataclysm the world became weirder.  Supernatural creatures from myth and legend returned, visited for the first time or left the shadows.  Some games you'll fight against them.  Some days you may very well be one of them."))
definition:paragraph(ccb.content.text("There are multiple types of supernatural beings that the player can start as or sometimes become.  It is intended that their abilities cannot be mixed and matched except in very specific circumstances."))
definition:paragraph(ccb.content.text("Some times you may want to play a normal game with extra enemies and no dream magick, take the Dreamless trait."))
definition:paragraph(ccb.content.text("One last thing: remember to bind the Supernatural Powers key to use your powers!"))
content.add(definition)
end
do
local definition = content.HelpTopic {
    id = "xedra_evolved_help_1",
    title = ccb.content.text("Xedra Evolved: Possible Starts"),
}
definition:paragraph(ccb.content.text("Cyborg starts exist in XE.  However, those cbms inside of you were pulled out of dead Exodii offworld.  Now that the Exodii are here on planet don't expect them to help you."))
definition:paragraph(ccb.content.text("If you are interested in starting with significant dream magick, look at the four melded task force professions."))
definition:paragraph(ccb.content.text("To start as a werewolf, newly bitten vampire, Lilit, elemental fae, or Chronomancer look at the mod specific scenarios."))
definition:paragraph(ccb.content.text("There are a number of more mundane/less high powered starts available such as a foreign spy, cryptid hunter all the way to hedge magician and changeling."))
content.add(definition)
end
do
local definition = content.HelpTopic {
    id = "xedra_evolved_help_2",
    title = ccb.content.text("Xedra Evolved: Learning New Powers"),
}
definition:paragraph(ccb.content.text("Both the Dreamsmith and Mad Inventor classes have research actions that you can perform.  They will often fail, but each failure moves the percentage chance for your next attempt to succeed up until it hits 100%."))
definition:paragraph(ccb.content.text("Alchemy can be discovered in game.  It requires some luck to find it in the game world, but if you selected Bombastic Perks mod as an additional mod, you can learn Alchemy easily via the perk system."))
definition:paragraph(ccb.content.text("Vampires will get a random assortment of powers as they age up and grow.  Every run as a vampire should have a slightly different mix of powers.  By surviving and drinking blood you will learn some powers, but if you miss one you really want you can learn how to research new powers from the Vampire Mentor NPCs."))
definition:paragraph(ccb.content.text("Dhampir gain new powers based on how frequently they use their blood for vampiric powers, this can encourage them to take the shortcut of drinking human blood."))
definition:paragraph(ccb.content.text("Elemental Fae, Paraclesians need to gather samples from the other elements and make potions that grant them new powers."))
definition:paragraph(ccb.content.text("Werewolves gain new powers from killing monsters in hand to hand."))
definition:paragraph(ccb.content.text("The Chronomancer gains ability experience by surviving, by killing monsters while covered with a Chronomancer aura, and by killing time shifted/powerful monsters."))
definition:paragraph(ccb.content.text("Lilit need to be outside under the moon at night in order to have chances at gaining new powers, it's a low chance so be out hunting every night to make sure you take every opportunity to learn new powers."))
definition:paragraph(ccb.content.text("Gracken are a work in progress but the idea is that they are monster hunters who take parts of their kills and use those parts to transform themselves in new and different ways.  Look in their Gracken recipe tab."))
content.add(definition)
end
