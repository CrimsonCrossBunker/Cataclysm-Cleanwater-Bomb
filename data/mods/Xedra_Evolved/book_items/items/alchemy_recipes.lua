local content = require("ccb").content

do
    -- Tier 1 begins here
    local book = content.Item {
        id = "alchemy_recipe_extra_str_aspirin",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (eXtra strength aspirin)", "scribbled notes (eXtra strength aspirin)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for extra strength aspirin.  The active ingredient is apparently hallucinogenic, which is certainly one way to stop from feeling pain."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 2,
        maximum_level = 2,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_small_blessing_brigit",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (small blessing of Brigit)", "scribbled notes (small blessing of Brigit)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for a pill to cure minor illnesses.  You're not looking forward to getting that royal jelly now that you've seen what the bees are like lately."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 2,
        maximum_level = 2,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_blackout_rage_drink",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (rage drink)", "scribbled notes (rage drink)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for some kind of energy drink.  You do a double-take when you see just how much caffeine and alcohol you're supposed to add to the recipe."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_sixdust",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (sixdust)", "scribbled notes (sixdust)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for an insecticide.  \"WEAR MASK DURING BREWING!!!!!\" is written at the bottom of the recipe"),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 6,
        maximum_level = 6,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end

do
    -- Tier 2 begins here
    local book = content.Item {
        id = "alchemy_recipe_prophets_lsd",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (prophet's LSD)", "scribbled notes (prophet's LSD)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for an extremely powerful hallucinogen.  The end product will supposedly allow you to \"see through time\"."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 6,
        maximum_level = 6,
        intelligence = 12,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "deduction",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_truckers_stamina_pills",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (alchemically altered trucker pill)", "scribbled notes (alchemically altered trucker pill)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for a \"stamina enhancement\".  The ingredients make you raise your eyebrows, but the notes in the margins indicate that you won't need to sleep for quite some time after taking them."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 2,
        maximum_level = 2,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_abyssal_coffee",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled recipe (abyssal coffee)", "scribbled recipe (abyssal coffee)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for…the perfect cup of coffee?  Whoever wrote this seems like they knew way more about coffee than you could learn even with a lifetime of research."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 2,
        maximum_level = 2,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_charm_of_marzanna",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (charm of Marzanna)", "scribbled notes (charm of Marzanna)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for an enchanted amulet.  The notes indicate wearing it should protect you from cold temperatures."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 2,
        maximum_level = 2,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_spiritshow_dust",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (spirit show dust)", "scribbled notes (spirit show dust)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for a powder to \"reveal that which is unseen\".  There are repeated references testing its effects at dusk, at crossroads, and on Halloween."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 2,
        maximum_level = 2,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_gold_from_lead",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (gold from lead)", "scribbled notes (gold from lead)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for making pure gold out of lead as its main base metal.  You've read about the futile attempts from alchemists at the middle ages, but this recipe requires some metal you've never known existed.  Surely this one will fail like the other recipes, right?"),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 2,
        maximum_level = 2,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_väinämöinens_kantele_imitation",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (Väinämöinen's Kantele, imitation)", "scribbled notes (Väinämöinen's Kantele, imitation)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for…a musical instrument?  You didn't realize that alchemy could be used to get the band back together again."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    -- Tier 3 begins here
    local book = content.Item {
        id = "alchemy_recipe_feline_periapta",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (feline periapta)", "scribbled notes (feline periapta)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for an enchanted amulet.  The notes have several parallel tears in them near the bottom."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_lupine_periapta",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (lupine periapta)", "scribbled notes (lupine periapta)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for an enchanted amulet.  The notes have \"take off before meals!!\" underlined at the bottom."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_cephalopod_periapta",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (cephalopod periapta)", "scribbled notes (cephalopod periapta)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for an enchanted amulet.  The writing gets increasingly shaky, dissolving into a series of ink blots just under the final steps of the recipe."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_plant_periapta",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (plant periapta)", "scribbled notes (plant periapta)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for an enchanted amulet.  The notes indicate that it will cause you to grow bark and to \"take off your boots first\"."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_scorpion_periapta",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (scorpion periapta)", "scribbled notes (scorpion periapta)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for an enchanted amulet.  There are several stick-figure drawings of a person with a scorpion's tail in the margins."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_butterfly_periapta",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (butterfly periapta)", "scribbled notes (butterfly periapta)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for an enchanted amulet.  The notes indicate that you \"still can't fly\" even with it on."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_spider_periapta",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (spider periapta)", "scribbled notes (spider periapta)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for an enchanted amulet.  The notes repeatedly mention \"Webs aren't really big enough to test, thank God.\""),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_cold_iron_ingot",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (cold iron ingot)", "scribbled notes (cold iron ingot)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for creating cold iron.  You note with amusement that the recipe doesn't seem to require any actual iron."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_powder_of_revelation",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (powder of revelation)", "scribbled notes (powder of revelation)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for creating some sort of powder that it claims will \"Reveal that which is hidden\"."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    -- Tier 4 begins here
    local book = content.Item {
        id = "alchemy_recipe_life_extension_potion",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (life extension potion)", "scribbled notes (life extension potion)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for the elixir of life.  If only you had found this before the world ended."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 5,
        maximum_level = 5,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_potion_strength",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (potion of terrible strength)", "scribbled notes (potion of terrible strength)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for a potion to increase your strength.  Written at the bottom is the note, \"Be very careful after drinking!\"."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 5,
        maximum_level = 5,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_potion_dex",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (potion of wicked quick hands)", "scribbled notes (potion of wicked quick hands)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for a potion to increase your dexterity.  It looks like the undead will be catching these hands."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 5,
        maximum_level = 5,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_hares_leap_potion",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (potion of hare's leap)", "scribbled notes (potion of hare's leap)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for a potion to allow you to leap a great distance.  Hopefully it also allows you land safely after those great leaps."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 5,
        maximum_level = 5,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_nether_snare",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (nether snare)", "scribbled notes (nether snare)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for a mystical trap that will allow you imprison beings from \"the Outside.\"  Based on some scribbled sketches of things it's supposed to contain, you hope it holds if you try to use it."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 3,
        maximum_level = 3,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "fabrication",
    }
    content.add(book)
end

do
    -- Tier 5 begins here
    local book = content.Item {
        id = "alchemy_recipe_plant_imbuement",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (Imbuement of the Trees)", "scribbled notes (Imbuement of the Trees)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for a method to obtain the power of nature.  The ingredients list tells you that nature is definitely not going to appreciate that."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 5,
        maximum_level = 5,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_doll_imbuement",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (Imbuement of Parchment)", "scribbled notes (Imbuement of Parchment)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for a method to obtain the power of…humanity?  More human than human, you suppose."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 7,
        maximum_level = 7,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "alchemy_recipe_fire_imbuement",
        copy_from = "schematics_generic",
        looks_like = "spell_scroll",
        name = content.plural_text("scribbled notes (Imbuement of the Flames)", "scribbled notes (Imbuement of the Flames)"),
        description = content.text("A handwritten set of notes detailing an alchemical recipe for a method to obtain the power of flames.  You hope those lines about \"the ashes of the dead\" are optional."),
        symbol = "ç",
        color = "light_green",
    }
    book:book {
        required_level = 5,
        maximum_level = 5,
        intelligence = 10,
        read_time_turns = 2700,
        fun = 0,
        chapters = 0,
        scannable = true,
        skill = "chemistry",
    }
    content.add(book)
end
