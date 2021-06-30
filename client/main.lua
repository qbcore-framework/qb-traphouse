QBCore = nil
isLoggedIn = false
PlayerData = {}

Citizen.CreateThread(function()
    while QBCore == nil do
    	TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
    	Citizen.Wait(200)
    end
end)

local ClosestTraphouse = nil
local InsideTraphouse = false
local CurrentTraphouse = nil
local TraphouseObj = {}
local POIOffsets = nil
local IsKeyHolder = false
local IsHouseOwner = false
local InTraphouseRange = false
local CodeNPC = nil
local IsRobbingNPC = false


-- Code

Citizen.CreateThread(function()
    while true do
        if isLoggedIn then
            SetClosestTraphouse()
        end
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
    Wait(1000)
    if QBCore.Functions.GetPlayerData() ~= nil then
        isLoggedIn = true
        PlayerData = QBCore.Functions.GetPlayerData()
        QBCore.Functions.TriggerCallback('qb-traphouse:server:GetTraphousesData', function(trappies)
            Config.TrapHouses = trappies
        end)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.TriggerCallback('qb-traphouse:server:GetTraphousesData', function(trappies)
        Config.TrapHouses = trappies
    end)
end)

function SetClosestTraphouse()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for id, traphouse in pairs(Config.TrapHouses) do
        if current ~= nil then
            if #(pos - vector3(Config.TrapHouses[id].coords.enter.x, Config.TrapHouses[id].coords.enter.y, Config.TrapHouses[id].coords.enter.z)) < dist then
                current = id
                dist = #(pos - vector3(Config.TrapHouses[id].coords.enter.x, Config.TrapHouses[id].coords.enter.y, Config.TrapHouses[id].coords.enter.z))
            end
        else
            dist = #(pos - vector3(Config.TrapHouses[id].coords.enter.x, Config.TrapHouses[id].coords.enter.y, Config.TrapHouses[id].coords.enter.z))
            current = id
        end
    end
    ClosestTraphouse = current
    IsKeyHolder = HasKey(PlayerData.citizenid)
    IsHouseOwner = IsOwner(PlayerData.citizenid)
end

function HasKey(CitizenId)
    local haskey = false
    if ClosestTraphouse ~= nil then
        if Config.TrapHouses[ClosestTraphouse].keyholders ~= nil and next(Config.TrapHouses[ClosestTraphouse].keyholders) ~= nil then
            for _, data in pairs(Config.TrapHouses[ClosestTraphouse].keyholders) do
                if data.citizenid == CitizenId then
                    haskey = true
                end
            end
        end
    end
    return haskey
end

function IsOwner(CitizenId)
    local retval = false
    if ClosestTraphouse ~= nil then
        if Config.TrapHouses[ClosestTraphouse].keyholders ~= nil and next(Config.TrapHouses[ClosestTraphouse].keyholders) ~= nil then
            for _, data in pairs(Config.TrapHouses[ClosestTraphouse].keyholders) do
                if data.citizenid == CitizenId then
                    if data.owner then
                        retval = true
                    else
                        retval = false
                    end
                end
            end
        end
    end
    return retval
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('qb-traphouse:client:EnterTraphouse')
AddEventHandler('qb-traphouse:client:EnterTraphouse', function(code)
    if ClosestTraphouse ~= nil then
        if InTraphouseRange then
            local data = Config.TrapHouses[ClosestTraphouse]
            if not IsKeyHolder then
                SendNUIMessage({
                    action = "open"
                })
                SetNuiFocus(true, true)
            else
                EnterTraphouse(data)
            end
        end
    end
end)

RegisterNUICallback('PinpadClose', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('ErrorMessage', function(data)
    QBCore.Functions.Notify(data.message, 'error')
end)

RegisterNUICallback('EnterPincode', function(d)
    local data = Config.TrapHouses[ClosestTraphouse]
    if tonumber(d.pin) == data.pincode then
        EnterTraphouse(data)
    else
        QBCore.Functions.Notify('This Code Is Incorrect', 'error')
    end
end)

local CanRob = true

function RobTimeout(timeout)
    SetTimeout(timeout, function()
        CanRob = true
    end)
end

local RobbingTime = 3

Citizen.CreateThread(function()
    while true do
        local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
        if targetPed ~= 0 and not IsPedAPlayer(targetPed) then
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            if ClosestTraphouse ~= nil then
                local data = Config.TrapHouses[ClosestTraphouse]
                local dist = #(pos - vector3(data.coords["enter"].x, data.coords["enter"].y, data.coords["enter"].z))
                if dist < 200 then
                    if aiming then
                        local pcoords = GetEntityCoords(targetPed)
                        local peddist = #(pos - pcoords)
                        if peddist < 4 then
                            InDistance = true
                            if not IsRobbingNPC and CanRob then
                                if IsPedInAnyVehicle(targetPed) then
                                    TaskLeaveVehicle(targetPed, GetVehiclePedIsIn(targetPed), 1)
                                end
                                Citizen.Wait(500)
                                InDistance = true

                                local dict = 'random@mugging3'
                                RequestAnimDict(dict)
                                while not HasAnimDictLoaded(dict) do
                                    Citizen.Wait(10)
                                end
                        
                                SetEveryoneIgnorePlayer(PlayerId(), true)
                                TaskStandStill(targetPed, RobbingTime * 1000)
                                FreezeEntityPosition(targetPed, true)
                                SetBlockingOfNonTemporaryEvents(targetPed, true)
                                TaskPlayAnim(targetPed, dict, 'handsup_standing_base', 2.0, -2, 15.0, 1, 0, 0, 0, 0)
                                for i = 1, RobbingTime / 2, 1 do
                                    PlayAmbientSpeech1(targetPed, "GUN_BEG", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
                                    Citizen.Wait(2000)
                                end
                                FreezeEntityPosition(targetPed, true)
                                IsRobbingNPC = true
                                SetTimeout(RobbingTime, function()
                                    IsRobbingNPC = false
                                    RobTimeout(math.random(30000, 60000))
                                    if not IsEntityDead(targetPed) then
                                        if CanRob then
                                            if InDistance then
                                                SetEveryoneIgnorePlayer(PlayerId(), false)
                                                SetBlockingOfNonTemporaryEvents(targetPed, false)
                                                FreezeEntityPosition(targetPed, false)
                                                ClearPedTasks(targetPed)
                                                AddShockingEventAtPosition(99, GetEntityCoords(targetPed), 0.5)
                                                TriggerServerEvent('qb-traphouse:server:RobNpc', ClosestTraphouse)
                                                CanRob = false
                                            end
                                        end
                                    end
                                end)
                            end
                        else
                            if InDistance then
                                InDistance = false
                            end
                        end
                    end
                end
            else
                Citizen.Wait(1000)
            end
        end
        Citizen.Wait(3)
    end
end)

Citizen.CreateThread(function()
    while true do

        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false

        if ClosestTraphouse ~= nil then
            local data = Config.TrapHouses[ClosestTraphouse]
            if InsideTraphouse then
                local ExitDistance = #(pos - vector3(data.coords["enter"].x + POIOffsets.exit.x, data.coords["enter"].y + POIOffsets.exit.y, data.coords["enter"].z - Config.MinZOffset + POIOffsets.exit.z))
                if ExitDistance < 20 then
                    inRange = true
                    if ExitDistance < 1 then
                        DrawText3Ds(data.coords["enter"].x + POIOffsets.exit.x, data.coords["enter"].y + POIOffsets.exit.y, data.coords["enter"].z - Config.MinZOffset + POIOffsets.exit.z, '~b~E~w~ - Leave')
                        if IsControlJustPressed(0, 38) then
                            LeaveTraphouse(data)
                        end
                    end
                end

                local InteractDistance = #(pos - vector3(data.coords["interaction"].x, data.coords["interaction"].y, data.coords["interaction"].z))
                if InteractDistance < 20 then
                    inRange = true
                    if InteractDistance < 1 then
                        if not IsKeyHolder then
                            DrawText3Ds(data.coords["interaction"].x, data.coords["interaction"].y, data.coords["interaction"].z + 0.2, '~b~H~w~ - View Inventory')
                            DrawText3Ds(data.coords["interaction"].x, data.coords["interaction"].y, data.coords["interaction"].z, '~b~E~w~ - Take Over (~g~$5000~w~)')
                            if IsControlJustPressed(0, 38) then
                                TriggerServerEvent('qb-traphouse:server:TakeoverHouse', CurrentTraphouse)
                            end
                            if IsControlJustPressed(0, 74) then
                                local TraphouseInventory = {}
                                TraphouseInventory.label = "traphouse_"..CurrentTraphouse
                                TraphouseInventory.items = data.inventory
                                TraphouseInventory.slots = 2
                                TriggerServerEvent("inventory:server:OpenInventory", "traphouse", CurrentTraphouse, TraphouseInventory)
                            end
                        else
                            DrawText3Ds(data.coords["interaction"].x, data.coords["interaction"].y, data.coords["interaction"].z + 0.2, '~b~H~w~ - View Inventory')
                            DrawText3Ds(data.coords["interaction"].x, data.coords["interaction"].y, data.coords["interaction"].z, '~b~E~w~ - Take Cash (~g~$'..data.money..'~w~)')
                            if IsHouseOwner then
                                DrawText3Ds(data.coords["interaction"].x, data.coords["interaction"].y, data.coords["interaction"].z - 0.2, '~b~/multikeys~w~ [id] - To Give Keys')
                                DrawText3Ds(data.coords["interaction"].x, data.coords["interaction"].y, data.coords["interaction"].z - 0.4, '~b~G~w~ - See Pin Code')
                                if IsControlJustPressed(0, 47) then
                                    QBCore.Functions.Notify('Pincode: '..data.pincode)
                                end
                            end
                            if IsControlJustPressed(0, 74) then
                                local TraphouseInventory = {}
                                TraphouseInventory.label = "traphouse_"..CurrentTraphouse
                                TraphouseInventory.items = data.inventory
                                TraphouseInventory.slots = 2
                                TriggerServerEvent("inventory:server:OpenInventory", "traphouse", CurrentTraphouse, TraphouseInventory)
                            end
                            if IsControlJustPressed(0, 38) then
                                TriggerServerEvent("qb-traphouse:server:TakeMoney", CurrentTraphouse)
                            end
                        end
                    end
                end
            else
                local EnterDistance = #(pos - vector3(data.coords["enter"].x, data.coords["enter"].y, data.coords["enter"].z))
                if EnterDistance < 20 then
                    inRange = true
                    if EnterDistance < 1 then
                        InTraphouseRange = true
                    else
                        if InTraphouseRange then
                            InTraphouseRange = false
                        end
                    end
                end
            end
        else
            Citizen.Wait(2000)
        end

        Citizen.Wait(3)
    end
end)

function EnterTraphouse(data)
    local coords = { x = data.coords["enter"].x, y = data.coords["enter"].y, z= data.coords["enter"].z - Config.MinZOffset}
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    data = exports['qb-interior']:CreateTrevorsShell(coords) 
    TraphouseObj = data[1]
    POIOffsets = data[2]
    CurrentTraphouse = ClosestTraphouse
    InsideTraphouse = true
    SetRainLevel(0.0)
    TriggerEvent('qb-weathersync:client:DisableSync')
    print('Entered')
    FreezeEntityPosition(TraphouseObj, true)
    SetWeatherTypePersist('EXTRASUNNY')
    SetWeatherTypeNow('EXTRASUNNY')
    SetWeatherTypeNowPersist('EXTRASUNNY')
    NetworkOverrideClockTime(23, 0, 0)
end

function LeaveTraphouse(data)
    local ped = PlayerPedId()
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    DoScreenFadeOut(250)
    Citizen.Wait(250)
    exports['qb-interior']:DespawnInterior(TraphouseObj, function()
        TriggerEvent('qb-weathersync:client:EnableSync')
        DoScreenFadeIn(250)
        SetEntityCoords(ped, data.coords["enter"].x, data.coords["enter"].y, data.coords["enter"].z + 0.5)
        SetEntityHeading(ped, data.coords["enter"].w)
        TraphouseObj = nil
        POIOffsets = nil
        CurrentTraphouse = nil
        InsideTraphouse = false
    end)
end

RegisterNetEvent('qb-traphouse:client:TakeoverHouse')
AddEventHandler('qb-traphouse:client:TakeoverHouse', function(TraphouseId)
    local ped = PlayerPedId()

    QBCore.Functions.Progressbar("takeover_traphouse", "Taking Over", math.random(1000, 3000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent('qb-traphouse:server:AddHouseKeyHolder', PlayerData.citizenid, TraphouseId, true)
    end, function()
        QBCore.Functions.Notify("Acquisitions Canceled", "error")
    end)
end)

function HasCitizenIdHasKey(CitizenId, Traphouse)
    local retval = false
    for _, data in pairs(Config.TrapHouses[Traphouse].keyholders) do
        if data.citizenid == CitizenId then
            retval = true
            break
        end
    end
    return retval
end

function AddKeyHolder(CitizenId, Traphouse)
    if #Config.TrapHouses[Traphouse].keyholders <= 6 then
        if not HasCitizenIdHasKey(CitizenId, Traphouse) then
            if #Config.TrapHouses[Traphouse].keyholders == 0 then
                table.insert(Config.TrapHouses[Traphouse].keyholders, {
                    citizenid = CitizenId,
                    owner = true,
                })
            else
                table.insert(Config.TrapHouses[Traphouse].keyholders, {
                    citizenid = CitizenId,
                    owner = false,
                })
            end
            QBCore.Functions.Notify(CitizenId..' Has Been Added To The Traphouse!')
        else
            QBCore.Functions.Notify(CitizenId..' This Person Already Has Keys')
        end
    else
        QBCore.Functions.Notify('You Can Give Up To 6 People Access To The Trap House!')
    end
    IsKeyHolder = HasKey(CitizenId)
    IsHouseOwner = IsOwner(CitizenId)
end

RegisterNetEvent('qb-traphouse:client:SyncData')
AddEventHandler('qb-traphouse:client:SyncData', function(k, data)
    Config.TrapHouses[k] = data
    IsKeyHolder = HasKey(PlayerData.citizenid)
    IsHouseOwner = IsOwner(PlayerData.citizenid)
end)
