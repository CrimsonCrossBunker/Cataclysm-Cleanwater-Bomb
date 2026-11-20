local ccb = require("ccb")
local content = ccb.content

-- Native profession blacklists
do
local definition = content.Blacklist {
    kind = "profession",
    whitelist = false,
}
definition:entry("helminth")
definition:entry("resistant")
definition:entry("homeless")
definition:entry("computer_literate")
definition:entry("social_skills")
definition:entry("heroin_addict")
definition:entry("smoker")
definition:entry("crackhead")
definition:entry("benzos_addict")
definition:entry("tweaker")
definition:entry("pillhead")
definition:entry("alcoholic")
definition:entry("sleepingpillhead")
definition:entry("caffiend")
definition:entry("caffeine_junkie")
definition:entry("loves_books")
definition:entry("chem_cooking")
definition:entry("swimming_beginner")
definition:entry("swimming")
definition:entry("swimming_expert")
definition:entry("wrestling_beginner")
definition:entry("wrestling")
definition:entry("wrestling_expert")
definition:entry("vid_games")
definition:entry("amateur_electronics")
content.add(definition)
end
