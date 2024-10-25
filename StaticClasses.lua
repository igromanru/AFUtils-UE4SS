--[[
    Author: Igromanru
    Created Date: 19.08.2024
    Description: Utility functions for the game Abiotic Factor
]]

require("AFUtils.AFBase")

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

return AFUtils