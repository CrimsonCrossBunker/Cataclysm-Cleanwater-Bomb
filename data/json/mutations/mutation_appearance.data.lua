local ccb = require("ccb")

ccb.content.define_mutation {
    id = "eye_color",
    name = ccb.content.text("Eye color"),
    description = ccb.content.text("You have eyes."),
    points = 0,
    starting_trait = true,
    valid = false,
    player_display = true,
    vanity = true,
    variants = {
        {
            id = "blue",
            name = ccb.content.text("Eye color: blue"),
            description = ccb.content.text("You have blue eyes."),
            weight = 1,
        },
        {
            id = "brown",
            name = ccb.content.text("Eye color: brown"),
            description = ccb.content.text("You have brown eyes."),
            weight = 1,
        },
        {
            id = "hazel",
            name = ccb.content.text("Eye color: hazel"),
            description = ccb.content.text("You have hazel eyes."),
            weight = 1,
        },
        {
            id = "amber",
            name = ccb.content.text("Eye color: amber"),
            description = ccb.content.text("You have amber eyes."),
            weight = 1,
        },
        {
            id = "gray",
            name = ccb.content.text("Eye color: gray"),
            description = ccb.content.text("You have gray eyes."),
            weight = 1,
        },
        {
            id = "green",
            name = ccb.content.text("Eye color: green"),
            description = ccb.content.text("You have green eyes."),
            weight = 1,
        },
    },
    types = { "eye_color" },
}

ccb.content.define_mutation {
    id = "SKIN_DARK",
    name = ccb.content.text("Skin tone: dark brown"),
    description = ccb.content.text("You have a dark brown skin tone."),
    points = 0,
    starting_trait = true,
    valid = false,
    player_display = true,
    vanity = true,
    types = { "skin_tone" },
}

ccb.content.define_mutation {
    id = "SKIN_LIGHT",
    name = ccb.content.text("Skin tone: light"),
    description = ccb.content.text("You have a light peach skin tone."),
    points = 0,
    starting_trait = true,
    valid = false,
    player_display = true,
    vanity = true,
    types = { "skin_tone" },
}

ccb.content.define_mutation {
    id = "SKIN_MEDIUM",
    name = ccb.content.text("Skin tone: light brown"),
    description = ccb.content.text("You have a light brown skin tone."),
    points = 0,
    starting_trait = true,
    valid = false,
    player_display = true,
    vanity = true,
    types = { "skin_tone" },
}

ccb.content.define_mutation {
    id = "SKIN_PINK",
    name = ccb.content.text("Skin tone: rose"),
    description = ccb.content.text("You have a rosy pink skin tone."),
    points = 0,
    starting_trait = true,
    valid = false,
    player_display = true,
    vanity = true,
    types = { "skin_tone" },
}

ccb.content.define_mutation {
    id = "SKIN_TAN",
    name = ccb.content.text("Skin tone: bronze"),
    description = ccb.content.text("You have a bronze or tan skin tone."),
    points = 0,
    starting_trait = true,
    valid = false,
    player_display = true,
    vanity = true,
    types = { "skin_tone" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_NONE",
    name = ccb.content.text("Facial hair: none"),
    description = ccb.content.text("You have no hair on your face, it is shaven or simply untouched by the presence of hair."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = false,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_GOATEE",
    name = ccb.content.text("Facial hair: goatee"),
    description = ccb.content.text("You have a short beard at the tip of your chin."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_CIRCLE",
    name = ccb.content.text("Facial hair: circle beard"),
    description = ccb.content.text("You have a mustache and a short beard, that both form a circle around your lips."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_ROYALE",
    name = ccb.content.text("Facial hair: royale beard"),
    description = ccb.content.text("You have a mustache and a short beard forming a patch under your lips."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_ANCHOR",
    name = ccb.content.text("Facial hair: anchor beard"),
    description = ccb.content.text("You have a mustache and a beard starting with a strip going down from the bottom lip, then tracing the jaw lines.  It looks a bit like an anchor, thus the name."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_SHORTBOXED",
    name = ccb.content.text("Facial hair: short boxed beard"),
    description = ccb.content.text("You have a mustache and a short beard with trimmed sides.  Thin patches connect them both, forming a 'box' around the lips, thus the name."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_CHEVRON",
    name = ccb.content.text("Facial hair: chevron mustache"),
    description = ccb.content.text("You have a mustache that covers your entire top lip."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_3DAYSTUBBLE",
    name = ccb.content.text("Facial hair: 3-day stubble"),
    description = ccb.content.text("You have a short trimmed mustache and beard imitating a 3-day stubble."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_HORSESHOE",
    name = ccb.content.text("Facial hair: horseshoe"),
    description = ccb.content.text("You have a mustache with patches going down the chin from both ends, thus the name."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_MUSTACHE",
    name = ccb.content.text("Facial hair: original mustache"),
    description = ccb.content.text("You have a mustache with shortened ends, that covers only the skin above your upper lip."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_MUTTONCHOPS",
    name = ccb.content.text("Facial hair: mutton chops beard"),
    description = ccb.content.text("You have long sideburns that connect to your mustache, with the tip of the chin shaven clean."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_GUNSLINGER",
    name = ccb.content.text("Facial hair: gunslinger beard"),
    description = ccb.content.text("You have a horseshoe mustache and disconnected sideburns."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_CHIN_STRIP",
    name = ccb.content.text("Facial hair: chin strip"),
    description = ccb.content.text("You have a short beard in a form of a vertical patch under your bottom lip."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_CHIN_CURTAIN",
    name = ccb.content.text("Facial hair: chin curtain"),
    description = ccb.content.text("You have a full beard without a mustache, restricted to the chin, sometimes called a 'lion's mane'. Much like Abraham Lincoln's beard."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_CHIN_STRAP",
    name = ccb.content.text("Facial hair: chin strap"),
    description = ccb.content.text("You have a beard along the jaw lines, circling the chin, and no mustache."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_BEARD",
    name = ccb.content.text("Facial hair: beard"),
    description = ccb.content.text("You have a mustache and a long beard, both formed by allowing free growth of hair, with no particular styling."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_HANDLEBAR",
    name = ccb.content.text("Facial hair: handlebar mustache"),
    description = ccb.content.text("You have a mustache with long flared out ends."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_NECKBEARD",
    name = ccb.content.text("Facial hair: neckbeard"),
    description = ccb.content.text("You have a beard formed from hair grown on neck below the chin line.  No mustache included."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_PENCIL",
    name = ccb.content.text("Facial hair: pencil mustache"),
    description = ccb.content.text("You have a very thin mustache just above the line of the upper lip."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_SHENANDOAH",
    name = ccb.content.text("Facial hair: shenandoah"),
    description = ccb.content.text("Long full beard with no mustache, popular among Amish community, often with two pointed ends."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_SIDEBURNS",
    name = ccb.content.text("Facial hair: sideburns"),
    description = ccb.content.text("You have patches of hair in front of your ears, that normally would connect your hair with the beard, but they are here by themselves."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_SOUL_PATCH",
    name = ccb.content.text("Facial hair: soul patch"),
    description = ccb.content.text("You have a little bit of hair in the dip under your lower lip, and no other facial hair whatsoever."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_TOOTHBRUSH",
    name = ccb.content.text("Facial hair: toothbrush mustache"),
    description = ccb.content.text("Charlie Chaplin used to have this short patch of hair just under the nose, but then that other guy used it as a characteristic, and it became unwelcome."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_VANDYKE",
    name = ccb.content.text("Facial hair: Van Dyke"),
    description = ccb.content.text("You have a handlebar mustache with a chin strip or a small goatee."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_WALRUS",
    name = ccb.content.text("Facial hair: walrus"),
    description = ccb.content.text("You have a long thick mustache, overshadowing your lips, that somewhat resembles the facial hair of a walrus."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_ZAPPA",
    name = ccb.content.text("Facial hair: The Zappa"),
    description = ccb.content.text("You have a wide soul patch and a full mustache that extends a bit downwards at the corners of your lips."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_BEARD_LONG",
    name = ccb.content.text("Facial hair: long beard"),
    description = ccb.content.text("You have a long beard, that goes down to your chest.  Somewhat reminiscent of Santa's mustache."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}

ccb.content.define_mutation {
    id = "FACIAL_HAIR_BEARD_VERY_LONG",
    name = ccb.content.text("Facial hair: very long beard"),
    description = ccb.content.text("You have a very long beard, that goes down to your waist, like wise old mentors have."),
    points = 0,
    valid = false,
    starting_trait = true,
    player_display = true,
    vanity = true,
    types = { "facial_hair" },
}
