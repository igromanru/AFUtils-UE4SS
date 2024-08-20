
--[[
    Author: Igromanru
    Date: 19.08.2024
    Description: Utility functions for the game Abiotic Factor
]]

local BaseUtils = require("AFUtils.BaseUtils.BaseUtils")

-- AFUtils class
local AFUtils = {}

-- Module scope variables --
------------------------
local PlayerController = nil

-- Exported functions --
------------------------

---Logs in debug scope all relevant properties of a FAbiotic_InventoryChangeableDataStruct to console 
---@param ChangeableData FAbiotic_InventoryChangeableDataStruct
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogInventoryChangeableDataStruct(ChangeableData, Prefix)
    if not ChangeableData then
        return
    end
    if not Prefix then
        Prefix = ""
    end

    if ChangeableData.AssetID_25_06DB7A12469849D19D5FC3BA6BEDEEAB then
        LogDebug(Prefix .. "AssetID: " .. ChangeableData.AssetID_25_06DB7A12469849D19D5FC3BA6BEDEEAB:ToString())
    end
    LogDebug(Prefix .. "CurrentItemDurability: " .. ChangeableData.CurrentItemDurability_4_24B4D0E64E496B43FB8D3CA2B9D161C8)
    LogDebug(Prefix .. "MaxItemDurability: " .. ChangeableData.MaxItemDurability_6_F5D5F0D64D4D6050CCCDE4869785012B)
    LogDebug(Prefix .. "CurrentStack: " .. ChangeableData.CurrentStack_9_D443B69044D640B0989FD8A629801A49)
    LogDebug(Prefix .. "CurrentAmmoInMagazine: " .. ChangeableData.CurrentAmmoInMagazine_12_D68C190F4B2FA78A4B1D57835B95C53D)
    LogDebug(Prefix .. "LiquidLevel: " .. ChangeableData.LiquidLevel_46_D6414A6E49082BC020AADC89CC29E35A)
    LogDebug(Prefix .. "CurrentLiquid (enum): " .. ChangeableData.CurrentLiquid_19_3E1652F448223AAE5F405FB510838109)
end

---Returns current AAbiotic_PlayerController_C or nil
---@return AAbiotic_PlayerController_C?
function AFUtils.GetMyPlayerController()
    if PlayerController and PlayerController:IsValid() then return PlayerController end

    local PlayerControllers = FindAllOf("Abiotic_PlayerController_C")
    if not PlayerControllers then return nil end
    for _, Controller in pairs(PlayerControllers or {}) do
        if Controller.MyPlayerCharacter:IsValid() and Controller.MyPlayerCharacter:IsPlayerControlled() then
            PlayerController = Controller
            break
        end
    end
    if not PlayerController or not PlayerController:IsValid() then
        PlayerController = nil
    end
    return PlayerController
end

---Returns current controlled player or nil
---@return AAbiotic_PlayerCharacter_C?
function AFUtils.GetMyPlayer()
    local playerController = AFUtils.GetMyPlayerController()
    local player = nil
    if playerController then
        player = playerController.MyPlayerCharacter
    end

    if not player or not player:IsValid() then
        player = nil
    end
    return player
end

---Returns current player's inventory or nil
---@return UAbiotic_InventoryComponent_C?
function AFUtils.GetMyInventoryComponent()
    local myPlayer = AFUtils.GetMyPlayer()
    local inventoryComponent = nil
    if myPlayer then
        inventoryComponent = myPlayer.CharacterInventory
    end

    if not inventoryComponent or not inventoryComponent:IsValid() then
        LogDebug("Couldn't get my inventory component")
        inventoryComponent = nil
    end
    return inventoryComponent
end

---Prints a colored message to local player's chat (only visible to the player)
---@param Message string Message that should be shown in chat
---@param Prefix string?
---@param Color FLinearColor? If nil, defaults to white
function AFUtils.DisplayTextChatMessage(Message, Prefix, Color)
    if not Message then return end

    local myPlayerController = AFUtils.GetMyPlayerController()
    if myPlayerController then
        Prefix = Prefix or ""
        if not Color or type(Color) ~= 'table' then
            Color = { -- White
                R = 1.0,
                G = 1.0,
                B = 1.0,
                A = 1.0
            }
        end
        myPlayerController:Local_DisplayTextChatMessage(Prefix, Color, Message, Color)
    end
end

---@param Inventory UAbiotic_InventoryComponent_C
---@param SlotIndex integer
---@return FAbiotic_InventoryItemSlotStruct?
function AFUtils.GetInventoryItemSlot(Inventory, SlotIndex)
    if not Inventory or not Inventory:IsValid() or not SlotIndex then return nil end

    -- Lua array starts with 1, while TArray with 0
    local index = SlotIndex + 1
    if Inventory.CurrentInventory and #Inventory.CurrentInventory >= index then
        return Inventory.CurrentInventory[index]
    end

    return nil
end

return AFUtils