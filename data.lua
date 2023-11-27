Config = {
    teleports = {
        [1] = {
            loc = vector3(-956.6956, -776.5829, 17.8361),
            icon = "fa-plane",
            label = "Skate Park"
        },
        [2] = {
            loc = vector3(-921.3931, -729.4895, 19.9208),
            icon = "basketball",
            label = "Basketball Ramps"
        },
    },
    menuloc = {
        ["Skate Park"] = {
            loc = vector3(-945.3028, -790.6210, 15.9510)
        },
        ["Basketball Ramps"] = {
            loc = vector3(-921.3931, -729.4895, 19.9208)
        },
    },
    menu = {
        title = "K Menu",
        position = "top-right",
        enablecommand = true,
        command = "kmenu"
    },
    weapons = {
        {label = "AP Pistol", model = "WEAPON_APPISTOL", icon = "gun", price = 25000},
        {label = "Combat Pistol", model = "WEAPON_COMBATPISTOL", icon = "gun", price = 25000},
    },
    notify = function(des, type)
        lib.notify({
            title = "KMenu Notifications",
            description = des,
            type = type or "info"
        })
    end
}
