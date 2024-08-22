
local AFUtils = require("AFUtils.AFUtils")

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
    -- LogDebug(Prefix .. "ToInteractWith_Text: " .. InventoryItemStruct.ToInteractWith_Text_66_C2148289464D5AAA4D19BBA13F15FE41:ToString())
    -- LogDebug(Prefix .. "ToLongInteractWith_Text: " .. InventoryItemStruct.ToLongInteractWith_Text_68_4FBE88F341B6A020E3216CA026A1E4E8:ToString())
    -- LogDebug(Prefix .. "ToPackage_Text: " .. InventoryItemStruct.ToPackage_Text_71_5094104748FCB4BD2F90C99A2C4C49A8:ToString())
    -- LogDebug(Prefix .. "ToLongPackage_Text: " .. InventoryItemStruct.ToLongPackage_Text_72_CB77853E49960F43E6422C90DC967508:ToString())
    -- LogDebug(Prefix .. "Scale_WorldMesh: " .. InventoryItemStruct.Scale_WorldMesh_143_AF66D856410026FCC19E70AC421B3667)
    -- LogDebug(Prefix .. "Scale_FirstPersonMesh: " .. InventoryItemStruct.Scale_FirstPersonMesh_146_6AFCDB94484AE7625E73C6AFB835D21F)
    -- LogDebug(Prefix .. "Scale_TPHeldMesh: " .. InventoryItemStruct.Scale_TPHeldMesh_145_6826D00A4F30AEDBF62E02892E4261E6)
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

    LogDebug(Prefix .. "LightSourceType enum: " .. RechargeableComponent.LightSourceType)
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

---Logs in debug scope all relevant properties of a AAbiotic_Item_ParentBP_C to console 
---@param Item AAbiotic_Item_ParentBP_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogItemParentBP(Item, Prefix)
    if not Item then return end
    Prefix = Prefix or ""

    LogDebug(Prefix .. "ItemDataRow.RowName: " .. Item.ItemDataRow.RowName:ToString())
    AFUtils.LogInventoryItemStruct(Item.ItemData, Prefix .. "ItemData.")
    AFUtils.LogInventoryChangeableDataStruct(Item.ChangeableData, Prefix .. "ChangeableData.")
    LogDebug(Prefix .. "HasBeenPickedUp: " .. tostring(Item.HasBeenPickedUp))
    LogDebug(Prefix .. "To Interact with Text: " .. Item["To Interact with Text"]:ToString())
    LogDebug(Prefix .. "NoPhysics: " .. tostring(Item.NoPhysics))
    LogDebug(Prefix .. "NoCollision: " .. tostring(Item.NoCollision))
    -- LogDebug(Prefix .. "PopupAfterSpawned: " .. tostring(Item.PopupAfterSpawned))
    -- LogDebug(Prefix .. "ShouldSimulate: " .. tostring(Item.ShouldSimulate))
    -- LogDebug(Prefix .. "ProjectilePredict_BaseSpeed: " .. Item.ProjectilePredict_BaseSpeed)
    -- LogDebug(Prefix .. "ProjectilePredict_SpeedMultiplier: " .. Item.ProjectilePredict_SpeedMultiplier)
    -- LogDebug(Prefix .. "Bounciness: " .. Item.Bounciness)
    -- LogDebug(Prefix .. "Collision Radius: " .. Item["Collision Radius"])
    -- LogDebug(Prefix .. string.format("ProjectilePredict_Velocity: X: %f Y: %f Z: %f", Item.ProjectilePredict_Velocity.X, Item.ProjectilePredict_Velocity.Y, Item.ProjectilePredict_Velocity.Z))
    LogDebug(Prefix .. "ItemDecayInterval: " .. Item.ItemDecayInterval)
    -- LogDebug(Prefix .. "Should Bounce: " .. tostring(Item["Should Bounce"]))
    -- LogDebug(Prefix .. "SpawnedFromProjectileImpact: " .. tostring(Item.SpawnedFromProjectileImpact))
    -- local rechargeableComponent = GetBlueprintCreatedComponentByClass(Item, AFUtils.GetClassRechargeableComponent_C())
    -- if rechargeableComponent then
    --     AFUtils.LogRechargeableComponent(rechargeableComponent, Prefix .. "RechargeableComponent.")
    -- end
end

---Logs in debug scope all relevant properties of a UAbiotic_InventoryComponent_C to console 
---@param Inventory UAbiotic_InventoryComponent_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogInventoryComponent(Inventory, Prefix)
    if not Inventory then return end
    Prefix = Prefix or ""

    LogDebug(Prefix .. "CurrentInventory.Num: " .. #Inventory.CurrentInventory)
    for i = 1, #Inventory.CurrentInventory, 1 do
        local inventoryItemSlotStruct = Inventory.CurrentInventory[i]
        AFUtils.LogInventoryItemSlotStruct(inventoryItemSlotStruct, Prefix .. "CurrentInventory["..i.."].")
    end
    LogDebug(Prefix .. "MaxSlots: " .. Inventory.MaxSlots)
    LogDebug(Prefix .. "InventorySlotType enum: " .. Inventory.InventorySlotType)
    LogDebug(Prefix .. "DisplayName: " .. Inventory.DisplayName:ToString())
    LogDebug(Prefix .. "ContainerType enum: " .. Inventory.ContainerType)
    LogDebug(Prefix .. "SlotAppearance enum: " .. Inventory.SlotAppearance)
    -- LogDebug(Prefix .. "DestroyParentWhenEmpty: " .. tostring(Inventory.DestroyParentWhenEmpty))
    LogDebug(Prefix .. "EmptyItemRow.RowName: " .. Inventory.EmptyItemRow.RowName:ToString())
    LogDebug(Prefix .. "InitialInventorySize: " .. Inventory.InitialInventorySize)
    LogDebug(Prefix .. "CurrentTotalInventoryWeight: " .. Inventory.CurrentTotalInventoryWeight)
    LogDebug(Prefix .. "CraftingCheck: " .. tostring(Inventory.CraftingCheck))
    LogDebug(Prefix .. "ItemDecayInterval: " .. Inventory.ItemDecayInterval)
    LogDebug(Prefix .. "InternalTemperature enum: " .. Inventory.InternalTemperature)
    LogDebug(Prefix .. "AutoStartItemDecay: " .. tostring(Inventory.AutoStartItemDecay))
    LogDebug(Prefix .. "CurrentRadiation: " .. Inventory.CurrentRadiation)
    LogDebug(Prefix .. "RadioactiveShielding: " .. Inventory.RadioactiveShielding)
    LogDebug(Prefix .. "InventoryUpdateLocked: " .. tostring(Inventory.InventoryUpdateLocked))
end

---Logs in debug scope all relevant properties of a AAbiotic_AIDirector_C to console 
---@param AIDirector AAbiotic_AIDirector_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogAIDirector(AIDirector, Prefix)
    if not AIDirector then return end
    Prefix = Prefix or ""

    LogDebug(Prefix .. "CurrentFacilitySpawns: " .. tostring(AIDirector.CurrentFacilitySpawns))
    LogDebug(Prefix .. "ActiveNPCSpawns.Num: " .. #AIDirector.ActiveNPCSpawns)
    LogDebug(Prefix .. "DormantNPCSpawns.Num: " .. #AIDirector.DormantNPCSpawns)
    LogDebug(Prefix .. "DirectorDebugOn: " .. tostring(AIDirector.DirectorDebugOn))
    LogDebug(Prefix .. "DebugNoDayNightManager: " .. tostring(AIDirector.DebugNoDayNightManager))
    LogDebug(Prefix .. "NPCArray.Num: " .. #AIDirector.NPCArray)
    LogDebug(Prefix .. "NPCCap: " .. AIDirector.NPCCap)
    LogDebug(Prefix .. "Assault_CurrentPhase (enum 1-6): " .. AIDirector.Assault_CurrentPhase)
    -- ToDo Log Assault_CurrentData
    LogDebug(Prefix .. "Assault_TimeLastSpawnedNPC: " .. AIDirector.Assault_TimeLastSpawnedNPC)
    LogDebug(Prefix .. "Assault_BenchTargetLocation: " .. VectorToString(AIDirector.Assault_BenchTargetLocation))
    LogDebug(Prefix .. "Assault_PatrolTargetLocation: " .. VectorToString(AIDirector.Assault_PatrolTargetLocation))
    LogDebug(Prefix .. "Assault_CurrentRow: " .. AIDirector.Assault_CurrentRow:ToString())
    LogDebug(Prefix .. "Assault_CurrentSpawnIndex: " .. AIDirector.Assault_CurrentSpawnIndex)
    LogDebug(Prefix .. "Assault_TimeOfInitialWarning: " .. AIDirector.Assault_TimeOfInitialWarning)
    -- LogDebug(Prefix .. "Assault_PreviousSpawnIndex: " .. AIDirector.Assault_PreviousSpawnIndex)
    LogDebug(Prefix .. "TimeBeforeAssaults: " .. AIDirector.TimeBeforeAssaults)
    LogDebug(Prefix .. "LeyakCooldown: " .. AIDirector.LeyakCooldown)
    LogDebug(Prefix .. "ActiveLeyak IsValid: " .. tostring(AIDirector.ActiveLeyak:IsValid()))
    LogDebug(Prefix .. "CurrentLeyakTarget IsValid: " .. tostring(AIDirector.CurrentLeyakTarget:IsValid()))
    LogDebug(Prefix .. "LeyakSpawnAttempts: " .. AIDirector.LeyakSpawnAttempts)
    LogDebug(Prefix .. "TimeLastLeyakSpawn: " .. AIDirector.TimeLastLeyakSpawn)
    LogDebug(Prefix .. "MaxAssaultPortals: " .. AIDirector.MaxAssaultPortals)
    LogDebug(Prefix .. "LeyakViewCounter: " .. AIDirector.LeyakViewCounter)
    LogDebug(Prefix .. "CurrentAssaultPortals: " .. AIDirector.CurrentAssaultPortals)
    LogDebug(Prefix .. "LeyakTauntCooldownMultiplier: " .. AIDirector.LeyakTauntCooldownMultiplier)
    LogDebug(Prefix .. "DebugDisableNPCFreezing: " .. tostring(AIDirector.DebugDisableNPCFreezing))
end

---Logs in debug scope all relevant properties of a AAI_Controller_Leyak_C to console 
---@param AIControllerLeyak AAI_Controller_Leyak_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogAIControllerLeyak(AIControllerLeyak, Prefix)
    if not AIControllerLeyak then return end
    Prefix = Prefix or ""

    LogDebug(Prefix .. "ValidTargets.Num: " .. #AIControllerLeyak.ValidTargets)
    LogDebug(Prefix .. "SkipLeyakLevelCheck: " .. tostring(AIControllerLeyak.SkipLeyakLevelCheck))
    LogDebug(Prefix .. "MaxLeyakChaseDistance: " .. AIControllerLeyak.MaxLeyakChaseDistance)
    LogDebug(Prefix .. "LeyakAggroRange: " .. AIControllerLeyak.LeyakAggroRange)
    LogDebug(Prefix .. "WantsToDespawn: " .. tostring(AIControllerLeyak.WantsToDespawn))
    LogDebug(Prefix .. "MaxLeyakChaseDistance_Aggrod: " .. AIControllerLeyak.MaxLeyakChaseDistance_Aggrod)
end

---Logs in debug scope all relevant properties of a ANPC_Leyak_C to console 
---@param Leyak ANPC_Leyak_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogNPCLeyak(Leyak, Prefix)
    if not Leyak then return end
    Prefix = Prefix or ""

    LogDebug(Prefix .. "Timeline_Dissolve_NewTrack: " .. Leyak.Timeline_Dissolve_NewTrack_1_039C1F844D7D7D0E8CA9FEBA672ECF59)
    LogDebug(Prefix .. "Timeline_Dissolve__Direction (enum 1-2): " .. Leyak.Timeline_Dissolve__Direction_039C1F844D7D7D0E8CA9FEBA672ECF59)
    LogDebug(Prefix .. "RequiredMegalightDuration: " .. Leyak.RequiredMegalightDuration)
    LogDebug(Prefix .. "TargetPlayer IsValid: " .. tostring(Leyak.TargetPlayer:IsValid()))
    LogDebug(Prefix .. "HasBeenXrayed: " .. tostring(Leyak.HasBeenXrayed))
    LogDebug(Prefix .. "ViewedByTarget: " .. tostring(Leyak.ViewedByTarget))
    LogDebug(Prefix .. "CachedTimeSeen: " .. Leyak.CachedTimeSeen)
    LogDebug(Prefix .. "DistanceDifferenceToDespawn: " .. Leyak.DistanceDifferenceToDespawn)
    LogDebug(Prefix .. "SeenDespawnTime: " .. Leyak.SeenDespawnTime)
    LogDebug(Prefix .. "DealDamageInfront: " .. tostring(Leyak.DealDamageInfront))
    LogDebug(Prefix .. "StuckStartTime: " .. Leyak.StuckStartTime)
    LogDebug(Prefix .. "PotentiallyStuck: " .. tostring(Leyak.PotentiallyStuck))
    LogDebug(Prefix .. "AbsolutelyStuck: " .. tostring(Leyak.AbsolutelyStuck))
    LogDebug(Prefix .. "StuckStartTime: " .. Leyak.TimeAllowedToBeStuck)
end