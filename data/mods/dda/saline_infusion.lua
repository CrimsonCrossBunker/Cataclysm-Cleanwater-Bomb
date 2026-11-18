local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local duration = services.time.duration
local infusion = id("activity", "ACT_SALINE_INFUSE")

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function infuse_saline(volume, skill_level, empty_bag)
    local empty = id("item", empty_bag)
    return function(ctx)
        local character = ctx.character
        if not character then return 1 end
        if value(services.skills.level(character, "firstaid")) < skill_level then
            ctx:message(ccb.services.translate("You don't actually know how to use it properly."), "bad")
            return 1
        end

        value(services.variables.set(character, "amount_of_saline_infused", volume))
        local turns = math.floor(volume / 0.55555556)
        value(services.activities.assign_timed(character, infusion, duration(turns, "turn")))
        value(services.inventory.consume_by_type(character, id("item", ctx.item_id), 1, 0))
        value(services.inventory.receive_item(character, empty, 1))
        ctx:message(ccb.services.translate(
            "You prepare the tubing, insert the needle into a vein, and patiently wait for the saline solution to flow into your bloodstream."
        ), "good")
        return 1
    end
end

ccb.runtime.handler("infuse_saline_bag_250", infuse_saline(250, 3, "saline_bag_250_empty"))

do
    -- 250 g of solution, 5g of bag, 8 g of tube with cannula
    local item = content.Item {
        id = "saline_bag_250",
        category = "drugs",
        name = ccb.content.plural_text("small saline infusion kit", "small saline infusion kits"),
        description = ccb.content.text("A small, sealed plastic bag for liquids used in intravenous therapy, with rubber tube and cannula - all you need to perform an infusion.  Holds 250 mL of completely sterile saline, therefore it is safe to put it inside your veins, if you know how."),
        looks_like = "bag_iv",
        mass_milligrams = 263000,
        volume_ml = 295,
        price_cents = 999,
        price_postapoc_cents = 25,
        symbol = ")",
        color = "light_gray",
    }
    item:material("water", 991)
    item:material("salt", 9)
    item:material("plastic", 20)
    item:material("rubber", 32)
    item:clear_use_actions()
    item:on_use("infuse_saline_bag_250", ccb.content.text("Infuse saline"), ccb.content.text("You can use it to mitigate the consequences of blood loss.  Require health care 3 and some disinfectant."))
    content.add(item)
end

ccb.runtime.handler("infuse_saline_bag_500", infuse_saline(500, 4, "saline_bag_500_empty"))

do
    local item = content.Item {
        id = "saline_bag_500",
        copy_from = "saline_bag_250",
        looks_like = "saline_bag_250",
        name = ccb.content.plural_text("medium saline infusion kit", "medium saline infusion kits"),
        description = ccb.content.text("A sealed plastic bag for liquids used in intravenous therapy, with rubber tube and cannula - all you need to perform an infusion.  Holds 500 mL of completely sterile saline, therefore it is safe to put it inside your veins, if you know how."),
        mass_milligrams = 518000,
        volume_ml = 590,
        price_cents = 749,
        price_postapoc_cents = 50,
        symbol = ")",
        color = "light_gray",
    }
    item:clear_use_actions()
    item:on_use("infuse_saline_bag_500", ccb.content.text("Infuse saline"), ccb.content.text("You can use it to mitigate the consequences of blood loss.  Require health care 4."))
    content.add(item)
end

ccb.runtime.handler("infuse_saline_bag_1000", infuse_saline(1000, 4, "saline_bag_1000_empty"))

do
    local item = content.Item {
        id = "saline_bag_1000",
        copy_from = "saline_bag_250",
        looks_like = "saline_bag_250",
        name = ccb.content.plural_text("large saline infusion kit", "large saline infusion kits"),
        description = ccb.content.text("A large, sealed plastic bag for liquids used in intravenous therapy, with rubber tube and cannula - all you need to perform an infusion.  Holds a liter of completely sterile saline, therefore it is safe to put it inside your veins, if you know how."),
        mass_milligrams = 1028000,
        volume_ml = 1180,
        price_cents = 942,
        price_postapoc_cents = 100,
        symbol = ")",
        color = "light_gray",
    }
    item:clear_use_actions()
    item:on_use("infuse_saline_bag_1000", ccb.content.text("Infuse saline"), ccb.content.text("You can use it to mitigate the consequences of blood loss.  Require health care 4."))
    content.add(item)
end

ccb.runtime.handler("infuse_saline_bag_2000", infuse_saline(2000, 4, "saline_bag_2000_empty"))

do
    local item = content.Item {
        id = "saline_bag_2000",
        copy_from = "saline_bag_250",
        looks_like = "saline_bag_250",
        name = ccb.content.plural_text("huge saline infusion kit", "huge saline infusion kits"),
        description = ccb.content.text("A huge, sealed plastic bag for liquids used in intravenous therapy, with rubber tube and cannula - all you need to perform an infusion.  Holds two liters of completely sterile saline, therefore it is safe to put it inside your veins, if you know how."),
        mass_milligrams = 2048000,
        volume_ml = 2360,
        price_cents = 1399,
        price_postapoc_cents = 200,
        symbol = ")",
        color = "light_gray",
    }
    item:clear_use_actions()
    item:on_use("infuse_saline_bag_2000", ccb.content.text("Infuse saline"), ccb.content.text("You can use it to mitigate the consequences of blood loss.  Require health care 4."))
    content.add(item)
end
