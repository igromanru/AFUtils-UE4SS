
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
local PlayerControllerCache = nil

-- Exported variables --
------------------------
AFUtils.LiquidType = {
    None = 0,
    Water = 1,
    RadioactiveWaste = 3,
    Power = 7,
    TaintedWater = 10
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

local Deployed_Battery_ParentBP_C_Class = nil
function AFUtils.GetClassDeployed_Battery_ParentBP_C()
    if not Deployed_Battery_ParentBP_C_Class then
        Deployed_Battery_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/DeployedObjects/Misc/Deployed_Battery_ParentBP.Deployed_Battery_ParentBP_C")
        LogDebug("Deployed_Battery_ParentBP_C_Class: " .. type(Deployed_Battery_ParentBP_C_Class))
    end
    return Deployed_Battery_ParentBP_C_Class
end

-- Exported functions --
------------------------
---Logs in debug scope all relevant properties of FAbiotic_InventoryChangeableDataStruct to console 
---@param ChangeableData FAbiotic_InventoryChangeableDataStruct
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogInventoryChangeableDataStruct(ChangeableData, Prefix)
    if not ChangeableData then return end
    Prefix = Prefix or ""

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

---Logs in debug scope all relevant properties of FAbiotic_InventoryItemSlotStruct to console 
---@param InventoryItemSlotStruct FAbiotic_InventoryItemSlotStruct
---@param Prefix string?
function AFUtils.LogInventoryItemSlotStruct(InventoryItemSlotStruct, Prefix)
    if not InventoryItemSlotStruct then return end
    Prefix = Prefix or ""

    LogDebug(Prefix .. "RowName: " .. InventoryItemSlotStruct.ItemDataTable_18_BF1052F141F66A976F4844AB2B13062B.RowName:ToString())
    AFUtils.LogInventoryChangeableDataStruct(InventoryItemSlotStruct.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313, Prefix .. "ChangeableData.")
end

---Logs in debug scope all relevant properties of FAbiotic_LiquidStruct to console 
---@param LiquidStruct FAbiotic_LiquidStruct
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogLiquidStruct(LiquidStruct, Prefix)
    if not LiquidStruct then return end
    Prefix = Prefix or ""

    LogDebug(Prefix .. "MaxLiquid: " .. LiquidStruct.MaxLiquid_16_80D4968B4CACEDD3D4018E87DA67E8B4)
    LogDebug(Prefix .. "AllowedLiquids.Num: " .. #LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3)
    for i = 1, #LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3, 1 do
        local liquiedType = LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3[i]
        LogDebug(Prefix .. string.format("AllowedLiquids[%d]: ", i) .. liquiedType)
    end
    LogDebug(Prefix .. "PercentageLiquidToStartWith: " .. LiquidStruct.PercentageLiquidToStartWith_11_835A4C4F440C319874D3EFA75CAFA4C5)
    LogDebug(Prefix .. "LiquidToStartWith.Num: " .. #LiquidStruct.LiquidToStartWith_15_F7D753A24D2130B92AF312AB9192AD9C)
end

---Logs in debug scope all relevant properties of FAbiotic_InventoryItemStruct to console 
---@param InventoryItemStruct FAbiotic_InventoryItemStruct
---@param Prefix string?
function AFUtils.LogInventoryItemStruct(InventoryItemStruct, Prefix)
    if not InventoryItemStruct then return end
    Prefix = Prefix or ""

    LogDebug(Prefix .. "ItemName: " .. InventoryItemStruct.ItemName_51_B88648C048EE5BC2885E4E95F3E13F0A:ToString())
    LogDebug(Prefix .. "ItemDescription: " .. InventoryItemStruct.ItemDescription_38_E5F7B38A4F3C41EB9DA52CA14654D303:ToString())
    LogDebug(Prefix .. "ItemFlavorText: " .. InventoryItemStruct.ItemFlavorText_39_12D05DD74EA145A5E7D1159C7F326177:ToString())
    LogDebug(Prefix .. "ToInteractWith_Text: " .. InventoryItemStruct.ToInteractWith_Text_66_C2148289464D5AAA4D19BBA13F15FE41:ToString())
    LogDebug(Prefix .. "ToLongInteractWith_Text: " .. InventoryItemStruct.ToLongInteractWith_Text_68_4FBE88F341B6A020E3216CA026A1E4E8:ToString())
    LogDebug(Prefix .. "ToPackage_Text: " .. InventoryItemStruct.ToPackage_Text_71_5094104748FCB4BD2F90C99A2C4C49A8:ToString())
    LogDebug(Prefix .. "ToLongPackage_Text: " .. InventoryItemStruct.ToLongPackage_Text_72_CB77853E49960F43E6422C90DC967508:ToString())
    LogDebug(Prefix .. "Scale_WorldMesh: " .. InventoryItemStruct.Scale_WorldMesh_143_AF66D856410026FCC19E70AC421B3667)
    LogDebug(Prefix .. "Scale_FirstPersonMesh: " .. InventoryItemStruct.Scale_FirstPersonMesh_146_6AFCDB94484AE7625E73C6AFB835D21F)
    LogDebug(Prefix .. "Scale_TPHeldMesh: " .. InventoryItemStruct.Scale_TPHeldMesh_145_6826D00A4F30AEDBF62E02892E4261E6)
    LogDebug(Prefix .. "PlacementOrientationsAllowed enum: " .. InventoryItemStruct.PlacementOrientationsAllowed_122_75894D7C4B93F103C06AB18421167757)
    LogDebug(Prefix .. "CanLoseDurability: " .. tostring(InventoryItemStruct.CanLoseDurability_29_42EA515F4AC1EC69D8480DB36C01D5E1))
    LogDebug(Prefix .. "MaxItemDurability: " .. InventoryItemStruct.MaxItemDurability_31_6EBCEFC943F9E85DE9350BBC0E249447)
    LogDebug(Prefix .. "ChanceToLoseDurability: " .. InventoryItemStruct.ChanceToLoseDurability_97_DF967C464092E2E6AEEBFE84C536ACAB)
    -- ToDo log FAbiotic_ItemDropStruct, InventoryItemStruct.RepairItem_106_C2E89B0B4B7F39FC3B2B828BBD13A391
    LogDebug(Prefix .. "StackSize: " .. InventoryItemStruct.StackSize_47_D124F11B4B6D9766B2B33699795845A9)
    LogDebug(Prefix .. "Weight: " .. InventoryItemStruct.Weight_119_CE7DB430417207921D739CAF458D4D7C)
    LogDebug(Prefix .. "TryPlaceInHotbar: " .. tostring(InventoryItemStruct.TryPlaceInHotbar_128_F78F6AA34A238AEAB278F48066C080BF))
    LogDebug(Prefix .. "IsWeapon: " .. tostring(InventoryItemStruct.IsWeapon_63_57F6A703413EA260B1455CA81F2D4911))
    -- ToDo log FAbiotic_WeaponStruct, InventoryItemStruct.WeaponData_61_3C29CF6C4A7F9DD435F9318FEE4B033D
    -- ToDo log FAbiotic_Equipment_Struct, InventoryItemStruct.EquipmentData_100_576D05464F36104AFE501B878255E318
    -- ToDo log FAbiotic_Consumable_Struct, InventoryItemStruct.ConsumableData_84_757B6B114FF23016981BEF888A31C670
    -- ToDo log FAbiotic_CookableStruct, InventoryItemStruct.CookableData_94_7EFD1F0A4A7EFB44D3D8B9B14581BF36
    AFUtils.LogLiquidStruct(InventoryItemStruct.LiquidData_110_4D07F09C483C1E65B39024ABC7032FA0, Prefix .. "LiquidData.")
    LogDebug(Prefix .. "StrippedFromBuild: " .. tostring(InventoryItemStruct.StrippedFromBuild_149_8F18A38A4BB983B801C379B47FC5D5A9))
end

---Logs in debug scope all relevant properties of URechargeableComponent_C to console 
---@param RechargeableComponent URechargeableComponent_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogRechargeableComponent(RechargeableComponent, Prefix)
    if not RechargeableComponent then return end
    Prefix = Prefix or ""

    LogDebug(Prefix .. "LightSourceType: " .. RechargeableComponent.LightSourceType)
    LogDebug(Prefix .. "RechargeableActive: " .. tostring(RechargeableComponent.RechargeableActive))
    LogDebug(Prefix .. "LastBatteryLevel: " .. RechargeableComponent.LastBatteryLevel)
    LogDebug(Prefix .. "DrainPerTick: " .. RechargeableComponent.DrainPerTick)
    LogDebug(Prefix .. "ChargeMultiplier: " .. RechargeableComponent.ChargeMultiplier)
    LogDebug(Prefix .. "Headlamp: " .. tostring(RechargeableComponent.Headlamp))
    LogDebug(Prefix .. "HeadlampIndex: " .. RechargeableComponent.HeadlampIndex)
    LogDebug(Prefix .. "LastItemChargePercentage: " .. RechargeableComponent.LastItemChargePercentage)
    LogDebug(Prefix .. "BatteryNotRequiredToFireWeapon: " .. tostring(RechargeableComponent.BatteryNotRequiredToFireWeapon))
    LogDebug(Prefix .. "OwnerSlotType: " .. RechargeableComponent.OwnerSlotType)
    LogDebug(Prefix .. "PlayerOwned: " .. tostring(RechargeableComponent.PlayerOwned))
end

---Logs in debug scope all relevant properties of a ADeployed_Battery_ParentBP_C to console 
---@param DeployedBattery ADeployed_Battery_ParentBP_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogDeployedBattery(DeployedBattery, Prefix)
    if not DeployedBattery then return end
    Prefix = Prefix or ""

    LogDebug("PlugStripPowerSockets Count: " .. #DeployedBattery.PlugStripPowerSockets)
    LogDebug("HasBatteryPower: " .. tostring(DeployedBattery.HasBatteryPower))
    LogDebug("TimerMode: " .. DeployedBattery.TimerMode)
    LogDebug("PowerTimerActive: " .. tostring(DeployedBattery.PowerTimerActive))
    LogDebug("BatteryPercentage: " .. DeployedBattery.BatteryPercentage)
    LogDebug("DevicesPullingPower: " .. DeployedBattery.DevicesPullingPower)
    LogDebug("MaxBattery: " .. DeployedBattery.MaxBattery)
    LogDebug("FreezeBatteryDrain: " .. tostring(DeployedBattery.FreezeBatteryDrain))
    -- local outCount = {}
    -- DeployedBattery:GetPluggedInDeviceCount(outCount)
    -- if outCount and outCount.Count then
    --     LogDebug("PluggedInDeviceCount: " .. outCount.Count)
    -- end
    AFUtils.LogRechargeableComponent(DeployedBattery.RechargeableComponent, Prefix .. "Rechargeable.")
end

---Returns current AAbiotic_PlayerController_C or nil
---@return AAbiotic_PlayerController_C?
function AFUtils.GetMyPlayerController()
    if PlayerControllerCache and PlayerControllerCache:IsValid() then return PlayerControllerCache end
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

---Executes DisplayTextChatMessage with [ModName] as prefix
---@param Message string
function AFUtils.ModDisplayTextChatMessage(Message)
    local prefix = GetModInfoPrefix()
    AFUtils.DisplayTextChatMessage(Message, prefix)
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

---Checks if LiquidType exists in AllowedLiquids array of FAbiotic_LiquidStruct
---@param LiquidStruct FAbiotic_LiquidStruct
---@param LiquidType LiquidType|number
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