
--[[
    Author: Igromanru
    Date: 19.08.2024
    Description: Utility functions for the game Abiotic Factor
]]

local UEHelpers = require("UEHelpers")
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
    OffHandShield = 11,
    Trinket2 = 12,
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

---Map of Traits. Key is trait's FName<br>
---Game v0.9.2
---@type { [string]: { Description: string, Buff: boolean } }
AFUtils.Traits = {
	Trait_Decathlon = {
		Description = "Decathlon Competitor",
		Buff = true,
	},
	Trait_FormerGuard = {
		Description = "Tough as Nails",
		Buff = true,
	},
	Trait_WrinklyBrainmeat = {
		Description = "Wrinkly Brainmeat",
		Buff = true,
	},
	Trait_NightOwl = {
		Description = "Night Owl",
		Buff = true,
	},
	Trait_Chef = {
		Description = "Hobbyist Chef",
		Buff = true,
	},
	Trait_Inconspicuous = {
		Description = "Inconspicuous",
		Buff = true,
	},
	Trait_Outdoorsman = {
		Description = "Weathered",
		Buff = true,
	},
	Trait_FannyPack = {
		Description = "Fanny Pack",
		Buff = true,
	},
	Trait_ThickSkinned = {
		Description = "Thick Skinned",
		Buff = true,
	},
	Trait_FirstAidCert = {
		Description = "First Aid Certification",
		Buff = true,
	},
	Trait_Gardener = {
		Description = "Gardener",
		Buff = true,
	},
	Trait_LightEater = {
		Description = "Light Eater",
		Buff = true,
	},
	Trait_Moist = {
		Description = "Naturally Moist",
		Buff = true,
	},
	Trait_SelfDefense = {
		Description = "Self Defense",
		Buff = true,
	},
	Trait_SteelBladder = {
		Description = "Bladder of Steel",
		Buff = true,
	},
	Trait_Strong = {
		Description = "Buff Brainiac",
		Buff = true,
	},
	Trait_LeadBelly = {
		Description = "Lead Belly",
		Buff = true,
	},
	Trait_FearOfViolence = {
		Description = "Fear of Violence",
		Buff = false,
	},
	Trait_EasilyStartled = {
		Description = "Easily Startled",
		Buff = false,
	},
	Trait_Feeble = {
		Description = "Feeble",
		Buff = false,
	},
	Trait_Narcoleptic = {
		Description = "Narcoleptic",
		Buff = false,
	},
	Trait_Agoraphobic = {
		Description = "Agoraphobic",
		Buff = false,
	},
	Trait_Fumbler = {
		Description = "Fumbler",
		Buff = false,
	},
	Trait_Asthmatic = {
		Description = "Asthmatic",
		Buff = false,
	},
	Trait_Claustrophobic = {
		Description = "Claustrophobic",
		Buff = false,
	},
	Trait_Clumsy = {
		Description = "Clumsy",
		Buff = false,
	},
	Trait_Conspicuous = {
		Description = "Painfully Obvious",
		Buff = false,
	},
	Trait_HeartyAppetite = {
		Description = "Hearty Appetite",
		Buff = false,
	},
	Trait_Dry = {
		Description = "Dry Skin",
		Buff = false,
	},
	Trait_Hemophobic = {
		Description = "Hemophobic",
		Buff = false,
	},
	Trait_Dyslexia = {
		Description = "Dyslexia",
		Buff = false,
	},
	Trait_RestlessSleeper = {
		Description = "Restless Sleeper",
		Buff = false,
	},
	Trait_Smoker = {
		Description = "Smoker",
		Buff = false,
	},
	Trait_SlowHealer = {
		Description = "Slow Healer",
		Buff = false,
	},
	Trait_SlowLearner = {
		Description = "Slow Learner",
		Buff = false,
	},
	Trait_Hemophilia = {
		Description = "Hemophilia",
		Buff = false,
	},
	Trait_Unlucky = {
		Description = "Unlucky",
		Buff = false,
	},
	Trait_WeakBladder = {
		Description = "Weak Bladder",
		Buff = false,
	},
	Trait_Cannibal = {
		Description = "Forbidden Diet",
		Buff = false,
	},
}

-- Static Classes --
--------------------
local Actor_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassActor()
    if not Actor_Class:IsValid() then
        Actor_Class = StaticFindObject("/Script/Engine.Actor")
        ---@cast Actor_Class UClass
    end
    return Actor_Class
end

local SkeletalMeshActor_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassSkeletalMeshActor()
    if not SkeletalMeshActor_Class or not SkeletalMeshActor_Class:IsValid() then
        SkeletalMeshActor_Class = StaticFindObject("/Script/Engine.SkeletalMeshActor")
        ---@cast SkeletalMeshActor_Class UClass
    end
    return SkeletalMeshActor_Class
end

local AbioticGameViewportClientClass = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassAbioticGameViewportClient()
    if not AbioticGameViewportClientClass or not AbioticGameViewportClientClass:IsValid() then
        AbioticGameViewportClientClass = StaticFindObject("/Script/AbioticFactor.AbioticGameViewportClient")
        ---@cast AbioticGameViewportClientClass UClass
    end
    return AbioticGameViewportClientClass
end

local Abiotic_Survival_GameState_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassAbiotic_Survival_GameState_C()
    if not Abiotic_Survival_GameState_C_Class or not Abiotic_Survival_GameState_C_Class:IsValid() then
        Abiotic_Survival_GameState_C_Class = StaticFindObject("/Game/Blueprints/Meta/Abiotic_Survival_GameState.Abiotic_Survival_GameState_C")
        ---@cast Abiotic_Survival_GameState_C_Class UClass
    end
    return Abiotic_Survival_GameState_C_Class
end

local Abiotic_Survival_GameMode_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassAbiotic_Survival_GameMode_C()
    if not Abiotic_Survival_GameMode_C_Class or not Abiotic_Survival_GameMode_C_Class:IsValid() then
        Abiotic_Survival_GameMode_C_Class = StaticFindObject("/Game/Blueprints/Meta/Abiotic_Survival_GameMode.Abiotic_Survival_GameMode_C")
        ---@cast Abiotic_Survival_GameMode_C_Class UClass
    end
    return Abiotic_Survival_GameMode_C_Class
end

local Abiotic_GameInstance_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassAbiotic_GameInstance_C()
    if not Abiotic_GameInstance_C_Class or not Abiotic_GameInstance_C_Class:IsValid() then
        Abiotic_GameInstance_C_Class = StaticFindObject("/Game/Blueprints/Meta/Abiotic_GameInstance.Abiotic_GameInstance_C")
        ---@cast Abiotic_GameInstance_C_Class UClass
    end
    return Abiotic_GameInstance_C_Class
end

local Abiotic_PlayerController_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassAbiotic_PlayerController_C()
    if IsNotValid(Abiotic_PlayerController_C_Class) then
        Abiotic_PlayerController_C_Class = StaticFindObject("/Game/Blueprints/Meta/Abiotic_PlayerController.Abiotic_PlayerController_C")
        ---@cast Abiotic_PlayerController_C_Class UClass
    end
    return Abiotic_PlayerController_C_Class
end

local Abiotic_PlayerCharacter_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassAbiotic_PlayerCharacter_C()
    if not Abiotic_PlayerCharacter_C_Class or not Abiotic_PlayerCharacter_C_Class:IsValid() then
        Abiotic_PlayerCharacter_C_Class = StaticFindObject("/Game/Blueprints/Characters/Abiotic_PlayerCharacter.Abiotic_PlayerCharacter_C")
        ---@cast Abiotic_PlayerCharacter_C_Class UClass
    end
    return Abiotic_PlayerCharacter_C_Class
end

local Abiotic_Item_ParentBP_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassAbiotic_Item_ParentBP_C()
    if not Abiotic_Item_ParentBP_C_Class or not Abiotic_Item_ParentBP_C_Class:IsValid() then
        Abiotic_Item_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/Items/Abiotic_Item_ParentBP.Abiotic_Item_ParentBP_C")
        ---@cast Abiotic_Item_ParentBP_C_Class UClass
    end
    return Abiotic_Item_ParentBP_C_Class
end

local AbioticDeployed_ParentBP_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassAbioticDeployed_ParentBP_C()
    if not AbioticDeployed_ParentBP_C_Class or not AbioticDeployed_ParentBP_C_Class:IsValid() then
        AbioticDeployed_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/DeployedObjects/AbioticDeployed_ParentBP.AbioticDeployed_ParentBP_C")
        ---@cast AbioticDeployed_ParentBP_C_Class UClass
    end
    return AbioticDeployed_ParentBP_C_Class
end

local RechargeableComponent_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassRechargeableComponent_C()
    if not RechargeableComponent_C_Class or not RechargeableComponent_C_Class:IsValid() then
        RechargeableComponent_C_Class = StaticFindObject("/Game/Blueprints/Items/RechargeableComponent.RechargeableComponent_C")
        ---@cast RechargeableComponent_C_Class UClass
    end
    return RechargeableComponent_C_Class
end

local Deployed_Battery_ParentBP_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassDeployed_Battery_ParentBP_C()
    if not Deployed_Battery_ParentBP_C_Class or not Deployed_Battery_ParentBP_C_Class:IsValid() then
        Deployed_Battery_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/DeployedObjects/Misc/Deployed_Battery_ParentBP.Deployed_Battery_ParentBP_C")
        ---@cast Deployed_Battery_ParentBP_C_Class UClass
    end
    return Deployed_Battery_ParentBP_C_Class
end

local Abiotic_Item_Dropped_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassAbiotic_Item_Dropped_C()
    if not Abiotic_Item_Dropped_C_Class or not Abiotic_Item_Dropped_C_Class:IsValid() then
        Abiotic_Item_Dropped_C_Class = StaticFindObject("/Game/Blueprints/Items/Abiotic_Item_Dropped.Abiotic_Item_Dropped_C")
        ---@cast Abiotic_Item_Dropped_C_Class UClass
    end
    return Abiotic_Item_Dropped_C_Class
end

local Abiotic_Weapon_ParentBP_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassAbiotic_Weapon_ParentBP_C()
    if not Abiotic_Weapon_ParentBP_C_Class or not Abiotic_Weapon_ParentBP_C_Class:IsValid() then
        Abiotic_Weapon_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/Items/Weapons/Abiotic_Weapon_ParentBP.Abiotic_Weapon_ParentBP_C")
        ---@cast Abiotic_Weapon_ParentBP_C_Class UClass
    end
    return Abiotic_Weapon_ParentBP_C_Class
end

local Abiotic_Character_ParentBP_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassAbiotic_Character_ParentBP_C()
    if not Abiotic_Character_ParentBP_C_Class or not Abiotic_Character_ParentBP_C_Class:IsValid() then
        Abiotic_Character_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/Characters/Abiotic_Character_ParentBP.Abiotic_Character_ParentBP_C")
        ---@cast Abiotic_Character_ParentBP_C_Class UClass
    end
    return Abiotic_Character_ParentBP_C_Class
end

local NarrativeNPC_ParentBP_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassNarrativeNPC_ParentBP_C()
    if not NarrativeNPC_ParentBP_C_Class or not NarrativeNPC_ParentBP_C_Class:IsValid() then
        NarrativeNPC_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/Characters/NarrativeNPCs/NarrativeNPC_ParentBP.NarrativeNPC_ParentBP_C")
        ---@cast NarrativeNPC_ParentBP_C_Class UClass
    end
    return NarrativeNPC_ParentBP_C_Class
end

local CharacterCorpse_Human_BP_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassCharacterCorpse_Human_BP_C()
    if not CharacterCorpse_Human_BP_C_Class or not CharacterCorpse_Human_BP_C_Class:IsValid() then
        CharacterCorpse_Human_BP_C_Class = StaticFindObject("/Game/Blueprints/Environment/Special/CharacterCorpse_Human_BP.CharacterCorpse_Human_BP_C")
        ---@cast CharacterCorpse_Human_BP_C_Class UClass
    end
    return CharacterCorpse_Human_BP_C_Class
end

local NarrativeNPC_Human_ParentBP_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassNarrativeNPC_Human_ParentBP_C()
    if not NarrativeNPC_Human_ParentBP_C_Class or not NarrativeNPC_Human_ParentBP_C_Class:IsValid() then
        NarrativeNPC_Human_ParentBP_C_Class = StaticFindObject("/Game/Blueprints/Characters/NarrativeNPCs/NarrativeNPC_Human_ParentBP.NarrativeNPC_Human_ParentBP_C")
        ---@cast NarrativeNPC_Human_ParentBP_C_Class UClass
    end
    return NarrativeNPC_Human_ParentBP_C_Class
end

local CharacterCorpse_ParentBP_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassCharacterCorpse_ParentBP()
    if not CharacterCorpse_ParentBP_Class or not CharacterCorpse_ParentBP_Class:IsValid() then
        CharacterCorpse_ParentBP_Class = StaticFindObject("/Game/Blueprints/Environment/Special/CharacterCorpse_ParentBP.CharacterCorpse_ParentBP_C")
        ---@cast CharacterCorpse_ParentBP_Class UClass
    end
    return CharacterCorpse_ParentBP_Class
end

local Deployed_Toilet_Portal_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassDeployed_Toilet_Portal_C()
    if not Deployed_Toilet_Portal_C_Class or not Deployed_Toilet_Portal_C_Class:IsValid() then
        Deployed_Toilet_Portal_C_Class = StaticFindObject("/Game/Blueprints/DeployedObjects/Furniture/Deployed_Toilet_Portal.Deployed_Toilet_Portal_C")
        ---@cast Deployed_Toilet_Portal_C_Class UClass
    end
    return Deployed_Toilet_Portal_C_Class
end

local Item_Gear_KeypadHacker_C_Class = CreateInvalidObject()
---@return UClass
function AFUtils.GetClassItem_Gear_KeypadHacker_C()
    if not Item_Gear_KeypadHacker_C_Class or not Item_Gear_KeypadHacker_C_Class:IsValid() then
        Item_Gear_KeypadHacker_C_Class = StaticFindObject("/Game/Blueprints/Items/Gear/Item_Gear_KeypadHacker.Item_Gear_KeypadHacker_C")
        ---@cast Item_Gear_KeypadHacker_C_Class UClass
    end
    return Item_Gear_KeypadHacker_C_Class
end

---- Default objects ---
------------------------

local AbioticFunctionLibraryCache = CreateInvalidObject() ---@cast AbioticFunctionLibraryCache UAbioticFunctionLibrary_C
---@return UAbioticFunctionLibrary_C
function AFUtils.GetAbioticFunctionLibrary()
    if not AbioticFunctionLibraryCache or not AbioticFunctionLibraryCache:IsValid() then
        AbioticFunctionLibraryCache = StaticFindObject("/Game/Blueprints/Libraries/AbioticFunctionLibrary.Default__AbioticFunctionLibrary_C")
        ---@cast AbioticFunctionLibraryCache UAbioticFunctionLibrary_C
    end
    return AbioticFunctionLibraryCache
end

local LevelStreamingCustomCache = CreateInvalidObject() ---@cast LevelStreamingCustomCache ULevelStreamingCustom
---@return ULevelStreamingCustom
function AFUtils.GetLevelStreamingCustom()
    if not LevelStreamingCustomCache:IsValid() then
        LevelStreamingCustomCache = StaticFindObject("/Script/AbioticFactor.Default__LevelStreamingCustom")
        ---@cast LevelStreamingCustomCache ULevelStreamingCustom
    end
    return LevelStreamingCustomCache
end


local WeatherEventHandleFunctionLibraryCache = CreateInvalidObject() ---@cast WeatherEventHandleFunctionLibraryCache UWeatherEventHandleFunctionLibrary
---@return UWeatherEventHandleFunctionLibrary
function AFUtils.GetWeatherEventHandleFunctionLibrary()
    if not WeatherEventHandleFunctionLibraryCache:IsValid() then
        WeatherEventHandleFunctionLibraryCache = StaticFindObject("/Script/AbioticFactor.Default__WeatherEventHandleFunctionLibrary")
        ---@cast WeatherEventHandleFunctionLibraryCache UWeatherEventHandleFunctionLibrary
    end
    return WeatherEventHandleFunctionLibraryCache
end

-- Exported functions --
------------------------

local IsDedicatedServerCache = nil
---Returns true if code is running on a Dedicated Server<br>
---The function uses a cache!
---@param UpdateCache boolean?
---@return boolean
function AFUtils.IsDedicatedServer(UpdateCache)
    if IsDedicatedServerCache == nil or UpdateCache then
        IsDedicatedServerCache = IsDedicatedServer()
    end
    return IsDedicatedServerCache
end

---Returns current AAbiotic_PlayerController_C
---@return AAbiotic_PlayerController_C
function AFUtils.GetMyPlayerController()
    local myPlayerController = UEHelpers.GetPlayerController() ---@cast myPlayerController AAbiotic_PlayerController_C
    if IsValid(myPlayerController) and myPlayerController:IsA(AFUtils.GetClassAbiotic_PlayerController_C()) then
        return myPlayerController
    end
    return CreateInvalidObject() ---@type AAbiotic_PlayerController_C
end

---Returns player's AAbiotic_PlayerController_C
---@param PlayerCharacter AAbiotic_PlayerCharacter_C
---@return AAbiotic_PlayerController_C
function AFUtils.GetPlayerController(PlayerCharacter)
    if IsValid(PlayerCharacter) and PlayerCharacter.MyPlayerController then
        return PlayerCharacter.MyPlayerController
    end
    return CreateInvalidObject() ---@type AAbiotic_PlayerController_C
end

---Returns current controlled player
---@return AAbiotic_PlayerCharacter_C
function AFUtils.GetMyPlayer()
    local player = UEHelpers.GetPlayer() ---@cast player AAbiotic_PlayerCharacter_C
    if IsValid(player) and player:IsA(AFUtils.GetClassAbiotic_PlayerCharacter_C()) then
        return player
    end
    return CreateInvalidObject() ---@type AAbiotic_PlayerCharacter_C
end

local PlayerStateCache = CreateInvalidObject() ---@cast PlayerStateCache AAbiotic_PlayerState_C
---Returns player state of current player
---@return AAbiotic_PlayerState_C
function AFUtils.GetMyPlayerState()
    if PlayerStateCache and PlayerStateCache:IsValid() then
        return PlayerStateCache
    end

    local myPlayer = AFUtils.GetMyPlayer()
    if myPlayer:IsValid() then
        PlayerStateCache = myPlayer.MyPlayerState
    end

    return PlayerStateCache
end

---Returns current player's inventory
---@return UAbiotic_InventoryComponent_C
function AFUtils.GetMyInventoryComponent()
    local myPlayer = AFUtils.GetMyPlayer()
    if myPlayer:IsValid() and myPlayer.CharacterInventory then
        return myPlayer.CharacterInventory
    end
    return CreateInvalidObject() ---@type UAbiotic_InventoryComponent_C
end

---Returns current player's equipment inventory
---@return UAbiotic_InventoryComponent_C
function AFUtils.GetMyEquipmentInventory()
    local myPlayer = AFUtils.GetMyPlayer()
    if myPlayer:IsValid() and myPlayer.CharacterEquipSlotInventory then
        return myPlayer.CharacterEquipSlotInventory
    end
    return CreateInvalidObject() ---@type UAbiotic_InventoryComponent_C
end

---Returns current player's hotbar inventory
---@return UAbiotic_InventoryComponent_C
function AFUtils.GetMyHotbarInventory()
    local myPlayer = AFUtils.GetMyPlayer()
    if myPlayer:IsValid() and myPlayer.CharacterHotbarInventory then
        return myPlayer.CharacterHotbarInventory
    end
    return CreateInvalidObject() ---@type UAbiotic_InventoryComponent_C
end

---Returns current player inventory widget
---@return UW_PlayerInventory_Main_C
function AFUtils.GetMyPlayerInventory()
    local myPlayer = AFUtils.GetMyPlayer()
    if myPlayer:IsValid() and myPlayer.InventoryReference then
        return myPlayer.InventoryReference
    end
    return CreateInvalidObject() ---@type UW_PlayerInventory_Main_C
end

---Returns current crafting area
---@return UW_Inventory_CraftingArea_C
function AFUtils.GetMyInventoryCraftingArea()
    local myPlayerInventory = AFUtils.GetMyPlayerInventory()
    if myPlayerInventory:IsValid() and myPlayerInventory.W_Inventory_CraftingArea then
        return myPlayerInventory.W_Inventory_CraftingArea
    end
    return CreateInvalidObject() ---@type UW_Inventory_CraftingArea_C
end


---Returns player's CharacterProgressionComponent
---@return UAbiotic_CharacterProgressionComponent_C
function AFUtils.GetMyCharacterProgressionComponent()
    local myPlayer = AFUtils.GetMyPlayer()
    if myPlayer:IsValid() and myPlayer.CharacterProgressionComponent then
        return myPlayer.CharacterProgressionComponent
    end

    return CreateInvalidObject() ---@type UAbiotic_CharacterProgressionComponent_C
end

---Returns PlayerHUD
---@return UW_PlayerHUD_Main_C
function AFUtils.GetMyPlayerHUD()
    local playerController = AFUtils.GetMyPlayerController()
    if playerController:IsValid() and playerController.PlayerHUDRef then
        return playerController.PlayerHUDRef
    end
    return CreateInvalidObject() ---@type UW_PlayerHUD_Main_C
end

 ---@return UAbiotic_GameInstance_C
 function AFUtils.GetGameInstance()
    local gameInstance = UEHelpers.GetGameInstance() ---@cast gameInstance UAbiotic_GameInstance_C
    if gameInstance:IsValid() and gameInstance:IsA(AFUtils.GetClassAbiotic_GameInstance_C()) then
        return gameInstance
    end
    return CreateInvalidObject() ---@type UAbiotic_GameInstance_C
 end

---Returns current AAbiotic_Survival_GameMode_C
---@return AAbiotic_Survival_GameMode_C
function AFUtils.GetSurvivalGameMode()
    local gameMode = UEHelpers.GetGameModeBase() ---@cast gameMode AAbiotic_Survival_GameMode_C
    if gameMode:IsValid() and gameMode:IsA(AFUtils.GetClassAbiotic_Survival_GameMode_C()) then
        return gameMode
    end
    return CreateInvalidObject() ---@type AAbiotic_Survival_GameMode_C
end

---Returns current AAbiotic_Survival_GameMode_C
---@return AAbiotic_Survival_GameState_C
function AFUtils.GetSurvivalGameState()
    local gameState = UEHelpers.GetGameStateBase() ---@cast gameState AAbiotic_Survival_GameState_C
    if gameState:IsValid() and gameState:IsA(AFUtils.GetClassAbiotic_Survival_GameState_C()) then
        return gameState
    end
    return CreateInvalidObject() ---@type AAbiotic_Survival_GameState_C
end

local AIDirectorCache = CreateInvalidObject() ---@cast AIDirectorCache AAbiotic_AIDirector_C
---Returns current AAbiotic_AIDirector_C
---@return AAbiotic_AIDirector_C
function AFUtils.GetAIDirector()
    if AIDirectorCache:IsValid() then
        return AIDirectorCache
    end

    local gameMode = AFUtils.GetSurvivalGameMode()
    if gameMode:IsValid() and gameMode.AI_Director then
        AIDirectorCache = gameMode.AI_Director
    end
    
    return AIDirectorCache
end

local DayNightManagerCache = CreateInvalidObject() ---@cast DayNightManagerCache ADayNightManager_C
---Retruns current ADayNightManager_C
---@return ADayNightManager_C
function AFUtils.GetDayNightManager()
    local aiDirector = AFUtils.GetAIDirector()
    if aiDirector:IsValid() and aiDirector.DayNightManager then
        DayNightManagerCache = aiDirector.DayNightManager
    end
    return DayNightManagerCache
end

local AIControllerLeyakCache = CreateInvalidObject() ---@cast AIControllerLeyakCache AAI_Controller_Leyak_C
---Returns current AAI_Controller_Leyak_C
---@return AAI_Controller_Leyak_C
function AFUtils.GetAIControllerLeyak()
    if AIControllerLeyakCache:IsValid() then
        return AIControllerLeyakCache
    end
    
    AIControllerLeyakCache = FindFirstOf("AI_Controller_Leyak_C") ---@cast AIControllerLeyakCache AAI_Controller_Leyak_C
    return AIControllerLeyakCache
end

---Gets Control Rotation
---@return FRotator
function AFUtils.GetControlRotation()
    local playerController = AFUtils.GetMyPlayerController()
    if playerController:IsValid() then
        return RotatorToUserdata(playerController.ControlRotation)
    end
    return FRotator()
end

---Force client control rotation
---@param Rotation FRotator
---@return boolean Success # false if no valid PlayerController
function AFUtils.SetControlRotation(Rotation)
    local playerController = AFUtils.GetMyPlayerController()
    if playerController:IsValid() then
        playerController:SetControlRotation(Rotation)
        return true
    end
    return false
end

---Search for player state by UniquePlayerId
---@param PlayerId FString|string
---@return AAbiotic_PlayerState_C
function AFUtils.GetPlayerStateById(PlayerId)
    if type(PlayerId) == "userdata" and PlayerId:type() == "FString" then
        PlayerId = PlayerId:ToString()
    end
    if type(PlayerId) == "string" and PlayerId ~= "" then
        local gameState = AFUtils.GetSurvivalGameState()
        if IsValid(gameState) and gameState.PlayerArray then
            for i = 1, #gameState.PlayerArray do
                local playerState = gameState.PlayerArray[i] ---@cast playerState AAbiotic_PlayerState_C
                if playerState.UniquePlayerID and playerState.UniquePlayerID:ToString() == PlayerId then
                    return playerState
                end
            end
        end
    end
    return CreateInvalidObject() ---@type AAbiotic_PlayerState_C
end

---Search for player by UniquePlayerId
---@param PlayerId FString|string
---@return AAbiotic_PlayerCharacter_C
function AFUtils.GetPlayerById(PlayerId)
    local playerState = AFUtils.GetPlayerStateById(PlayerId)
    if IsValid(playerState) and playerState.PawnPrivate then
        return playerState.PawnPrivate ---@type AAbiotic_PlayerCharacter_C
    end
    return CreateInvalidObject() ---@type AAbiotic_PlayerCharacter_C
end

---Returns struct that represents current selected slot in the hotbat aka. held item
---@param PlayerCharacter AAbiotic_PlayerCharacter_C
---@return FInventorySlotSelected_Struct?
function AFUtils.GetCurrentHotbarSlotSelected(PlayerCharacter)
    if IsValid(PlayerCharacter) and PlayerCharacter.CurrentHotbarSlotSelected:IsValid() then
        return PlayerCharacter.CurrentHotbarSlotSelected
    end
    return nil
end

---Retruns struct that represents the current selected Hotbar item slot, it's inventory component and SlotIndex. The item can be modified through ChangeableData.
---@param PlayerCharacter AAbiotic_PlayerCharacter_C
---@return FAbiotic_InventoryItemSlotStruct? # Can be used to modify item's data though ChangeableData
---@return UAbiotic_InventoryComponent_C? # Parent InventoryComponent
---@return integer? # Slot index
function AFUtils.GetSelectedHotbarInventoryItemSlot(PlayerCharacter)
    local slotData = AFUtils.GetCurrentHotbarSlotSelected(PlayerCharacter)
    if slotData and slotData.Inventory_2_B69CD60741EFD551F09ED5AFF44B1E46:IsValid() then
        local inventory = slotData.Inventory_2_B69CD60741EFD551F09ED5AFF44B1E46
        local luaIndex = slotData.Index_5_6BDC7B3944A5DE0B319F9FA20720872F + 1
        if inventory.CurrentInventory and #inventory.CurrentInventory >= luaIndex then
            return inventory.CurrentInventory[luaIndex], inventory, slotData.Index_5_6BDC7B3944A5DE0B319F9FA20720872F
        end
    end
    return nil, nil, nil
end

---Get current held weapon for a player
---@param PlayerCharacter AAbiotic_PlayerCharacter_C #If nil, will use the local player
---@return AAbiotic_Weapon_ParentBP_C?
function AFUtils.GetCurrentWeapon(PlayerCharacter)
    PlayerCharacter = PlayerCharacter or AFUtils.GetMyPlayer()
    if PlayerCharacter:IsValid() and PlayerCharacter.ItemInHand_BP:IsValid() and PlayerCharacter.ItemInHand_BP:IsA(AFUtils.GetClassAbiotic_Weapon_ParentBP_C()) then
        local weapon = PlayerCharacter.ItemInHand_BP ---@cast weapon AAbiotic_Weapon_ParentBP_C
        return weapon
    end
    return nil
end

---@param PlayerCharacter AAbiotic_PlayerCharacter_C? # In nil, using MyPlayer
---@return boolean
function AFUtils.IsHoldingKeypadHacker(PlayerCharacter)
    PlayerCharacter = PlayerCharacter or AFUtils.GetMyPlayer()
    return IsValid(PlayerCharacter) and IsValid(PlayerCharacter.ItemInHand_BP) and PlayerCharacter.ItemInHand_BP:IsA(AFUtils.GetClassItem_Gear_KeypadHacker_C())
end

---Prints a colored message to local player's chat (only visible to the player)
---@param Message string Message that should be shown in chat
---@param Prefix string?
---@param Color FLinearColor? If nil, defaults to white
function AFUtils.DisplayTextChatMessage(Message, Prefix, Color)
    if not Message then return end

    local myPlayerController = AFUtils.GetMyPlayerController()
    if myPlayerController:IsValid() then
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
    if myPlayer:IsValid() then
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
    if not playerCharacter or not playerCharacter.CharacterEquipSlotInventory:IsValid() or #playerCharacter.CharacterEquipSlotInventory.CurrentInventory < 12 then
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
    local trinket2SlotStruct = itemSlotStructs[AFUtils.GearInventoryIndex.Trinket2]

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
    AFUtils.FillItemSlotStructEnergyFromItem(trinket2SlotStruct, playerCharacter.Gear_Trinket2_BP)
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
---@param weapon AAbiotic_Weapon_ParentBP_C? Must be a valid object
---@return boolean Filled # Returns true if ammo was modified, otherwise false
function AFUtils.FillHeldWeaponWithAmmo(playerCharacter, weapon)
    if not playerCharacter or not playerCharacter.ItemInHand_BP then return false end

    weapon = weapon or AFUtils.GetCurrentWeapon(playerCharacter)
    if not weapon or not weapon:IsValid() then return false end

    local weaponData = weapon.ItemData.WeaponData_61_3C29CF6C4A7F9DD435F9318FEE4B033D
    if not weaponData.RequireAmmo_85_8BB1C1954D2A83BB1994549DDEEBA306 then return false end

    local itemSlotStruct, inventory, slotIndex = AFUtils.GetSelectedHotbarInventoryItemSlot(playerCharacter)
    if itemSlotStruct and inventory and slotIndex then
        if AFUtils.FillItemSlotStructAmmoFromItem(itemSlotStruct, weapon) then
            weapon.CurrentRoundsInMagazine = itemSlotStruct.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313.CurrentAmmoInMagazine_12_D68C190F4B2FA78A4B1D57835B95C53D
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
    if weatherEventHandleFunctionLibrary and myPlayerController:IsValid() and myPlayerController.DayNightManager:IsValid() then
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
    if myPlayerController:IsValid() and myPlayerController.DayNightManager:IsValid() then
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
    if IsNotValid(InventoryItemSlot) then return nil, 0 end

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
    if IsNotValid(Inventory) or not SlotIndex or not StackToAdd then return false end

    local myPlayerController = AFUtils.GetMyPlayerController()
    if myPlayerController:IsValid() then
        myPlayerController:Server_AddToItemStack(Inventory, SlotIndex, StackToAdd)
        return true
    end

    return false
end

---@param TargetItemSlot FAbiotic_InventoryItemSlotStruct
---@param DataTableRowName FName
---@param ItemsCount integer
---@return boolean
function AFUtils.SetItemSlot(TargetItemSlot, DataTableRowName, ItemsCount)
    if not TargetItemSlot or not TargetItemSlot.ItemDataTable_18_BF1052F141F66A976F4844AB2B13062B then return false end

    TargetItemSlot.ItemDataTable_18_BF1052F141F66A976F4844AB2B13062B.RowName = DataTableRowName
    TargetItemSlot.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313.CurrentItemDurability_4_24B4D0E64E496B43FB8D3CA2B9D161C8 = 100
    TargetItemSlot.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313.MaxItemDurability_6_F5D5F0D64D4D6050CCCDE4869785012B = 100
    TargetItemSlot.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313.CurrentStack_9_D443B69044D640B0989FD8A629801A49 = ItemsCount

    return true
end

---@param DayNightManager ADayNightManager_C?
---@return boolean Success
function AFUtils.CalculateAndSetDaytime(DayNightManager)
    DayNightManager = DayNightManager or AFUtils.GetDayNightManager()
    if not DayNightManager:IsValid() then return false end

    local currentTime = DayNightManager.CurrentTimeInSeconds
    local isDay = currentTime < HoursToSeconds(DayNightManager.NightfallStartHour) and currentTime >= HoursToSeconds(DayNightManager.MorningStartHour)
    if DayNightManager.IsNight == isDay then
        DayNightManager.IsNight = not isDay
        DayNightManager:OnRep_IsNight()
    end
    return true
end 

---Set in game time
---@param Hours integer? # Default: 0
---@param Minutes integer? # Default: 0
function AFUtils.SetGameTime(Hours, Minutes)
    Hours = Hours or 0.0
    Minutes = Minutes or 0.0

    local dayNightManager = AFUtils.GetDayNightManager()
    if dayNightManager:IsValid() then
        local targetTime = HoursToSeconds(Hours) + MinutesToSeconds(Minutes) + 10
        dayNightManager.CurrentTimeInSeconds = targetTime
        dayNightManager:OnRep_CurrentTimeInSeconds()
        if dayNightManager.CurrentTimeInSeconds == targetTime then
            return AFUtils.CalculateAndSetDaytime(dayNightManager)
        end
    end
    return false
end

---Add hours and minutes to current game time
---@param Hours integer
---@param Minutes integer? # Default: 0
function AFUtils.AddGameTime(Hours, Minutes)
    Minutes = Minutes or 0.0

    local dayNightManager = AFUtils.GetDayNightManager()
    if dayNightManager:IsValid() then
        local targetTime = dayNightManager.CurrentTimeInSeconds + HoursToSeconds(Hours) + MinutesToSeconds(Minutes)
        dayNightManager.CurrentTimeInSeconds = targetTime
        dayNightManager:OnRep_CurrentTimeInSeconds()
        if dayNightManager.CurrentTimeInSeconds == targetTime then
            return AFUtils.CalculateAndSetDaytime(dayNightManager)
        end
    end
    return false
end

---@param LeyakContainment ADeployed_LeyakContainment_C
---@return boolean Success
function AFUtils.TrapLeyak(LeyakContainment)
    if IsNotValid(LeyakContainment) or LeyakContainment.DeployableDestroyed or LeyakContainment.ContainsLeyak then return false end

    local gameState = AFUtils.GetSurvivalGameState()
    if IsValid(gameState) then
        local assetId = LeyakContainment.SpawnedAssetID:ToString()
        LogDebug("TrapLeyak: SpawnedAssetID:", assetId)
        LeyakContainment:ServerUpdateStabilityLevel(LeyakContainment.MaxStability)
        LeyakContainment:TrapLeyak(0.0)
        gameState['Set Leyak Containment ID'](assetId)
        LogDebug("TrapLeyak: ActiveLeyakContainmentID:", gameState.ActiveLeyakContainmentID:ToString())
        LogDebug("TrapLeyak: ContainsLeyak:", LeyakContainment.ContainsLeyak)
        return gameState.ActiveLeyakContainmentID:ToString() == assetId
    end
    return false
end

---@param LeyakContainment ADeployed_LeyakContainment_C
---@return boolean Success
function AFUtils.FreeLeyak(LeyakContainment)
    if IsNotValid(LeyakContainment) or LeyakContainment.DeployableDestroyed or not LeyakContainment.ContainsLeyak then return false end

    local gameState = AFUtils.GetSurvivalGameState()
    if IsValid(gameState) then
        LeyakContainment['Free Leyak']()
        gameState['Set Leyak Containment ID']("")
        return gameState.ActiveLeyakContainmentID:ToString() == ""
    end
    return false
end

return AFUtils
