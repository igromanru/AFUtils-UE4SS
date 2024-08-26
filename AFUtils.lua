
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
---@enum LiquidType
AFUtils.LiquidType = {
    None = 0,
    Water = 1,
    Unknown2 = 2,
    RadioactiveWaste = 3,
    Unknown4 = 4,
    Unknown5 = 5,
    Unknown6 = 6,
    Energy = 7,
    Unknown8 = 8,
    Unknown9 = 9,
    TaintedWater = 10,
    Unknown11 = 11,
    LaserEnergy = 12,
    Unknown13 = 13
}

---@enum CriticalityLevels
AFUtils.CriticalityLevels = {
    Green = 0,
    Gray = 1,
    Yellow = 2,
    Red = 3,
    Purple = 4
}

-- Mapping for the CurrentInventory TArray in CharacterEquipSlotInventory (Lua based indexes aka. start with 1)
---@enum GearInventoryIndex
AFUtils.GearInventoryIndex = {
    ChestArmor = 1,
    HeadArmor = 2,
    LegArmor = 3,
    Backpack = 4,
    ArmArmor = 5,
    FullBodySuit = 6,
    Headlamp = 7,
    Trinket = 8,
    Wristwatch = 9, -- Wristwatch or Pager
    KeypadHacker = 10,
    OffHandShield = 11
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

    ---@type AAbiotic_PlayerController_C[]?
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

---@type AAbiotic_Survival_GameMode_C?
local SurvivalGameModeCache = nil
---Returns current AAbiotic_Survival_GameMode_C or nil
---@return AAbiotic_Survival_GameMode_C?
function AFUtils.GetSurvivalGameMode()
    if SurvivalGameModeCache and SurvivalGameModeCache:IsValid() then
        return SurvivalGameModeCache
    end
    
    SurvivalGameModeCache = FindFirstOf("Abiotic_Survival_GameMode_C")
    if not SurvivalGameModeCache or not SurvivalGameModeCache:IsValid() then 
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

 ---@type AAI_Controller_Leyak_C?
local AIControllerLeyakCache = nil
---Returns current AAI_Controller_Leyak_C or nil
---@return AAI_Controller_Leyak_C?
function AFUtils.GetAIControllerLeyak()
    if AIControllerLeyakCache and AIControllerLeyakCache:IsValid() then
        return AIControllerLeyakCache
    end

    ---@type AAI_Controller_Leyak_C?
    AIControllerLeyakCache = FindFirstOf("AI_Controller_Leyak_C")
    if not AIControllerLeyakCache or not AIControllerLeyakCache:IsValid() then 
        AIControllerLeyakCache = nil
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
            return inventory.CurrentInventory[luaIndex], inventory, slotData.Index_5_6BDC7B3944A5DE0B319F9FA20720872F
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
---@param CriticalityLevel ECriticalityLevels|CriticalityLevels|integer|nil Color of the message is based on the CriticalityLevel
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
---@param CriticalityLevel ECriticalityLevels|CriticalityLevels|integer|nil Color of the message is based on the CriticalityLevel
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

---Checks if the LiquidType is energy
---@param LiquidType number|LiquidType|E_LiquidType
function AFUtils.IsEnergyLiquidType(LiquidType)
    return LiquidType == AFUtils.LiquidType.Energy or LiquidType == AFUtils.LiquidType.LaserEnergy
end

---Checks if the LiquidType is energy in FAbiotic_InventoryItemStruct
---@param ItemSlotStruct FAbiotic_InventoryItemSlotStruct
function AFUtils.IsEnergyLiquidTypeInItemSlotStruct(ItemSlotStruct)
    if not ItemSlotStruct or not ItemSlotStruct.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313 then
        return false
    end
    return AFUtils.IsEnergyLiquidType(ItemSlotStruct.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313.CurrentLiquid_19_3E1652F448223AAE5F405FB510838109)
end

---Checks if LiquidType exists in AllowedLiquids array of FAbiotic_LiquidStruct
---@param LiquidStruct FAbiotic_LiquidStruct
---@param LiquidType number|LiquidType|E_LiquidType
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

---Checks if LiquidType is allowed in FAbiotic_InventoryItemStruct
---@param ItemStruct FAbiotic_InventoryItemStruct
---@param LiquidType LiquidType|number
function AFUtils.IsAllowedLiquidTypeInItemStruct(ItemStruct, LiquidType)
    if ItemStruct and ItemStruct.LiquidData_110_4D07F09C483C1E65B39024ABC7032FA0 and LiquidType then
        return AFUtils.IsAllowedLiquidType(ItemStruct.LiquidData_110_4D07F09C483C1E65B39024ABC7032FA0, LiquidType)
    end
    return false
end

---Checks if AllowedLiquidType array has only energy types in it
---@param LiquidStruct FAbiotic_LiquidStruct
---@return boolean # Returns true if only energy liquid types are allowed
function AFUtils.IsOnlyEnergyLiquidTypeAllowed(LiquidStruct)
    local result = false
    if LiquidStruct and LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3 then
        for i = 1, #LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3, 1 do
            local allowedLiquid = LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3[i]
            result = AFUtils.IsEnergyLiquidType(allowedLiquid)
            if not result then
               break
            end
        end
    end
    return result
end

---Checks if AllowedLiquidType array has only energy types in it
---@param ItemStruct FAbiotic_InventoryItemStruct
---@return boolean # Returns true if only energy liquid types are allowed
function AFUtils.IsOnlyEnergyLiquidTypeAllowedInItemStruct(ItemStruct)
    if ItemStruct and ItemStruct.LiquidData_110_4D07F09C483C1E65B39024ABC7032FA0 then
        return AFUtils.IsOnlyEnergyLiquidTypeAllowed(ItemStruct.LiquidData_110_4D07F09C483C1E65B39024ABC7032FA0)
    end
    return true
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
---@param ItemStruct FAbiotic_InventoryItemStruct
---@return LiquidType|number #Returns first allowed LiquidType or None (0)
function AFUtils.GetFirstAllowedLiquidTypeInItemStruct(ItemStruct)
    if ItemStruct then
        return AFUtils.GetFirstAllowedLiquidType(ItemStruct.LiquidData_110_4D07F09C483C1E65B39024ABC7032FA0)
    end
    return AFUtils.LiquidType.None
end

---
---@param LiquidStruct FAbiotic_LiquidStruct
---@return LiquidType|number #Returns last allowed LiquidType or None (0)
function AFUtils.GetLastAllowedLiquidType(LiquidStruct)
    if LiquidStruct and LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3 then
        local arrayCount = #LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3
        if arrayCount > 0 then
            return LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3[arrayCount]
        end
    end
    return AFUtils.LiquidType.None
end

---
---@param ItemStruct FAbiotic_InventoryItemStruct
---@return LiquidType|E_LiquidType|number #Returns last allowed LiquidType or None (0)
function AFUtils.GetLastAllowedLiquidTypeInItemStruct(ItemStruct)
    if ItemStruct then
        return AFUtils.GetLastAllowedLiquidType(ItemStruct.LiquidData_110_4D07F09C483C1E65B39024ABC7032FA0)
    end
    return AFUtils.LiquidType.None
end

---Sets CurrentItemDurability in ChangeableData to MaxItemDurability
---@param ItemSlotStruct FAbiotic_InventoryItemSlotStruct
---@return boolean Success
function AFUtils.FillItemSlotStructDurability(ItemSlotStruct)
   if not ItemSlotStruct or not ItemSlotStruct.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313 then return false end 

   local maxItemDurability = ItemSlotStruct.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313.MaxItemDurability_6_F5D5F0D64D4D6050CCCDE4869785012B
   if maxItemDurability > 0 then
        ItemSlotStruct.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313.CurrentItemDurability_4_24B4D0E64E496B43FB8D3CA2B9D161C8 = maxItemDurability
        return true
   end
   return false
end

---@param Inventory UAbiotic_InventoryComponent_C
---@return boolean Success
function AFUtils.FillDurabilityOfAllItemsInInvetory(Inventory)
    if not Inventory or not Inventory.CurrentInventory or #Inventory.CurrentInventory <= 0 then return false end

    local result = true
    for i = 1, #Inventory.CurrentInventory do
        if not AFUtils.FillItemSlotStructDurability(Inventory.CurrentInventory[i]) then
            result = false
        end
    end
    return result
end

---Uses Request_RepairItem to repair all items, which also works on servers as guest
---@param PlayerCharacter AAbiotic_PlayerCharacter_C
---@param Inventory UAbiotic_InventoryComponent_C
---@return boolean Success
function AFUtils.RepairAllItemsInInvetory(PlayerCharacter, Inventory)
    if not PlayerCharacter or not Inventory or PlayerCharacter:IsValid() or not Inventory.CurrentInventory or #Inventory.CurrentInventory < 1 then return false end

    for i = 1, #Inventory.CurrentInventory do
        local itemSlotStruct = Inventory.CurrentInventory[i]
        if itemSlotStruct.ItemDataTable_18_BF1052F141F66A976F4844AB2B13062B.RowName:GetComparisonIndex() > 0 then
            local currentItemDurability = itemSlotStruct.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313.CurrentItemDurability_4_24B4D0E64E496B43FB8D3CA2B9D161C8
            local maxItemDurability = itemSlotStruct.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313.MaxItemDurability_6_F5D5F0D64D4D6050CCCDE4869785012B
            if maxItemDurability > 0 and currentItemDurability < maxItemDurability then
                PlayerCharacter:Request_RepairItem(Inventory, i - 1, maxItemDurability - currentItemDurability, false)
            end
        end
    end
    return true
end

---Fill liquid level of FAbiotic_InventoryChangeableDataStruct with best allowed liquid type to maximum
---@param ChangeableData FAbiotic_InventoryChangeableDataStruct Target
---@param ItemStruct FAbiotic_InventoryItemStruct Source, LiquidData will be used to pull infomation
---@return boolean Success
function AFUtils.FillChangeableDataEnergy(ChangeableData, ItemStruct)
    if not ChangeableData or not ItemStruct then return false end

    local liquidData = ItemStruct.LiquidData_110_4D07F09C483C1E65B39024ABC7032FA0
    if liquidData.MaxLiquid_16_80D4968B4CACEDD3D4018E87DA67E8B4 > 0 and AFUtils.IsOnlyEnergyLiquidTypeAllowedInItemStruct(ItemStruct) then
        local currentLiquidType = ChangeableData.CurrentLiquid_19_3E1652F448223AAE5F405FB510838109
        if not AFUtils.IsEnergyLiquidType(currentLiquidType) then
            currentLiquidType = AFUtils.GetLastAllowedLiquidTypeInItemStruct(ItemStruct)
        end
        ChangeableData.CurrentLiquid_19_3E1652F448223AAE5F405FB510838109 = currentLiquidType
        ChangeableData.LiquidLevel_46_D6414A6E49082BC020AADC89CC29E35A = liquidData.MaxLiquid_16_80D4968B4CACEDD3D4018E87DA67E8B4
        return true
    end

    return false
end

---Fill liquid level of FAbiotic_InventoryItemSlotStruct with best allowed liquid type to maximum
---@param ItemSlotStruct FAbiotic_InventoryItemSlotStruct Target, ChangeableData of the struct will be written
---@param ItemStruct FAbiotic_InventoryItemStruct Source, LiquidData will be used to pull infomation
---@return boolean Success
function AFUtils.FillItemSlotStructEnergy(ItemSlotStruct, ItemStruct)
    if not ItemSlotStruct or not ItemStruct then return false end
    return AFUtils.FillChangeableDataEnergy(ItemSlotStruct.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313, ItemStruct)
end

---Fill liquid level of FAbiotic_InventoryItemSlotStruct with best allowed liquid type to maximum
---@param ItemSlotStruct FAbiotic_InventoryItemSlotStruct Target, ChangeableData of the struct will be written
---@param Item AAbiotic_Item_ParentBP_C Source and Target, ItemData.LiquidData will be used to pull infomation for ItemSlotStruct and Item.ChangeableData
---@return boolean Success
function AFUtils.FillItemSlotStructEnergyFromItem(ItemSlotStruct, Item)
    if not ItemSlotStruct or not Item or not Item:IsValid() then return false end
    return AFUtils.FillItemSlotStructEnergy(ItemSlotStruct, Item.ItemData) and AFUtils.FillChangeableDataEnergy(Item.ChangeableData, Item.ItemData)
end

---Fills current, in hotbar selected item with it's maximum allowed energy. If the item is drained, refills it with best allowed energy.<br>
---@param playerCharacter AAbiotic_PlayerCharacter_C
---@return boolean Success
function AFUtils.FillHeldItemWithEnergy(playerCharacter)
    if not playerCharacter then return end
    
    local itemSlotStruct = AFUtils.GetSelectedHotbarInventoryItemSlot(playerCharacter)
    if itemSlotStruct then
        return AFUtils.FillItemSlotStructEnergyFromItem(itemSlotStruct, playerCharacter.ItemInHand_BP)
    end
    return false
end

---@param playerCharacter AAbiotic_PlayerCharacter_C
function AFUtils.FillAllEquippedItemsWithEnergy(playerCharacter)
    if not playerCharacter or not playerCharacter.CharacterEquipSlotInventory:IsValid() or #playerCharacter.CharacterEquipSlotInventory.CurrentInventory < 11 then
        return
    end
    local itemSlotStructs = playerCharacter.CharacterEquipSlotInventory.CurrentInventory
    local chestArmorSlotStruct = itemSlotStructs[AFUtils.GearInventoryIndex.ChestArmor]
    local headArmorSlotStruct = itemSlotStructs[AFUtils.GearInventoryIndex.HeadArmor]
    local legArmorSlotStruct = itemSlotStructs[AFUtils.GearInventoryIndex.LegArmor]
    local backpackSlotStruct = itemSlotStructs[AFUtils.GearInventoryIndex.Backpack]
    local armArmorSlotStruct = itemSlotStructs[AFUtils.GearInventoryIndex.ArmArmor]
    local suitSlotStruct = itemSlotStructs[AFUtils.GearInventoryIndex.FullBodySuit]
    local headlampSlotStruct = itemSlotStructs[AFUtils.GearInventoryIndex.Headlamp]
    local trinketSlotStruct = itemSlotStructs[AFUtils.GearInventoryIndex.Trinket]
    local shieldSlotStruct = itemSlotStructs[AFUtils.GearInventoryIndex.OffHandShield]
    local wristwatchSlotStruct = itemSlotStructs[AFUtils.GearInventoryIndex.Wristwatch]

    AFUtils.FillItemSlotStructEnergyFromItem(chestArmorSlotStruct, playerCharacter.Gear_TorsoBP)
    AFUtils.FillItemSlotStructEnergyFromItem(headArmorSlotStruct, playerCharacter.Gear_TorsoBP)
    AFUtils.FillItemSlotStructEnergyFromItem(legArmorSlotStruct, playerCharacter.Gear_LegsBP)
    AFUtils.FillItemSlotStructEnergyFromItem(backpackSlotStruct, playerCharacter.Gear_BackpackBP)
    AFUtils.FillItemSlotStructEnergyFromItem(armArmorSlotStruct, playerCharacter.Gear_ArmsBP)
    AFUtils.FillItemSlotStructEnergyFromItem(suitSlotStruct, playerCharacter.Gear_SuitBP)
    AFUtils.FillItemSlotStructEnergyFromItem(headlampSlotStruct, playerCharacter.Gear_HeadlampBP)
    AFUtils.FillItemSlotStructEnergyFromItem(trinketSlotStruct, playerCharacter.Gear_TrinketBP)
    AFUtils.FillItemSlotStructEnergyFromItem(shieldSlotStruct, playerCharacter.Gear_ShieldBP)
    AFUtils.FillItemSlotStructEnergyFromItem(wristwatchSlotStruct, playerCharacter.Gear_WristwatchBP)
end

return AFUtils