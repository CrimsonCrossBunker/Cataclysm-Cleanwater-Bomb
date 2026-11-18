local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "cable_xlr",
        name = ccb.content.plural_text("XLR cable", "XLR cables"),
        description = ccb.content.text("A balanced cable used for sending audio signal.  The connectors have three prongs."),
        symbol = "o",
        color = "dark_gray",
        volume_ml = 325,
        mass_milligrams = 45000,
    }
    item:material("copper", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "cable_speaker",
        name = ccb.content.plural_text("speaker cable", "speaker cables"),
        description = ccb.content.text("This audio cable connects one speaker to a powered head, or one speaker to another."),
        symbol = "o",
        color = "dark_gray",
        volume_ml = 400,
        mass_milligrams = 90000,
    }
    item:material("copper", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "cable_instrument",
        name = ccb.content.plural_text("instrument cable", "instrument cables"),
        description = ccb.content.text("Known as an instrument cable because it is usually used to connect a guitar to a powered amp, it is an unbalanced cable with 1/4\" male connectors on each side."),
        copy_from = "cable_xlr",
        looks_like = "cable_xlr",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "headphones_circumaural",
        name = ccb.content.plural_text("headphones", "headphones"),
        description = ccb.content.text("A pair of headphones that cover your ears for improved sound quality and private listening.  This pair is from a well-known brand that is very high quality, with a detachable 1/8\" cable.  Comes with a 1/8\" to 1/4\" adapter."),
        symbol = "Ω",
        volume_ml = 400,
        mass_milligrams = 100000,
    }
    item:material("plastic", 1)
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "microphone_xlr_generic",
        name = ccb.content.plural_text("XLR microphone", "XLR microphones"),
        description = ccb.content.text("A microphone used to record or amplify sound.  Comes with a clip.  Has a 3-pin XLR connector on the bottom in order to connect to an amp."),
        symbol = "i",
        color = "dark_gray",
        volume_ml = 550,
        mass_milligrams = 265000,
    }
    item:material("plastic", 1)
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mic_stand_tall",
        name = ccb.content.plural_text("microphone stand", "microphone stands"),
        description = ccb.content.text("A lightweight telescoping boom stand made of aluminum and painted black.  About 6' tall when full extended, or 3' when closed fully.  Has threads for a mic clip on one end."),
        symbol = "Γ",
        color = "dark_gray",
        volume_ml = 2200,
        mass_milligrams = 1542000,
    }
    item:material("aluminum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "guitar_stand",
        name = ccb.content.plural_text("guitar stand", "guitar stands"),
        description = ccb.content.text("A small, oddly-shaped piece of aluminum hardware with three legs.  When placed on the ground, this can support one guitar in an upright position."),
        symbol = "y",
        color = "dark_gray",
        volume_ml = 800,
        mass_milligrams = 500000,
    }
    item:material("aluminum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "plectrum",
        name = ccb.content.plural_text("plectrum", "plectra"),
        description = ccb.content.text("A flat piece of plastic with a pointed tip, designed for plucking the strings of an instrument."),
        symbol = ",",
        color = "red",
        volume_ml = 2,
        mass_milligrams = 2000,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mixer_music",
        name = ccb.content.plural_text("mixer", "mixers"),
        description = ccb.content.text("A device with faders, switches, and knobs that mixes input signal and sends it to two output XLR cables, a left one and a right one."),
        symbol = "□",
        color = "light_gray",
        volume_ml = 8000,
        mass_milligrams = 40000000,
    }
    item:material("steel", 1)
    item:material("copper", 1)
    item:material("plastic", 1)
    content.add(item)
end
