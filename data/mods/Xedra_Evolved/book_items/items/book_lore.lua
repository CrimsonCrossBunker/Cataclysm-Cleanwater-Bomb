local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "sylph_parchment",
        name = ccb.content.plural_text("sylph parchment", "sylph parchments"),
        description = ccb.content.text("I'm sorry that I won't be there to greet you when you awaken into sentience my offspring, but this world is dying and I must take the roads back home before they darken and grow cold.  Even if I were here you would likely find my company to be short lived as the tradition of our people is to witness the waking and greet our offspring then leave them to explore the world on their own.  However, I have summoned some lesser creatures of the underhill realms to guard this place and you for as long as they can.  Most everything else in this world will attempt to kill you.  I have included instructions for how to make a healing item as well as a developmental potion that you can take to bring yourself further into your destiny and will grant new abilities, somewhat randomly I'm afraid.  I hope that you survive long enough to become what I hoped for you to be and that you are able to find one of the trodden paths from this place into the borderlands and from there deeper into Fae where you will hopefully find me.  All of my hopes and dreams ride with you."),
        mass_milligrams = 3000,
        volume_ml = 5,
        price_cents = 0,
        symbol = "/",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "dollkin_tablet",
        name = ccb.content.plural_text("dollkin tablet", "dollkin tablets"),
        description = ccb.content.text("My dearest child, you are awaking into a cold dying world alone and without parents.  Honestly, this is for the best, for I was brought to life amongst the mortals of this realm and the parenting I would be able to pass on to you is entirely tragic.  I will spare you from that fate.  However, I have summoned some lesser creatures of the underhill realms to guard this place and you for as long as they can.  Most everything else in this world will attempt to kill you.  I have included instructions for how to make a healing item as well as a developmental potion that you can take to bring yourself further into your destiny and will grant new abilities, somewhat randomly I'm afraid.  I hope that you survive long enough to become what I hoped for you to be and that you are able to find one of the trodden paths from this place into the borderlands and from there deeper into Fae where you will hopefully find me.  All of my hopes and dreams ride with you."),
        mass_milligrams = 3000,
        volume_ml = 5,
        price_cents = 0,
        symbol = "/",
        color = "light_gray",
    }
    book:material("stone", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "flametouched_parchment",
        name = ccb.content.plural_text("flametouched parchment", "flametouched parchments"),
        description = ccb.content.text("If you are reading this you have woken up to sentience as I planned.  My timing however was not great in that I've been forced to leave before showing you the hunting ground that I've brought you into existence in.  How I envy the experience you will have rampaging through the ashes of the old world.  There is significant danger in this world and in time you will be one of the most dangerous beings in it.  However, since that time is not yet I have summoned some lesser creatures of the underhill realms to guard this place and you for as long as they can.  Most everything else in this world will attempt to kill you.  I have included instructions for how to make a healing item as well as a developmental potion that you can take to bring yourself further into your destiny and will grant new abilities, somewhat randomly I'm afraid.  I hope that you rise to the top of this crush of predators I've been forced to abandon you among.  Good luck and good hunting."),
        mass_milligrams = 3000,
        volume_ml = 5,
        price_cents = 0,
        symbol = "/",
        color = "light_gray",
    }
    book:material("stone", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "waterkin_tablet",
        name = ccb.content.plural_text("waterkin tablet", "waterkin tablets"),
        description = ccb.content.text("Spawn of my intentions, I address you from across space and time on today the day of your hatching.  As is the custom of our people you have been left in an uncivilized and barbaric place.  You must make your way back to us to become one of us.  For now you will take a name like those of the dead civilization we've deposited you in.  While you must develop on your own and find your way back to us, I have summoned some lesser creatures of the underhill realms to guard this place and you for as long as they can.  Most everything else in this world will attempt to kill you, be sure to kill it first.  I have included instructions for how to make a healing item as well as a developmental potion that you can take to bring yourself further into your destiny and will grant new abilities, somewhat randomly I'm afraid.  The depths will tremble one day in your wake and upon that day you will know how to find us.  If you fail we shall never know your name, like all the other lost children."),
        mass_milligrams = 3000,
        volume_ml = 5,
        price_cents = 0,
        symbol = "/",
        color = "light_gray",
    }
    book:material("stone", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "plantkin_parchment",
        name = ccb.content.plural_text("plantkin parchment", "plantkin parchments"),
        description = ccb.content.text("My beloved child, the Cataclysm struck at this world at a crucial time in your development and we were forced to leave you behind to be born alone or to mercy kill the life you were becoming.  When that was the choice upon us it felt like no choice at all.  If that was the kinder fate, I am sorry but my hopes to meet you one day were too strong.  I am shamed that our clan will be unable to provide you shade and company but, I have summoned some lesser creatures of the underhill realms to guard this place and you for as long as they can.  Most everything else in this world will attempt to kill you.  I have included instructions for how to make a healing item as well as a developmental potion that you can take to bring yourself further into your destiny and will grant new abilities, somewhat randomly I'm afraid.  I hope that you survive long enough to become what I hoped for you to be and that you are able to find one of the trodden paths from this place into the borderlands and from there deeper into Fae where you will hopefully find me.  All of my hopes and dreams ride with you."),
        mass_milligrams = 3000,
        volume_ml = 5,
        price_cents = 0,
        symbol = "/",
        color = "light_gray",
    }
    book:material("stone", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "earthkin_tablet",
        name = ccb.content.plural_text("earthkin tablet", "earthkin tablets"),
        description = ccb.content.text("Brethren of soil and stone.  How our tribe longed to see you stretch forth from the forming pit like so many others before you.  It is shame that will take many generations of our people to wash away that we were unable to stay to bring you with us.  However, I have summoned some lesser creatures of the underhill realms to guard this place and you for as long as they can.  Most everything else in this world will attempt to kill you.  I have included instructions for how to make a healing item as well as a developmental potion that you can take to bring yourself further into your destiny and will grant new abilities, somewhat randomly I'm afraid.  I hope that you survive long enough to become what I hoped for you to be and that you are able to find one of the trodden paths from this place into the borderlands and from there deeper into Fae where you will hopefully find me.  We await you joining our chorus in the deep caves of Fae, once you find your way here."),
        mass_milligrams = 3000,
        volume_ml = 5,
        price_cents = 0,
        symbol = "/",
        color = "light_gray",
    }
    book:material("stone", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 0,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "grimy_recipe",
        category = "manuals",
        symbol = "0",
        color = "white",
        name = ccb.content.plural_text("grimy handwritten recipe", "grimy handwritten recipes"),
        description = ccb.content.text("A scrap of paper.  Something's written on it, scrawled in bad handwriting.  You can barely make out the words 'Blood treatment' followed by a list of ingredients."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 1000,
        volume_ml = 1,
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:clear_flags()
    book:flag("TRADER_AVOID")
    book:book {
        required_level = 1,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 300,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "cooking",
    }
    content.add(book)
end
