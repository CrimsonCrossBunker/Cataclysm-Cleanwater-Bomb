local ccb = require("ccb")
local content = ccb.content

-- Native stable-id help topics
do
local definition = content.HelpTopic {
    id = "aftershock_exoplanet_help_0",
    title = ccb.content.text("Aftershock Exoplanet: Basics"),
}
definition:paragraph(ccb.content.text("The Aftershock Exoplanet is a total conversion mod for Cataclysm: DDA.  This game takes place in the distant future on the edges of civilized space on a frozen planet named Salus IV."))
definition:paragraph(ccb.content.text("In the Aftershock timeline, the Cataclysm that changed everything happened centuries ago when suddenly faster than light travel, artificial intelligence, and a variety of other sciences that relied upon a weird physics interaction between two dimensions stopped working with no warning."))
definition:paragraph(ccb.content.text("It took humanity centuries to become interstellar again after the Discontinuity occurred and there are many objects from pre-collapse civilizations that still work in now wondrous ways but can never be replicated."))
definition:paragraph(ccb.content.text("Salus IV is the frozen planet that our game is set upon.  A terraforming project started before the Discontinuity but not long enough before that the terraforming process got very far."))
definition:paragraph(ccb.content.text("One last thing: remember to bind the Supernatural Powers key to use your powers if you are an esper!"))
content.add(definition)
end
do
local definition = content.HelpTopic {
    id = "aftershock_exoplanet_help_1",
    title = ccb.content.text("Aftershock Exoplanet: Possible Starts"),
}
definition:paragraph(ccb.content.text("You will have to start in Port Augustmoon and survive a week before you can engage in other starts on Aftershock.  Significant feedback has shown that people will often start the Challenge starts and then immediately death spiral because they don't yet understand that power and heat are the most important resources in the early game.  Port Augustmoon provides both of those in abundance which allows you to explore the world and come back when you need to."))
definition:paragraph(ccb.content.text("Once you've gained some experience with Salus IV and the Aftershock activity cycle, you can experience more challenging starts where you may not have enough power or heat to survive without quick wits."))
definition:paragraph(ccb.content.text("There are a variety of crashing starship starts each with their own challenges.  You can start as a genetically and cybernetically modified soldier.  Or even as an esper, who has psychic abilities."))
content.add(definition)
end
do
local definition = content.HelpTopic {
    id = "aftershock_exoplanet_help_2",
    title = ccb.content.text("Aftershock Exoplanet: Suggestions"),
}
definition:paragraph(ccb.content.text("Remember to buy things that provide heat and power before you leave Port Augustmoon."))
definition:paragraph(ccb.content.text("If you start as a bounty hunter in the crashed ship, your ship may have one last trick to save your life."))
definition:paragraph(ccb.content.text("If you start in the crashing ship, move quickly towards the exits and don't dawdle exploring or it will be one of the fastest games you've played."))
definition:paragraph(ccb.content.text("You can gain genetic modifications or esper techniques via exploring Salus IV.  However you cannot have both, one will break the other."))
definition:paragraph(ccb.content.text("We hope you enjoy Aftershock: Exoplanet and if you have any ideas to add to it or bugs to report we hope to see you on GitHub."))
content.add(definition)
end
