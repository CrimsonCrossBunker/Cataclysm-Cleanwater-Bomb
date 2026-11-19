local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_lizardfolk_warrior_hostile",
    copy_from = "mon_lizardfolk_warrior",
    name = ccb.content.plural_text("lizardfolk warrior", "lizardfolk warriors"),
    description = ccb.content.text("A tall, powerful, reptilian humanoid with a muscular tail whose skin is covered in dark gray-green scales.  They are coldblooded and primarily live in swamps."),
    default_faction = "lizardfolk_hostile",
    aggression = 30,
}

ccb.content.define_monster {
    id = "mon_lizardfolk_hunter_hostile",
    name = ccb.content.plural_text("lizardfolk hunter", "lizardfolk hunters"),
    description = ccb.content.text("The hunter is smaller than a warrior, but equally as deadly, with their lithe figures and accurate javelin throws."),
    copy_from = "mon_lizardfolk_hunter",
    default_faction = "lizardfolk_hostile",
    aggression = 30,
}
