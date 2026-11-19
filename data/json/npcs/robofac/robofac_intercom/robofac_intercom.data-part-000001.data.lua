local ccb = require("ccb")

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_INTERCOM",
    copy_from = "NC_ROBOFAC_INTERCOM_BASE",
    name = ccb.content.text("intercom"),
    job_description = ccb.content.text("."),
    shop_groups = {
        { id = "NC_ROBOFAC_INTERCOM_trade", rigid = true },
        {
            id = "NC_ROBOFAC_INTERCOM_trade_armor",
            rigid = true,
            refusal = ccb.content.text("You're not yet qualified to buy this"),
            condition_handler = "hub_armor_stock_unlocked",
        },
        {
            id = "NC_ROBOFAC_INTERCOM_trade_military",
            rigid = true,
            strict = true,
            condition_handler = "hub_military_stock_unlocked",
        },
        {
            id = "robofac_robots",
            rigid = true,
            strict = true,
            condition_handler = "hub_portal_robots_unlocked",
        },
        {
            id = "robofac_gun_mags",
            rigid = true,
            refusal = ccb.content.text("You need to earn an HWP first"),
            condition_handler = "hub_gun_stock_unlocked",
        },
        { id = "robofac_gun_kit", rigid = true, strict = true, condition_handler = "hub_gun_stock_unlocked" },
        {
            id = "robofac_gun_exodii",
            rigid = true,
            strict = true,
            condition_handler = "hub_exodii_gun_stock_unlocked",
        },
        {
            id = "NC_ROBOFAC_INTERCOM_trade_hm12",
            rigid = true,
            strict = true,
            condition_handler = "hub_hm12_stock_unlocked",
        },
        {
            id = "NC_ROBOFAC_INTERCOM_trade_envirosuit",
            rigid = true,
            refusal = ccb.content.text("You're not yet qualified to buy this"),
            condition_handler = "hub_envirosuit_stock_unlocked",
        },
        {
            id = "NC_ROBOFAC_INTERCOM_XM_EXOSKELETONS",
            rigid = true,
            strict = true,
            condition_handler = "hub_autodoc_exoskeletons_unlocked",
        },
        {
            id = "NC_ROBOFAC_INTERCOM_LENS",
            rigid = true,
            strict = true,
            condition_handler = "hub_autodoc_lenses_unlocked",
        },
        {
            id = "NC_ROBOFAC_INTERCOM_MVAS",
            rigid = true,
            strict = true,
            condition_handler = "hub_mvas_stock_unlocked",
        },
    },
    blacklist = "robofac_blacklist",
}
