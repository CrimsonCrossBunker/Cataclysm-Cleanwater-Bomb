local ccb = require("ccb")

return ccb.ModDefinition {
    id = "deadly_bites",
    name = "Deadly Zombie Virus",
    authors = { "dseguin" },
    description = "Bites from zombies have a chance to inflict a permanent fatal illness.  Find and consume antivirals to stave off the disease.",
    category = "misc_additions",
    dependencies = { "ccb" },
}
