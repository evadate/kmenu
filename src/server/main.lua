lib.callback.register("kmenu:gunPay", function(source, model, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.hasWeapon(model) then
        return "Weapon In Invetory"
    else
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            xPlayer.addWeapon(model, 250)
            return true
        else
            return false
        end
    end
end)