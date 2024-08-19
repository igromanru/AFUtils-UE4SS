
-- AFUtils class
local AFUtils = {}

-- Module scope variables --
------------------------
local PlayerController = nil

-- Exported functions --
------------------------

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