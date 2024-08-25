
--[[
    Author: Igromanru
    Date: 19.08.2024
    Description: Utility functions for the game Abiotic Factor
]]

local BaseUtils = require("AFUtils.BaseUtils.BaseUtils")

-- AFUtils class
local AFUtils = {}

-- Exported variables --
------------------------
AFUtils.LiquidType = {
    None = 0,
    Water = 1,
    Unknown2 = 2,
    RadioactiveWaste = 3,
    Unknown4 = 4,
    Unknown5 = 5,
    Unknown6 = 6,
    Power = 7,
    Unknown8 = 8,
    Unknown9 = 9,
    TaintedWater = 10,
    Unknown11 = 11,
    Unknown12 = 12,
    Unknown13 = 13,
    MAX = 14
}

AFUtils.CriticalityLevels = {
    Green = 0,
    Gray = 1,
    Yellow = 2,
    Red = 3,
    Purple = 4,
    MAX = 5
}

-- Static Classes --
--------------------
local Abiotic_PlayerCharacter_C_Class = nil
function AFUtils.GetClassAbiotic_PlayerCharacter_C()
    if not Abiotic_PlayerCharacter_C_Class then
        Abiotic_PlayerCharacter_C_Class = StaticFindObject("/Game/Blueprints/Characters/Abiotic_PlayerCharacter.Abiotic_PlayerCharacter_C")
    end
    return Abiotic_PlayerCharacter_C_Class
end

local Abiotic_Item_ParentBP_C_Class = nil
function AFUtils.GetClassAbiotic_Item_ParentBP_C()
    if not Abiotic_Item_ParentBP_C_Class then
        Abiotic_Item_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/Items/Abiotic_Item_ParentBP.Abiotic_Item_ParentBP_C")
    end
    return Abiotic_Item_ParentBP_C_Class
end

local AbioticDeployed_ParentBP_C_Class = nil
function AFUtils.GetClassAbioticDeployed_ParentBP_C()
    if not AbioticDeployed_ParentBP_C_Class then
        AbioticDeployed_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/DeployedObjects/AbioticDeployed_ParentBP.AbioticDeployed_ParentBP_C")
    end
    return AbioticDeployed_ParentBP_C_Class
end

local RechargeableComponent_C_Class = nil
function AFUtils.GetClassRechargeableComponent_C()
    if not RechargeableComponent_C_Class then
        RechargeableComponent_C_Class = StaticFindObject("/Game/Blueprints/Items/RechargeableComponent.RechargeableComponent_C")
    end
    return RechargeableComponent_C_Class
end

local Deployed_Battery_ParentBP_C_Class = nil
function AFUtils.GetClassDeployed_Battery_ParentBP_C()
    if not Deployed_Battery_ParentBP_C_Class then
        Deployed_Battery_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/DeployedObjects/Misc/Deployed_Battery_ParentBP.Deployed_Battery_ParentBP_C")
    end
    return Deployed_Battery_ParentBP_C_Class
end

-- Exported functions --
------------------------

local PlayerControllerCache = nil
---Returns current AAbiotic_PlayerController_C or nil
---@return AAbiotic_PlayerController_C?
function AFUtils.GetMyPlayerController()
    if PlayerControllerCache and PlayerControllerCache:IsValid() then
        return PlayerControllerCache
    end
    PlayerControllerCache = nil

    local playerControllers = FindAllOf("Abiotic_PlayerController_C")
    if playerControllers and type(playerControllers) == 'table' then 
        for _, controller in pairs(playerControllers) do
            if controller.MyPlayerCharacter and controller.MyPlayerCharacter:IsValid() and controller.MyPlayerCharacter:IsPlayerControlled() then
                PlayerControllerCache = controller
                break
            end
        end
    end
    
    return PlayerControllerCache
end

local PlayerCache = nil
---Returns current controlled player or nil
---@return AAbiotic_PlayerCharacter_C?
function AFUtils.GetMyPlayer()
    if PlayerCache and PlayerCache:IsValid() then
        return PlayerCache
    end

    PlayerCache = nil
    local playerController = AFUtils.GetMyPlayerController()
    if playerController and playerController.MyPlayerCharacter:IsValid() then
        PlayerCache = playerController.MyPlayerCharacter
    end

    return PlayerCache
end

---Returns current player's inventory or nil
---@return UAbiotic_InventoryComponent_C?
function AFUtils.GetMyInventoryComponent()
    local myPlayer = AFUtils.GetMyPlayer()
    if myPlayer and myPlayer.CharacterInventory:IsValid() then
        return myPlayer.CharacterInventory
    end

    return nil
end

---Returns PlayerHUD
---@return UW_PlayerHUD_Main_C?
function AFUtils.GetMyPlayerHUD()
    local playerController = AFUtils.GetMyPlayerController()
    if playerController and playerController.PlayerHUDRef:IsValid() then
        return playerController.PlayerHUDRef
    end

    return nil
end

local SurvivalGameModeCache = nil
---Returns current AAbiotic_Survival_GameMode_C or nil
---@return AAbiotic_Survival_GameMode_C?
function AFUtils.GetSurvivalGameMode()
    if SurvivalGameModeCache and SurvivalGameModeCache:IsValid() then
        return SurvivalGameModeCache
    end

    SurvivalGameModeCache = FindFirstOf("Abiotic_Survival_GameMode_C")
    if not SurvivalGameModeCache:IsValid() then 
        SurvivalGameModeCache = nil
    end

    return SurvivalGameModeCache
end

local AIDirectorCache = nil
---Returns current AAbiotic_AIDirector_C or nil
---@return AAbiotic_AIDirector_C?
function AFUtils.GetAIDirector()
    if AIDirectorCache and AIDirectorCache:IsValid() then
        return AIDirectorCache
    end

    AIDirectorCache = nil
    local gameMode = AFUtils.GetSurvivalGameMode()
    if gameMode and gameMode.AI_Director:IsValid() then
        AIDirectorCache = gameMode.AI_Director
    end
    
    return AIDirectorCache
end

local AIControllerLeyakCache = nil
---Returns current AAI_Controller_Leyak_C or nil
---@return AAI_Controller_Leyak_C?
function AFUtils.GetAIControllerLeyak()
    if AIControllerLeyakCache and AIControllerLeyakCache:IsValid() then
        return AIControllerLeyakCache
    end
    AIControllerLeyakCache = nil

    local instance = FindFirstOf("AI_Controller_Leyak_C")
    if instance:IsValid() then 
        AIControllerLeyakCache = instance
    end
    
    return AIControllerLeyakCache
end

---Returns struct that represents current selected slot in the hotbat aka. held item
---@param playerCharacter AAbiotic_PlayerCharacter_C
---@return FInventorySlotSelected_Struct?
function AFUtils.GetCurrentHotbarSlotSelected(playerCharacter)
    if playerCharacter and playerCharacter:IsValid() and playerCharacter.CurrentHotbarSlotSelected:IsValid() then
        return playerCharacter.CurrentHotbarSlotSelected
    end
    return nil
end

---Retruns struct that represents the current selected Hotbar item slot, it's inventory component and SlotIndex. The item can be modified through ChangeableData.
---@param playerCharacter AAbiotic_PlayerCharacter_C
---@return FAbiotic_InventoryItemSlotStruct? # Can be used to modify item's data though ChangeableData
---@return UAbiotic_InventoryComponent_C? # Parent InventoryComponent
---@return integer? # Slot index
function AFUtils.GetSelectedHotbarInventoryItemSlot(playerCharacter)
    local slotData = AFUtils.GetCurrentHotbarSlotSelected(playerCharacter)
    if slotData and slotData.Inventory_2_B69CD60741EFD551F09ED5AFF44B1E46:IsValid() then
        local inventory = slotData.Inventory_2_B69CD60741EFD551F09ED5AFF44B1E46
        local luaIndex = slotData.Index_5_6BDC7B3944A5DE0B319F9FA20720872F + 1
        if inventory.CurrentInventory and #inventory.CurrentInventory >= luaIndex then
            return inventory.CurrentInventory[luaIndex], inventory.CurrentInventory, slotData.Index_5_6BDC7B3944A5DE0B319F9FA20720872F
        end
    end
    return nil, nil, nil
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

---Executes DisplayTextChatMessage with [ModName] as prefix
---@param Message string
function AFUtils.ModDisplayTextChatMessage(Message)
    local prefix = GetModInfoPrefix()
    AFUtils.DisplayTextChatMessage(Message, prefix)
end

---AAbiotic_PlayerCharacter_C function, that shows colored text at the top of the screen and can play a warning beep
---@param Message string
---@param CriticalityLevel ECriticalityLevels|AFUtils.CriticalityLevels|integer|nil Color of the message is based on the CriticalityLevel
---@param WarningBeep boolean|nil Should a warning sound be played
function AFUtils.ClientDisplayWarningMessage(Message, CriticalityLevel, WarningBeep)
    if not Message then return end
    -- Default values
    CriticalityLevel = CriticalityLevel or AFUtils.CriticalityLevels.Green
    WarningBeep = WarningBeep or false

    local myPlayer = AFUtils.GetMyPlayer()
    if myPlayer then
        -- LogDebug("ClientDisplayWarningMessage: Message: "..Message.." CriticalityLevel: "..CriticalityLevel.." WarningBeep: "..tostring(WarningBeep))
        local fText = FText(Message)
        if fText then
            myPlayer:Client_DisplayWarningMessage(fText, CriticalityLevel, WarningBeep)
        else
            LogError('ClientDisplayWarningMessage: Couldn\'t get a FText out of "'..Message..'"')
        end
    end
end

---UW_PlayerHUD_Main_C function, same as ClientDisplayWarningMessage but has no option for a warning beep
---@param Message string
---@param CriticalityLevel ECriticalityLevels|AFUtils.CriticalityLevels|integer|nil Color of the message is based on the CriticalityLevel
function AFUtils.DisplayWarningMessage(Message, CriticalityLevel)
    if not Message then return end
    -- Default values
    CriticalityLevel = CriticalityLevel or AFUtils.CriticalityLevels.Green

    local playerHud = AFUtils.GetMyPlayerHUD()
    if playerHud then
        LogDebug("DisplayWarningMessage: Message: "..Message.." CriticalityLevel: "..CriticalityLevel)
        
        local fText = FText(Message)
        if fText then
            playerHud:DisplayWarningMessage(fText, CriticalityLevel)
        else
            LogError('ClientDisplayWarningMessage: Couldn\'t get a FText out of "'..Message..'"')
        end
    end
end

---@param Inventory UAbiotic_InventoryComponent_C
---@param SlotIndex integer
---@return FAbiotic_InventoryItemSlotStruct?
function AFUtils.GetInventoryItemSlot(Inventory, SlotIndex)
    if not Inventory or not Inventory:IsValid() or not SlotIndex or SlotIndex < 0 then return nil end

    -- Lua array starts with 1, while TArray with 0
    local index = SlotIndex + 1
    if Inventory.CurrentInventory and #Inventory.CurrentInventory >= index then
        return Inventory.CurrentInventory[index]
    end

    return nil
end

---Checks if LiquidType exists in AllowedLiquids array of FAbiotic_LiquidStruct
---@param LiquidStruct FAbiotic_LiquidStruct
---@param LiquidType number|AFUtils.LiquidType|E_LiquidType
function AFUtils.IsAllowedLiquidType(LiquidStruct, LiquidType)
    if LiquidStruct and LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3 and LiquidType then
        for i = 1, #LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3, 1 do
            local allowedLiquid = LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3[i]
            if allowedLiquid == LiquidType then
               return true 
            end
        end
    end
    return false
end

---Checks if LiquidType is allowed in AAbiotic_Item_ParentBP_C derived object
---@param Item AAbiotic_Item_ParentBP_C
---@param LiquidType LiquidType|number
function AFUtils.IsAllowedLiquidTypeInItem(Item, LiquidType)
    if Item and Item:IsValid() and Item.ItemData and LiquidType then
        return AFUtils.IsAllowedLiquidType(Item.ItemData.LiquidData_110_4D07F09C483C1E65B39024ABC7032FA0, LiquidType)
    end
    return false
end

---
---@param LiquidStruct FAbiotic_LiquidStruct
---@return LiquidType|number #Returns first allowed LiquidType or None (0)
function AFUtils.GetFirstAllowedLiquidType(LiquidStruct)
    if LiquidStruct and LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3 then
        if #LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3 > 0 then
            return LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3[1]
        end
    end
    return AFUtils.LiquidType.None
end

---
---@param Item AAbiotic_Item_ParentBP_C
---@return LiquidType|number #Returns first allowed LiquidType or None (0)
function AFUtils.GetFirstAllowedLiquidTypeInItem(Item)
    if Item and Item:IsValid() and Item.ItemData then
        return AFUtils.GetFirstAllowedLiquidType(Item.ItemData.LiquidData_110_4D07F09C483C1E65B39024ABC7032FA0)
    end
    return AFUtils.LiquidType.None
end

---comment
---@param Item AAbiotic_Item_ParentBP_C Any object that derives from AAbiotic_Item_ParentBP_C
---@param LiquidType LiquidType|integer|nil Target LiquidType to set. If nil it will take current liquid type
---@param LiquidLevel integer|nil Target LiquidLevel, if nil it will be set to item's max liquid level automatically
---@return boolean Success 
function AFUtils.SetItemLiquidLevel(Item, LiquidType, LiquidLevel)
    if Item and Item:IsValid() and Item:IsA(AFUtils.GetClassAbiotic_Item_ParentBP_C()) and Item.ItemData and Item.ChangeableData then
        if LiquidType then
            if LiquidType <= AFUtils.LiquidType.None or not AFUtils.IsAllowedLiquidTypeInItem(Item, LiquidType) then
                if DebugMode then
                    LogError("SetItemLiquidLevel: Failed, target LiquidType ("..LiquidType..") is not allowed for " .. Item.ItemData.ItemName_51_B88648C048EE5BC2885E4E95F3E13F0A:ToString())
                end
                return false
            end
        else
            local currentLiquidType = Item.ChangeableData.CurrentLiquid_19_3E1652F448223AAE5F405FB510838109
            if currentLiquidType > AFUtils.LiquidType.None then
                LiquidType = currentLiquidType
            elseif #Item.ItemData.LiquidData_110_4D07F09C483C1E65B39024ABC7032FA0.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3 == 1 then
                -- Set LiquidType to first allowed liquid type ONLY if 1 type is allowed (usually it's Power)
                LiquidType = Item.ItemData.LiquidData_110_4D07F09C483C1E65B39024ABC7032FA0.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3[1]
            end
        end
        if LiquidType then
            if type(LiquidLevel) ~= "number" or LiquidLevel < 0 then
                LiquidLevel = Item.ItemData.LiquidData_110_4D07F09C483C1E65B39024ABC7032FA0.MaxLiquid_16_80D4968B4CACEDD3D4018E87DA67E8B4
            end
            Item.ChangeableData.CurrentLiquid_19_3E1652F448223AAE5F405FB510838109 = LiquidType
            Item.ChangeableData.LiquidLevel_46_D6414A6E49082BC020AADC89CC29E35A = LiquidLevel
            if DebugMode then
                LogInfo(string.format("SetItemLiquidLevel: Success. Item: %s, LiquidType: %s, LiquidLevel: %s",
                            Item.ItemData.ItemName_51_B88648C048EE5BC2885E4E95F3E13F0A:ToString(), tostring(LiquidType), tostring(LiquidLevel)))
            end
            return true
        end
        if DebugMode then
            LogError(string.format("SetItemLiquidLevel: Failed. Item: %s, LiquidType: %s, LiquidLevel: %s",
                        Item.ItemData.ItemName_51_B88648C048EE5BC2885E4E95F3E13F0A:ToString(), tostring(LiquidType), tostring(LiquidLevel)))
        end
    end
    return false
end

return AFUtils