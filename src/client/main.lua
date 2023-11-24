local isPlayerInZone = false

local function mainmenu()
    lib.registerMenu({
        id = "main_menu",
        title = Config.menu.title,
        position = Config.menu.position,
        options = {
            {label = "Teleport Options", icon = "plane"},
            {label = "Self Options", icon = "fa-heart-pulse"},
            {label = "Weapon Options", icon = "fa-gun"},
            {label = "Misc Options", icon = "fa-cog"},
        },
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            teleportmenu()
        elseif selected == 2 then
            selfoptions()
        elseif selected == 3 then
            weaponoptions()
        elseif selected == 4 then
            miscoptions()
        end
    end)
    lib.showMenu("main_menu")
end

function teleportmenu()
    local teleports = {}
    for _, teleportdata in pairs(Config.teleports) do
        teleports[#teleports + 1] = {
            label = teleportdata.label,
            icon = teleportdata.icon,
            args = {
                loc = teleportdata.loc
            }
        }
    end
    lib.registerMenu({
        id = "teleport_menu",
        title = Config.menu.title,
        position = Config.menu.position,
        onClose = function(keyPresses)
            if keyPresses then
                mainmenu()
            end
        end,
        options = teleports
    }, function(selected, scrollIndex, args)
        DoScreenFadeOut(900)
        Wait(900)
        DoScreenFadeIn(900)
        SetEntityCoords(PlayerPedId(), args.loc)
    end)
    lib.showMenu("teleport_menu")
end

function selfoptions()
    lib.registerMenu({
        id = "self_options",
        title = Config.menu.title,
        position = Config.menu.position,
        onClose = function(keyPresses)
            if keyPresses then
                mainmenu()
            end
        end,
        options = {
            {label = "Heal", icon = "fa-heart"},
            {label = "Armour", icon = "fa-shield"},
        },
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            if GetEntityHealth(PlayerPedId()) == 200 then
                Config.notify("You are already at max health", "error")
            else
                SetEntityHealth(PlayerPedId(), 200)
                Config.notify("Sucessfully added health", "success")
            end
        elseif selected == 2 then
            if GetPedArmour(PlayerPedId()) == 100 then
                Config.notify("You are already at max armour", "error")
            else
                SetPedArmour(PlayerPedId(), 100)
                Config.notify("Sucessfully added armour", "success")
            end
        end
    end)
    lib.showMenu("self_options")
end

function weaponoptions()
    local weapons = {}
    for _, weapondata in pairs(Config.weapons) do
        weapons[#weapons + 1] = {
            label = weapondata.label,
            icon = weapondata.icon,
            description = "Weapon Damage: "..GetWeaponDamage(weapondata.model).."%",
            progress = GetWeaponDamage(weapondata.model),
            args = {
                model = weapondata.model,
                price = weapondata.price
            }
        }
    end
    lib.registerMenu({
        id = "weapon_options",
        title = Config.menu.title,
        position = Config.menu.position,
        onClose = function(keyPresses)
            if keyPresses then
                mainmenu()
            end
        end,
        options = weapons
    }, function(selected, scrollIndex, args)
        local weaponcallback = lib.callback.await("kmenu:gunPay", false, args.model, args.price)
        if weaponcallback == "Weapon In Invetory" then
            Config.notify("This weapon is already in your inventory", "error")
        else
            if weaponcallback then
                Config.notify("Sucessfully purchased weapon", "success")
            else
                Config.notify("You do not have enough money", "error")
            end
        end
    end)
    lib.showMenu("weapon_options")
end

function miscoptions()
    lib.registerMenu({
        id = "misc_options",
        title = Config.menu.title,
        position = Config.menu.position,
        onClose = function(keyPresses)
            if keyPresses then
                mainmenu()
            end
        end,
        options = {
            {label = "Change Hud Color", icon = "fa-palette"},
        },
    }, function(selected, scrollIndex, args)
        if selected == 1 then
            local input = lib.inputDialog("Hud Color", {
                {type = "select", label="Select A Color", options = {
                    {
                        label = "Green",
                        value = "green_color"
                    },
                    {
                        label = "Blue",
                        value = "blue_color"
                    },
                    {
                        label = "Red",
                        value = "red_color"
                    },
                }}
              })
            if not input[1] then return end
            if input[1] == "green_color" then
                ReplaceHudColourWithRgba(116, 114, 204, 114, 255)
                Config.notify("Changed Hud Color", "success")
            elseif input[1] ==  "blue_color" then
                ReplaceHudColourWithRgba(116, 93, 182, 229, 255)
                Config.notify("Changed Hud Color", "success")
            elseif input[1] == "red_color" then
                ReplaceHudColourWithRgba(116, 224, 50, 50, 255)
                Config.notify("Changed Hud Color", "success")
            end
        end
    end)
    lib.showMenu("misc_options")
end

for _, locdata in pairs(Config.menuloc) do
    local point = lib.points.new({
        coords = locdata.loc,
        distance = 35,
    })
     
    function point:onEnter()
        isPlayerInZone = true
    end
     
    function point:onExit()
        isPlayerInZone = false
    end
     
    function point:nearby()
        if IsControlJustReleased(0, 311) then
            mainmenu()
        end
    end
end

if Config.menu.enablecommand then 
    RegisterCommand(Config.menu.command, function()
        if isPlayerInZone then 
            mainmenu()
        else
            Config.notify("You are not in a kmenu position", "error")
        end
    end)
end