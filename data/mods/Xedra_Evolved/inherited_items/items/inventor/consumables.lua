local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local function check(result)
    if not result.ok then
        error(result.error.message)
    end
end

local rip_ticket = id("item", "rip_ticket")
ccb.runtime.handler("consume_ripped_ticket", function(event)
    if event.data.spell == "rip_ticket" then
        local character = event.actors.character or services.characters.avatar()
        check(services.inventory.consume_by_type(character, rip_ticket, 1, 0))
    end
end, 1)
ccb.runtime.on("game:character_casts_spell", "consume_ripped_ticket")

local regeneration = id("spell", "cosmic_dagwood_regeneration")
ccb.runtime.handler("digest_cosmic_dagwood", function(use)
    check(services.characters.cast_spell(use.character, regeneration))
end)

do
    local item = content.Item {
        id = "cosmic_dagwood",
        name = ccb.content.plural_text("cosmic dagwood", "cosmic dagwoods"),
        description = ccb.content.text("The greatest sandwich that will ever be made, in this universe and the next.  A quadruple stacker with beer-batter fried poultry, caramel chocolate chili, and topped with a specially made sauce of egg, blue cheese, honey mustard, BBQ and extremely concentrated vinegar that oozes down the other layers, before the entire thing is pressed and grilled in a waffle iron and finished with a garnish of gold and silver flakes and a fresh fruit skewered on top.  All the gourmet chefs in existence could not even conceive such a combination which, by all means, should not taste this good - But you did it.  And you don't plan on sharing."),
        symbol = "%",
        color = "yellow",
        price_cents = 2900,
        -- The volume is intentional, like an overpriced restaurant sandwich.
        mass_grams = 950,
        volume_ml = 220,
    }
    for _, material in ipairs({ "wheat", "flesh", "tomato", "veggy", "egg", "milk", "junk", "fruit" }) do
        item:material(material, 1)
    end
    item:flag("INVENTOR_CRAFTED")
    item:comestible { type = "FOOD", calories = 900, fun = 60, quench = 24, spoils_in_turns = 86400 }
    item:vitamin("vitC", 30)
    item:vitamin("calcium", 20)
    item:vitamin("iron", 38)
    item:vitamin("meat_allergen", 1)
    item:vitamin("veggy_allergen", 1)
    item:vitamin("wheat_allergen", 1)
    item:vitamin("milk_allergen", 1)
    item:vitamin("fruit_allergen", 1)
    item:vitamin("junk_allergen", 1)
    item:on_consume("digest_cosmic_dagwood")
    content.add(item)
end

do
    local item = content.Item {
        id = "rip_ticket",
        name = ccb.content.plural_text("vancian bill", "vancian bills"),
        description = ccb.content.text("A small bill covered in odd symbols.  Tearing it will in turn cause a small dimensional tear located within a nearby entity.  Despite only lasting a few milliseconds, an internal tear in reality should be enough to kill anything.  Hopefully."),
        mass_milligrams = 1000,
        volume_ml = 1,
        symbol = "|",
        color = "brown",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("TRADER_AVOID")
    item:flag("INVENTOR_CRAFTED")
    item:clear_use_actions()
    item:cast_spell { spell = "rip_ticket", no_fail = true, level = 0, need_wielding = true }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "inventor_warp_grenade",
        category = "weapons",
        looks_like = "grenade",
        name = ccb.content.plural_text("netherium warp grenade", "netherium warp grenades"),
        description = ccb.content.text("A homemade general purpose reality implosion device.  Use this item to pull the pin and start the fuse.  After 5 seconds, everything nearby will be violently sliced, warped, aged, and partially teleported straight into many different sections of the nether.  After a short moment of instant death, the dimensional gap will probably heal.  Probably."),
        mass_milligrams = 397000,
        volume_ml = 540,
        price_cents = 1000000,
        price_postapoc_cents = 20000,
        symbol = "*",
        color = "green",
    }
    item:material("mc_steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "inventor_warp_grenade_act", timer_turns = 5 },
        need_wielding = true,
        message = ccb.content.text("You pull the pin on the %s."),
        menu_text = ccb.content.text("Pull pin"),
    }
    item:clear_flags()
    item:flag("RADIO_MODABLE")
    item:flag("RADIO_INVOKE_PROC")
    item:flag("BOMB")
    item:flag("GRENADE")
    item:flag("INVENTOR_CRAFTED")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "inventor_warp_grenade_act",
        category = "weapons",
        name = ccb.content.plural_text("active netherium warp grenade", "active netherium warp grenades"),
        description = ccb.content.text("This netherium warp grenade is active, and will explode any second now.  Continue holding it to die in the messiest and most violent of ways imaginable"),
        mass_milligrams = 397000,
        volume_ml = 270,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = "*",
        color = "green",
        countdown_turns = 5,
    }
    item:material("mc_steel", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:message_on_use {
        message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
        menu_text = ccb.content.text("Pull pin"),
    }
    item:clear_flags()
    item:flag("BOMB")
    item:flag("TRADER_AVOID")
    item:flag("DANGEROUS")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    item:cast_spell_on_expiry { spell = "netherium_warp_grenade_detonation", no_fail = true, level = 0 }
    content.add(item)
end
