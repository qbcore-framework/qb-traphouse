Config = Config or {}

Config.MinZOffset = 40
Config.TakeoverPrice = 5000
Config.TrapHouses = {
    [1] = {
        coords = {
            ["enter"] = vector3(-1202.13, -1308.48, 4.91),
            ["interaction"] = vector3(-1207.42, -1311.83, -32.66),
        },
        keyholders = {},
        pincode = 1234,
        inventory = {},
        opened = false,
        takingover = false,
        money = 0,
    }
}

Config.AllowedItems = {
    ["metalscrap"] = {
        name = "metalscrap",
        wait = 500,
        reward = 3,
    },
    ["copper"] = {
        name = "copper",
        wait = 500,
        reward = 2,
    },
    ["iron"] = {
        name = "iron",
        wait = 500,
        reward = 2,
    },
    ["aluminum"] = {
        name = "aluminum",
        wait = 500,
        reward = 2,
    },
    ["steel"] = {
        name = "steel",
        wait = 500,
        reward = 2,
    },
    ["glass"] = {
        name = "glass",
        wait = 500,
        reward = 2,
    },
    ["lockpick"] = {
        name = "lockpick",
        wait = 10000,
        reward = 150,
    },
    ["screwdriverset"] = {
        name = "screwdriverset",
        wait = 10000,
        reward = 300,
    },
    ["electronickit"] = {
        name = "electronickit",
        wait = 10000,
        reward = 300,
    },
    ["radioscanner"] = {
        name = "radioscanner",
        wait = 10000,
        reward = 850,
    },
    ["gatecrack"] = {
        name = "gatecrack",
        wait = 10000,
        reward = 600,
    },
    ["trojan_usb"] = {
        name = "trojan_usb",
        wait = 10000,
        reward = 1000,
    },
    ["weed_brick"] = {
        name = "weed_brick",
        wait = 5000,
        reward = 250,
    },
    ["phone"] = {
        name = "phone",
        wait = 2000,
        reward = 750,
    },
    ["radio"] = {
        name = "radio",
        wait = 2000,
        reward = 180,
    },
    ["handcuffs"] = {
        name = "handcuffs",
        wait = 2000,
        reward = 400,
    },
    ["10kgoldchain"] = {
        name = "10kgoldchain",
        wait = 10000,
        reward = 3000,
    },
}
