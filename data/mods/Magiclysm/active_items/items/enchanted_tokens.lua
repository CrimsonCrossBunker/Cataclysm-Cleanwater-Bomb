local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "mtoken",
        abstract = true,
        name = ccb.content.plural_text("magic token", "magic tokens"),
        category = "other",
        mass_milligrams = 8000,
        volume_ml = 1,
        price_cents = 25000,
        symbol = "o",
        color = "light_gray",
    }
    item:material("silver", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "mtoken_longsword",
        copy_from = "mtoken",
        name = ccb.content.plural_text("longsword token", "longsword tokens"),
        description = ccb.content.text("A large silver coin that, when activated by uttering the word on the back, turns into the item pictured on the front, in this case a longsword."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "longsword" },
        menu_text = ccb.content.text("Whisper command"),
        moves = 200,
        message = ccb.content.text("You say the command word engraved on the token, and it rapidly grows and morphs into a shiny pristine longsword!"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "mtoken_arming_sword",
        copy_from = "mtoken",
        name = ccb.content.plural_text("arming sword token", "arming sword tokens"),
        description = ccb.content.text("A large silver coin that, when activated by uttering the word on the back, turns into the item pictured on the front, in this case an arming sword."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "arming_sword" },
        menu_text = ccb.content.text("Whisper command"),
        moves = 200,
        message = ccb.content.text("You say the command word engraved on the token, and it rapidly grows and morphs into a shiny pristine arming sword!"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "mtoken_broadsword",
        copy_from = "mtoken",
        name = ccb.content.plural_text("broadsword token", "broadsword tokens"),
        description = ccb.content.text("A large silver coin that, when activated by uttering the word on the back, turns into the item pictured on the front, in this case a broadsword."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "broadsword" },
        menu_text = ccb.content.text("Whisper command"),
        moves = 200,
        message = ccb.content.text("You say the command word engraved on the token, and it rapidly grows and morphs into a shiny pristine broadsword!"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "mtoken_battleaxe",
        copy_from = "mtoken",
        name = ccb.content.plural_text("battle axe token", "battle axe tokens"),
        description = ccb.content.text("A large silver coin that, when activated by uttering the word on the back, turns into the item pictured on the front, in this case a battle axe."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "battleaxe" },
        menu_text = ccb.content.text("Whisper command"),
        moves = 200,
        message = ccb.content.text("You say the command word engraved on the token, and it rapidly grows and morphs into a shiny pristine battle axe!"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "mtoken_pike",
        copy_from = "mtoken",
        name = ccb.content.plural_text("pike token", "pike tokens"),
        description = ccb.content.text("A large silver coin that, when activated by uttering the word on the back, turns into the item pictured on the front, in this case a pike."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "pike" },
        menu_text = ccb.content.text("Whisper command"),
        moves = 200,
        message = ccb.content.text("You say the command word engraved on the token, and it rapidly grows and morphs into a shiny pristine pike!"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "mtoken_mace",
        copy_from = "mtoken",
        name = ccb.content.plural_text("mace token", "mace tokens"),
        description = ccb.content.text("A large silver coin that, when activated by uttering the word on the back, turns into the item pictured on the front, in this case a mace."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "mace" },
        menu_text = ccb.content.text("Whisper command"),
        moves = 200,
        message = ccb.content.text("You say the command word engraved on the token, and it rapidly grows and morphs into a shiny pristine mace!"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "mtoken_q_staff",
        copy_from = "mtoken",
        name = ccb.content.plural_text("quarterstaff token", "quarterstaff tokens"),
        description = ccb.content.text("A large silver coin that, when activated by uttering the word on the back, turns into the item pictured on the front, in this case a quarterstaff."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "q_staff" },
        menu_text = ccb.content.text("Whisper command"),
        moves = 200,
        message = ccb.content.text("You say the command word engraved on the token, and it rapidly grows and morphs into a pristine quarterstaff!"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "mtoken_hammer",
        copy_from = "mtoken",
        name = ccb.content.plural_text("hammer token", "hammer tokens"),
        description = ccb.content.text("A large silver coin that, when activated by uttering the word on the back, turns into the item pictured on the front, in this case a hammer."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "hammer" },
        menu_text = ccb.content.text("Whisper command"),
        moves = 200,
        message = ccb.content.text("You say the command word engraved on the token, and it rapidly grows and morphs into a shiny pristine hammer!"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "mtoken_screwdriver_set",
        copy_from = "mtoken",
        name = ccb.content.plural_text("screwdriver set token", "screwdriver set tokens"),
        description = ccb.content.text("A large silver coin that, when activated by uttering the word on the back, turns into the item pictured on the front, in this case a screwdriver."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "screwdriver_set" },
        menu_text = ccb.content.text("Whisper command"),
        moves = 200,
        message = ccb.content.text("You say the command word engraved on the token, and it rapidly grows and morphs into a shiny pristine screwdriver set!"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "mtoken_crowbar",
        copy_from = "mtoken",
        name = ccb.content.plural_text("crowbar token", "crowbar tokens"),
        description = ccb.content.text("A large silver coin that, when activated by uttering the word on the back, turns into the item pictured on the front, in this case a crowbar."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "crowbar" },
        menu_text = ccb.content.text("Whisper command"),
        moves = 200,
        message = ccb.content.text("You say the command word engraved on the token, and it rapidly grows and morphs into a shiny pristine crowbar!"),
    }
    content.add(item)
end
