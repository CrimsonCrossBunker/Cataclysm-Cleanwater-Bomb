local ccb = require("ccb")
local content = ccb.content

do
    -- Based on the M73A riot grenade
    local item = content.Item {
        id = "gasbomb",
        copy_from = "abstract_gas_bomb_inactive",
        name = ccb.content.plural_text("tear gas grenade", "tear gas grenades"),
        description = ccb.content.text("A canister grenade filled with noxious irritant.  Use this item to pull the pin and start the fuse, turning it into an active tear gas grenade.  In five seconds it will begin to expel a highly toxic gas for some time.  This gas damages and slows those who enter it, as well as obscuring vision and scent."),
        price_cents = 3600,
        price_postapoc_cents = 250,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "gasbomb_primed" },
        need_wielding = true,
        menu_text = ccb.content.text("Pull pin"),
        message = ccb.content.text("You pull the pin on the %s."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "gasbomb_primed",
        copy_from = "abstract_gas_bomb_primed",
        name = ccb.content.plural_text("tear gas grenade", "tear gas grenades"),
        description = ccb.content.text("This tear gas grenade has had its pin removed and will shortly be expelling highly noxious gas."),
    }
    item:transform_into { target = "gasbomb_act" }
    content.add(item)
end

do
    -- Based on AN-M8 grenade
    local item = content.Item {
        id = "smokebomb",
        copy_from = "abstract_gas_bomb_inactive",
        name = ccb.content.plural_text("smoke grenade", "smoke grenades"),
        description = ccb.content.text("A canister grenade filled with a variety of pyrotechnic chemicals.  Use this item to pull the pin and start the fuse, turning it into an active smoke bomb.  Five seconds after you do that, it will begin to expel a thick white smoke.  This smoke will obscure vision and scent, and choke out those who enter it."),
        mass_milligrams = 680000,
        price_cents = 1800,
        price_postapoc_cents = 100,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "smokebomb_primed" },
        need_wielding = true,
        menu_text = ccb.content.text("Pull pin"),
        message = ccb.content.text("You pull the pin on the %s."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "smokebomb_primed",
        copy_from = "abstract_gas_bomb_primed",
        name = ccb.content.plural_text("smoke grenade", "smoke grenades"),
        mass_milligrams = 680000,
        description = ccb.content.text("This smoke bomb has had its pin removed and will shortly be expelling thick smoke."),
    }
    item:transform_into { target = "smokebomb_act" }
    content.add(item)
end

do
    local item = content.Item {
        id = "insecticidalbomb",
        copy_from = "abstract_gas_bomb_inactive",
        name = ccb.content.plural_text("insecticidal gas grenade", "insecticidal gas grenades"),
        description = ccb.content.text("A canister grenade filled with insecticidal solution.  Use this item to pull the pin and start the fuse, turning it into an active insecticidal grenade.  In five seconds it will begin to expel a volatile gas that is highly toxic to insect life forms."),
        price_cents = 1800,
        price_postapoc_cents = 750,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "insecticidalbomb_primed" },
        need_wielding = true,
        menu_text = ccb.content.text("Pull pin"),
        message = ccb.content.text("You pull the pin on the %s."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "insecticidalbomb_primed",
        copy_from = "abstract_gas_bomb_primed",
        name = ccb.content.plural_text("insecticidal gas grenade", "insecticidal gas grenades"),
    }
    item:transform_into { target = "insecticidalbomb_act" }
    content.add(item)
end

do
    local item = content.Item {
        id = "insecticidalbomb_makeshift",
        copy_from = "abstract_gas_bomb_inactive",
        name = ccb.content.plural_text("makeshift insecticidal gas grenade", "makeshift insecticidal gas grenades"),
        description = ccb.content.text("A makeshift canister grenade filled with insecticidal solution.  Use this item to pull the pin and start the fuse, turning it into an active insecticidal grenade.  In five seconds it will begin to expel a volatile gas that is highly toxic to insect life forms."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "insecticidalbomb_makeshift_primed" },
        need_wielding = true,
        menu_text = ccb.content.text("Pull pin"),
        message = ccb.content.text("You pull the pin on the %s."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "insecticidalbomb_makeshift_primed",
        copy_from = "abstract_gas_bomb_primed",
        name = ccb.content.plural_text("makeshift insecticidal gas grenade", "makeshift insecticidal gas grenades"),
    }
    item:transform_into { target = "insecticidalbomb_makeshift_act" }
    content.add(item)
end

do
    local item = content.Item {
        id = "fungicidalbomb",
        copy_from = "abstract_gas_bomb_inactive",
        name = ccb.content.plural_text("fungicidal gas grenade", "fungicidal gas grenades"),
        description = ccb.content.text("A canister grenade filled with fungicidal solution.  Use this item to pull the pin and start the fuse, turning it into an active fungicidal grenade.  In five seconds it will begin to expel a volatile gas that is highly toxic to fungal life forms."),
        price_cents = 1800,
        price_postapoc_cents = 750,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "fungicidalbomb_primed" },
        need_wielding = true,
        menu_text = ccb.content.text("Pull pin"),
        message = ccb.content.text("You pull the pin on the %s."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "fungicidalbomb_primed",
        copy_from = "abstract_gas_bomb_primed",
        name = ccb.content.plural_text("fungicidal gas grenade", "fungicidal gas grenades"),
    }
    item:transform_into { target = "fungicidalbomb_act" }
    content.add(item)
end

do
    local item = content.Item {
        id = "fungicidalbomb_makeshift",
        copy_from = "abstract_gas_bomb_inactive",
        name = ccb.content.plural_text("makeshift fungicidal gas grenade", "makeshift fungicidal gas grenades"),
        description = ccb.content.text("A makeshift canister grenade filled with fungicidal solution.  Use this item to pull the pin and start the fuse, turning it into an active fungicidal grenade.  In five seconds it will begin to expel a volatile gas that is highly toxic to fungal life forms."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "fungicidalbomb_makeshift_primed" },
        need_wielding = true,
        menu_text = ccb.content.text("Pull pin"),
        message = ccb.content.text("You pull the pin on the %s."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "fungicidalbomb_makeshift_primed",
        copy_from = "abstract_gas_bomb_primed",
        name = ccb.content.plural_text("makeshift fungicidal gas grenade", "makeshift fungicidal gas grenades"),
    }
    item:transform_into { target = "fungicidalbomb_makeshift_act" }
    content.add(item)
end

do
    local item = content.Item {
        id = "gasbomb_makeshift",
        copy_from = "abstract_gas_bomb_inactive",
        name = ccb.content.plural_text("makeshift toxic gas grenade", "makeshift toxic gas grenades"),
        description = ccb.content.text("A makeshift canister grenade filled with household chemicals.  Use this item to pull the pin and start the fuse, turning it into an active toxic gas grenade.  In five seconds it will begin to expel a highly toxic gas for a short time.  This gas poisons those exposed to it, in addition to obscuring vision and scent."),
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "gasbomb_makeshift_primed" },
        need_wielding = true,
        menu_text = ccb.content.text("Pull pin"),
        message = ccb.content.text("You pull the pin on the %s."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "gasbomb_makeshift_primed",
        copy_from = "abstract_gas_bomb_primed",
        name = ccb.content.plural_text("makeshift toxic gas grenade", "makeshift toxic gas grenades"),
    }
    item:transform_into { target = "gasbomb_makeshift_act" }
    content.add(item)
end
