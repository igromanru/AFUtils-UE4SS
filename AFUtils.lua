
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

---@enum CharacterSkills
AFUtils.CharacterSkills = {
    None = 0,
    Sprinting = 1,
    Accuracy = 2,
    Reloading = 3,
    Sneaking = 4,
    SharpMeele = 5,
    BluntMelee = 6,
    Fishing = 7,
    Crafting = 8,
    Construction = 9,
    FirstAid = 10,
    Agriculture = 11,
    Cooking = 12,
    Unknown1 = 13,
    Fortitude = 14,
    Strength = 15,
    Throwing = 16,
    Unknown2 = 17
}

---Map of Sandbox Value FNames
---@enum SandboxValueName
AFUtils.SandboxValueName = {
    LootRespawnEnabled = "LootRespawnEnabled",
    PowerSocketsOffAtNight = "PowerSocketsOffAtNight",
    DayNightCycleState = "DayNightCycleState",
    DayNightCycleSpeedMultiplier = "DayNightCycleSpeedMultiplier",
    SinkRefillRate = "SinkRefillRate",
    FoodSpoilSpeedMultiplier = "FoodSpoilSpeedMultiplier",
    RefrigerationEffectivenessMultiplier = "RefrigerationEffectivenessMultiplier",
    EnemySpawnRate = "EnemySpawnRate",
    EnemyHealthMultiplier = "EnemyHealthMultiplier",
    EnemyPlayerDamageMultiplier = "EnemyPlayerDamageMultiplier",
    EnemyDeployableDamageMultiplier = "EnemyDeployableDamageMultiplier",
    DamageToAlliesMultiplier = "DamageToAlliesMultiplier",
    HungerSpeedMultiplier = "HungerSpeedMultiplier",
    ThirstSpeedMultiplier = "ThirstSpeedMultiplier",
    FatigueSpeedMultiplier = "FatigueSpeedMultiplier",
    ContinenceSpeedMultiplier = "ContinenceSpeedMultiplier",
    DetectionSpeedMultiplier = "DetectionSpeedMultiplier",
    PlayerXPGainMultiplier = "PlayerXPGainMultiplier",
    ItemStackSizeMultiplier = "ItemStackSizeMultiplier",
    ItemWeightMultiplier = "ItemWeightMultiplier",
    ItemDurabilityMultiplier = "ItemDurabilityMultiplier",
    DurabilityLossOnDeathMultiplier = "DurabilityLossOnDeathMultiplier",
    ShowDeathMessages = "ShowDeathMessages",
    AllowRecipeSharing = "AllowRecipeSharing",
    AllowPagers = "AllowPagers",
    AllowTransmog = "AllowTransmog",
    DisableResearchMinigame = "DisableResearchMinigame",
    DeathPenalties = "DeathPenalties",
    GlobalRecipeUnlocks = "GlobalRecipeUnlocks",
    FirstTimeStartingWeapon = "FirstTimeStartingWeapon",
    HostAccessPlayerCorpses = "HostAccessPlayerCorpses",
    StorageByTag = "StorageByTag"
}

---Map of weather events
---@enum WeatherEvents
AFUtils.WeatherEvents = {
    None = "None",
    Fog = "Fog",
    RadLeak = "RadLeak",
    Spores = "Spores"
}

-- Static Classes --
--------------------
local Actor_Class = nil
function AFUtils.GetClassActor()
    if not Actor_Class then
        Actor_Class = StaticFindObject("/Script/Engine.Actor")
        ---@cast Actor_Class UClass
    end
    return Actor_Class
end

local AbioticGameViewportClientClass = nil
function AFUtils.GetClassAbioticGameViewportClient()
    if not AbioticGameViewportClientClass or not AbioticGameViewportClientClass:IsValid() then
        AbioticGameViewportClientClass = StaticFindObject("/Script/AbioticFactor.AbioticGameViewportClient")
    end
    return AbioticGameViewportClientClass
end

local Abiotic_PlayerCharacter_C_Class = nil
function AFUtils.GetClassAbiotic_PlayerCharacter_C()
    if not Abiotic_PlayerCharacter_C_Class or not Abiotic_PlayerCharacter_C_Class:IsValid() then
        Abiotic_PlayerCharacter_C_Class = StaticFindObject("/Game/Blueprints/Characters/Abiotic_PlayerCharacter.Abiotic_PlayerCharacter_C")
        ---@cast Abiotic_PlayerCharacter_C_Class UClass
    end
    return Abiotic_PlayerCharacter_C_Class
end

local Abiotic_Item_ParentBP_C_Class = nil
function AFUtils.GetClassAbiotic_Item_ParentBP_C()
    if not Abiotic_Item_ParentBP_C_Class or not Abiotic_Item_ParentBP_C_Class:IsValid() then
        Abiotic_Item_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/Items/Abiotic_Item_ParentBP.Abiotic_Item_ParentBP_C")
        ---@cast Abiotic_Item_ParentBP_C_Class UClass
    end
    return Abiotic_Item_ParentBP_C_Class
end

local AbioticDeployed_ParentBP_C_Class = nil
---@return UClass
function AFUtils.GetClassAbioticDeployed_ParentBP_C()
    if not AbioticDeployed_ParentBP_C_Class or not AbioticDeployed_ParentBP_C_Class:IsValid() then
        AbioticDeployed_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/DeployedObjects/AbioticDeployed_ParentBP.AbioticDeployed_ParentBP_C")
        ---@cast AbioticDeployed_ParentBP_C_Class UClass
    end
    return AbioticDeployed_ParentBP_C_Class
end

local RechargeableComponent_C_Class = nil
function AFUtils.GetClassRechargeableComponent_C()
    if not RechargeableComponent_C_Class or not RechargeableComponent_C_Class:IsValid() then
        RechargeableComponent_C_Class = StaticFindObject("/Game/Blueprints/Items/RechargeableComponent.RechargeableComponent_C")
        ---@cast RechargeableComponent_C_Class UClass
    end
    return RechargeableComponent_C_Class
end

local Deployed_Battery_ParentBP_C_Class = nil
function AFUtils.GetClassDeployed_Battery_ParentBP_C()
    if not Deployed_Battery_ParentBP_C_Class or not Deployed_Battery_ParentBP_C_Class:IsValid() then
        Deployed_Battery_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/DeployedObjects/Misc/Deployed_Battery_ParentBP.Deployed_Battery_ParentBP_C")
        ---@cast Deployed_Battery_ParentBP_C_Class UClass
    end
    return Deployed_Battery_ParentBP_C_Class
end

local Abiotic_Item_Dropped_C_Class = nil
function AFUtils.GetClassAbiotic_Item_Dropped_C()
    if not Abiotic_Item_Dropped_C_Class or not Abiotic_Item_Dropped_C_Class:IsValid() then
        Abiotic_Item_Dropped_C_Class = StaticFindObject("/Game/Blueprints/Items/Abiotic_Item_Dropped.Abiotic_Item_Dropped_C")
        ---@cast Abiotic_Item_Dropped_C_Class UClass
    end
    return Abiotic_Item_Dropped_C_Class
end

local Abiotic_Weapon_ParentBP_C_Class = nil
function AFUtils.GetClassAbiotic_Weapon_ParentBP_C()
    if not Abiotic_Weapon_ParentBP_C_Class or not Abiotic_Weapon_ParentBP_C_Class:IsValid() then
        Abiotic_Weapon_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/Items/Weapons/Abiotic_Weapon_ParentBP.Abiotic_Weapon_ParentBP_C")
        ---@cast Abiotic_Weapon_ParentBP_C_Class UClass
    end
    return Abiotic_Weapon_ParentBP_C_Class
end

local Abiotic_Character_ParentBP_C_Class = nil
function AFUtils.GetClassAbiotic_Character_ParentBP_C()
    if not Abiotic_Character_ParentBP_C_Class or not Abiotic_Character_ParentBP_C_Class:IsValid() then
        Abiotic_Character_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/Characters/Abiotic_Character_ParentBP.Abiotic_Character_ParentBP_C")
        ---@cast Abiotic_Character_ParentBP_C_Class UClass
    end
    return Abiotic_Character_ParentBP_C_Class
end

local NarrativeNPC_ParentBP_C_Class = nil
function AFUtils.GetClassNarrativeNPC_ParentBP_C()
    if not NarrativeNPC_ParentBP_C_Class or not NarrativeNPC_ParentBP_C_Class:IsValid() then
        NarrativeNPC_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/Characters/NarrativeNPCs/NarrativeNPC_ParentBP.NarrativeNPC_ParentBP_C")
        ---@cast NarrativeNPC_ParentBP_C_Class UClass
    end
    return NarrativeNPC_ParentBP_C_Class
end

local NarrativeNPC_Human_ParentBP_C_Class = nil
function AFUtils.GetClassNarrativeNPC_Human_ParentBP_C()
    if not NarrativeNPC_Human_ParentBP_C_Class or not NarrativeNPC_Human_ParentBP_C_Class:IsValid() then
        NarrativeNPC_Human_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/Characters/NarrativeNPCs/NarrativeNPC_Human_ParentBP.NarrativeNPC_Human_ParentBP_C")
        ---@cast NarrativeNPC_Human_ParentBP_C_Class UClass
    end
    return NarrativeNPC_Human_ParentBP_C_Class
end

---- Default objects ---
------------------------

local WeatherEventHandleFunctionLibraryCache = nil
function AFUtils.GetWeatherEventHandleFunctionLibrary()
    if not WeatherEventHandleFunctionLibraryCache or not WeatherEventHandleFunctionLibraryCache:IsValid() then
        WeatherEventHandleFunctionLibraryCache = StaticFindObject("/Script/AbioticFactor.Default__WeatherEventHandleFunctionLibrary")
    end
    return WeatherEventHandleFunctionLibraryCache
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

local PlayerStateCache = nil
---Returns player state of current player
---@return AAbiotic_PlayerState_C?
function AFUtils.GetMyPlayerState()
    if PlayerStateCache and PlayerStateCache:IsValid() then
        return PlayerStateCache
    end

    PlayerStateCache = nil
    local myPlayer = AFUtils.GetMyPlayer()
    if myPlayer and myPlayer.MyPlayerState:IsValid() then
        PlayerStateCache = myPlayer.MyPlayerState
    end

    return PlayerStateCache
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

---Returns player's CharacterProgressionComponent or nil
---@return UAbiotic_CharacterProgressionComponent_C?
function AFUtils.GetMyCharacterProgressionComponent()
    local myPlayer = AFUtils.GetMyPlayer()
    if myPlayer and myPlayer.CharacterProgressionComponent:IsValid() then
        return myPlayer.CharacterProgressionComponent
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

 ---@type UAbiotic_GameInstance_C?
 local GameInstanceCache = nil
 ---Returns UAbiotic_GameInstance_C or nil
 ---@return UAbiotic_GameInstance_C?
 function AFUtils.GetGameInstance()
     if GameInstanceCache and GameInstanceCache:IsValid() then
         return GameInstanceCache
     end
 
     ---@type UAbiotic_GameInstance_C
     GameInstanceCache = FindFirstOf("Abiotic_GameInstance_C")
     return GameInstanceCache and GameInstanceCache:IsValid() and GameInstanceCache or nil
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

---@type AAbiotic_Survival_GameState_C?
local SurvivalGameStateCache = nil
---Returns current AAbiotic_Survival_GameMode_C or nil
---@return AAbiotic_Survival_GameState_C?
function AFUtils.GetSurvivalGameState()
    if SurvivalGameStateCache and SurvivalGameStateCache:IsValid() then
        return SurvivalGameStateCache
    end
    
    SurvivalGameStateCache = FindFirstOf("Abiotic_Survival_GameState_C")
    if not SurvivalGameStateCache or not SurvivalGameStateCache:IsValid() then 
        SurvivalGameStateCache = nil
    end

    return SurvivalGameStateCache
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

---Gets Control Rotation
---@return FRotator
function AFUtils.GetControlRotation()
    local playerController = AFUtils.GetMyPlayerController()
    if playerController then
        return RotatorToUserdata(playerController.ControlRotation)
    end
    return FRotator()
end

---Force client control rotation
---@param Rotation FRotator
---@return boolean Success # false if no valid PlayerController
function AFUtils.SetControlRotation(Rotation)
    local playerController = AFUtils.GetMyPlayerController()
    if playerController then
        playerController:SetControlRotation(Rotation)
        return true
    end
    return false
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

---Get current combined health of all limbs
---@param playerCharacter AAbiotic_Character_ParentBP_C
function AFUtils.GetCurrentCombinedHealth(playerCharacter)
    if not playerCharacter then return 0 end
    return playerCharacter.CurrentHealth_Head + playerCharacter.CurrentHealth_Torso
            + playerCharacter.CurrentHealth_LeftArm + playerCharacter.CurrentHealth_RightArm
            + playerCharacter.CurrentHealth_LeftLeg + playerCharacter.CurrentHealth_RightLeg
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
    if not PlayerCharacter or not Inventory or not PlayerCharacter:IsValid() or not Inventory.CurrentInventory or #Inventory.CurrentInventory < 1 then return false end

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
---@param playerCharacter AAbiotic_PlayerCharacter_C Must be a valid object
---@return boolean Success
function AFUtils.FillHeldItemWithEnergy(playerCharacter)
    if not playerCharacter then return false end
    
    local itemSlotStruct = AFUtils.GetSelectedHotbarInventoryItemSlot(playerCharacter)
    if itemSlotStruct then
        return AFUtils.FillItemSlotStructEnergyFromItem(itemSlotStruct, playerCharacter.ItemInHand_BP)
    end
    return false
end

---@param playerCharacter AAbiotic_PlayerCharacter_C Must be a valid object
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

---Fill CurrentAmmoInMagazine of FAbiotic_InventoryChangeableDataStruct with maximum ammo
---@param ChangeableData FAbiotic_InventoryChangeableDataStruct Target
---@param ItemStruct FAbiotic_InventoryItemStruct Source, WeaponStruct will be used to pull infomation
---@return boolean Filled # Returns true if CurrentAmmoInMagazine was modified, otherwise false
function AFUtils.FillChangeableDataAmmo(ChangeableData, ItemStruct)
    if not ChangeableData or not ItemStruct then return false end

    local weaponData = ItemStruct.WeaponData_61_3C29CF6C4A7F9DD435F9318FEE4B033D
    if weaponData.RequireAmmo_85_8BB1C1954D2A83BB1994549DDEEBA306 then
        local currentAmmoInMagazine = ChangeableData.CurrentAmmoInMagazine_12_D68C190F4B2FA78A4B1D57835B95C53D
        local magazineSize = weaponData.MagazineSize_57_E890A3944240BB8D07EF0B9251F1FBD4
        if currentAmmoInMagazine < magazineSize then
            ChangeableData.CurrentAmmoInMagazine_12_D68C190F4B2FA78A4B1D57835B95C53D = magazineSize
            return true
        end
    end

    return false
end

---Fill CurrentAmmoInMagazine of FAbiotic_InventoryChangeableDataStruct with maximum ammo
---@param ItemSlotStruct FAbiotic_InventoryItemSlotStruct Target, ChangeableData of the struct will be written
---@param ItemStruct FAbiotic_InventoryItemStruct Source, LiquidData will be used to pull infomation
---@return boolean Filled # Returns true if CurrentAmmoInMagazine was modified, otherwise false
function AFUtils.FillItemSlotStructAmmo(ItemSlotStruct, ItemStruct)
    if not ItemSlotStruct or not ItemStruct then return false end
    return AFUtils.FillChangeableDataAmmo(ItemSlotStruct.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313, ItemStruct)
end

---Fill CurrentAmmoInMagazine of FAbiotic_InventoryChangeableDataStruct with maximum ammo
---@param ItemSlotStruct FAbiotic_InventoryItemSlotStruct Target, ChangeableData of the struct will be written
---@param Item AAbiotic_Item_ParentBP_C Source and Target, ItemData.WeaponData will be used to pull infomation for ItemSlotStruct and Item.ChangeableData
---@return boolean Filled # Returns true if CurrentAmmoInMagazine was modified, otherwise false
function AFUtils.FillItemSlotStructAmmoFromItem(ItemSlotStruct, Item)
    if not ItemSlotStruct or not Item or not Item:IsValid() then return false end
    return AFUtils.FillItemSlotStructAmmo(ItemSlotStruct, Item.ItemData) and AFUtils.FillChangeableDataAmmo(Item.ChangeableData, Item.ItemData)
end

---@param playerCharacter AAbiotic_PlayerCharacter_C Must be a valid object
---@return boolean Filled # Returns true if ammo was modified, otherwise false
function AFUtils.FillHeldWeaponWithAmmo(playerCharacter)
    if not playerCharacter or not playerCharacter.ItemInHand_BP:IsValid() then return false end
    
    local weaponData = playerCharacter.ItemInHand_BP.ItemData.WeaponData_61_3C29CF6C4A7F9DD435F9318FEE4B033D
    if not weaponData.RequireAmmo_85_8BB1C1954D2A83BB1994549DDEEBA306 then return false end

    local itemSlotStruct, inventory, slotIndex = AFUtils.GetSelectedHotbarInventoryItemSlot(playerCharacter)
    if itemSlotStruct and inventory and slotIndex then
        if AFUtils.FillItemSlotStructAmmoFromItem(itemSlotStruct, playerCharacter.ItemInHand_BP) then
            playerCharacter.ItemInHand_BP.CurrentRoundsInMagazine = itemSlotStruct.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313.CurrentAmmoInMagazine_12_D68C190F4B2FA78A4B1D57835B95C53D
            return true
        end
    end
    return false
end

---Converts FWeatherEventRowHandle to userdata
---@param EventRow FWeatherEventRowHandle
---@return FWeatherEventRowHandle # It creates userdata that represent FWeatherEventRowHandle
function AFUtils.ConvertWeatherEventRowHandleToUserdata(EventRow)
    return { 
        RowName = EventRow.RowName,
        DataTablePath = EventRow.DataTablePath
     }
end

---Triggers a weather event
---@param EventName string|WeatherEvents
---@return boolean Success
function AFUtils.TriggerWeatherEvent(EventName)
    if type(EventName) ~= "string" then return false end

    local weatherEventHandleFunctionLibrary = AFUtils.GetWeatherEventHandleFunctionLibrary()
    local myPlayerController = AFUtils.GetMyPlayerController()
    if weatherEventHandleFunctionLibrary and myPlayerController and myPlayerController.DayNightManager:IsValid() then
        ---@type table<LocalUnrealParam>
        local outRowHandles = {}
        weatherEventHandleFunctionLibrary:GetAllWeatherEventRowHandles(outRowHandles)
        for i = 1, #outRowHandles, 1 do
            local param = outRowHandles[i]
            LogDebug(i..": "..param:type())

            ---@type FWeatherEventRowHandle
            local rowHandle = param:get()
            local rowName = rowHandle.RowName:ToString()
            if rowName == EventName then
                myPlayerController.DayNightManager.RequiredDaysBetweenWeather = 0
                myPlayerController.DayNightManager.Weather_RequestByPlayer.RowName = rowHandle.RowName
                LogDebug("Weather_RequestByPlayer.RowName: "..myPlayerController.DayNightManager.Weather_RequestByPlayer.RowName:ToString())
                -- myPlayerController.DayNightManager:TriggerWeatherEvent(AFUtils.ConvertWeatherEventRowHandleToUserdata(rowHandle))
                -- LogDebug("TriggerWeatherEvent: Triggering event: " .. EventName)
                return true
            end
        end
    end
    return false
end

---Set next weather event
---@param EventName string|WeatherEvents
---@return boolean Success
function AFUtils.SetNextWeatherEvent(EventName)
    if type(EventName) ~= "string" then return false end

    local myPlayerController = AFUtils.GetMyPlayerController()
    if myPlayerController and myPlayerController.DayNightManager:IsValid() then
        local RowName = FName(EventName, EFindName.FNAME_Find)
        myPlayerController.DayNightManager.RequiredDaysBetweenWeather = 0
        myPlayerController.DayNightManager.Weather_RequestByPlayer.RowName = RowName
        LogDebug("SetNextWeatherEvent: Weather_RequestByPlayer.RowName: "..myPlayerController.DayNightManager.Weather_RequestByPlayer.RowName:ToString())
        return true
    end
    return false
end

---@param playerCharacter AAbiotic_PlayerCharacter_C
function AFUtils.HealAllLimbs(playerCharacter)
    playerCharacter.CurrentHealth_Head = 70.0
    playerCharacter.CurrentHealth_Torso = 100.0
    playerCharacter.CurrentHealth_LeftArm= 100.0
    playerCharacter.CurrentHealth_RightArm = 100.0
    playerCharacter.CurrentHealth_LeftLeg = 100.0
    playerCharacter.CurrentHealth_RightLeg = 100.0
    for i = 1, 6, 1 do
        local outSuccess = { Success = false }
        playerCharacter:Server_HealRandomLimb(100.0, outSuccess)
    end
end

---Teleports a player to a close location of another
---@param Player AAbiotic_PlayerCharacter_C? # Player that should be teleported
---@param TargetPlayer AAbiotic_PlayerCharacter_C? # Target to teleport to
---@param Behind boolean? # If the player should be teleported behind or infront of the target
---@param DistanceToActor integer? # Default 100 aka. 1m
---@return boolean Sucess
function AFUtils.TeleportPlayerToPlayer(Player, TargetPlayer, Behind, DistanceToActor)
    if not Player or not TargetPlayer or not Player:IsValid() or not TargetPlayer:IsValid() then return false end

    Behind = Behind or false
    DistanceToActor = DistanceToActor or 100 -- 1m
    
    local direction = TargetPlayer:GetActorForwardVector()
    local tagetLocation = TargetPlayer:K2_GetActorLocation()
    tagetLocation.Z = tagetLocation.Z + 20
    local targetRotation = TargetPlayer:K2_GetActorRotation()
    if Behind then
        DistanceToActor = DistanceToActor * -1
    else
        targetRotation.Yaw = targetRotation.Yaw * -1
    end
    local locationOffset = GetKismetMathLibrary():Multiply_VectorVector(direction, FVector(DistanceToActor, DistanceToActor, 0))
    tagetLocation = GetKismetMathLibrary():Add_VectorVector(tagetLocation, locationOffset)
    
    return Player:TeleportPlayer(tagetLocation, targetRotation)
end

---@param InventoryItemSlot UW_InventoryItemSlot_C
---@return UAbiotic_InventoryComponent_C? Inventory, integer SlotIndex
function AFUtils.GetInventoryAndSlotIndexFromItemSlot(InventoryItemSlot)
    if not InventoryItemSlot or not InventoryItemSlot:IsValid() then return nil, 0 end

    if InventoryItemSlot.ParentInventoryGrid:IsValid() and InventoryItemSlot.ParentInventoryGrid.MainInventoryComponent:IsValid() then
        return InventoryItemSlot.ParentInventoryGrid.MainInventoryComponent, InventoryItemSlot.SlotIndex
    end
    return nil, 0
end

---@param Inventory UAbiotic_InventoryComponent_C
---@param SlotIndex integer
---@param StackToAdd integer
---@return boolean Executed # Returns false if PlayerController doesn't exists or one of parameters is wrong
function AFUtils.AddToItemStack(Inventory, SlotIndex, StackToAdd)
    if not Inventory or not Inventory:IsValid() or not SlotIndex or not StackToAdd then return false end

    local myPlayerController = AFUtils.GetMyPlayerController()
    if myPlayerController then
        myPlayerController:Server_AddToItemStack(Inventory, SlotIndex, StackToAdd)
        return true
    end

    return false
end

return AFUtils
