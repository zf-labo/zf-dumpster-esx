Config = {}
Config.Locale = 'en'

Config.Props = {
    `prop_dumpster_4b`,
    `prop_dumpster_4a`,
    `prop_dumpster_3a`,
    `prop_dumpster_02b`,
    `prop_dumpster_02a`,
    `prop_dumpster_01a`,
    `prop_snow_dumpster_01`
}

-- ## Compatiblity Configs
Config.Target = 'ox_target' -- Available options: 'ox_target', 'qtarget'
Config.ProgressType = 'circle' -- Available options: 'circle', 'regular'

-- ## Reset Configs
Config.ResetOnReboot = false
Config.ResetTime = 1 -- If Config.ResetOnReboot = false. In minutes

-- ## Minigame Configs
Config.Minigame = 'ox_lib' -- Available options: false, 'ox_lib', 'memorygame'

-- ## Time Configs
Config.ProgressTime = 3 -- In secondes

-- ## Police Configs
Config.Illegal = true -- True will send an alert using the % on Config.AlertChance
Config.AlertChance = 10
Config.Dispatch = 'linden_outlaw' -- Available options: 'linden_outlaw', 'cd_dispatch'
Config.PoliceJobs = {'police'}

-- ## Hurting Configs
Config.Hurting = true -- True will give a chance to the player to be hurt
Config.HurtChance = 40 -- If Config.Hurting = true. In percentage
Config.CanBleed = true -- Can the player bleed? / Requires qb-ambulancejob
Config.BleedChance = 30 -- If Config.CanBleed = true. In percentage
Config.HurtDamage = {
    min = 5,
    max = 15,
}

-- ## Loot table
Config.CanLootMultiple = true -- Can the player loot multiple items?
Config.MaxLootItem = 3 -- If Config.CanLootMultiple = true. Max items the player can loot
Config.Loottable = {
    [1] = {item = 'fish',               chances = 3,    min = 1,    max = 3},
    [2] = {item = 'copper',             chances = 40,   min = 1,    max = 3},
    [3] = {item = 'cannabis',           chances = 78,   min = 1,    max = 3},
    [4] = {item = 'packaged_chicken',   chances = 27,   min = 1,    max = 3},
    [5] = {item = 'petrol',             chances = 1,    min = 1,    max = 3},
    [6] = {item = 'slaughtered_chicken',chances = 12,   min = 1,    max = 3},
    [7] = {item = 'water',              chances = 7,    min = 1,    max = 3},
    [8] = {item = 'iron',               chances = 4,    min = 1,    max = 3},
    [9] = {item = 'cutted_wood',        chances = 64,   min = 1,    max = 3},
    [10] = {item = 'wood',              chances = 95,   min = 1,    max = 3},
}
