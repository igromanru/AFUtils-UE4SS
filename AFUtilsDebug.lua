
local AFUtils = require("AFUtils.AFUtils")

---Logs in debug scope all relevant properties of FTimerHandle to console 
---@param WorldContext UObject
---@param TimerHandle FTimerHandle
---@param Prefix string?
function AFUtils.LogTimerHandle(WorldContext, TimerHandle, Prefix)
    if not WorldContext or not TimerHandle or not TimerHandle.Handle then return end
    Prefix = Prefix or ""

    local timerHandle = { Handle = TimerHandle.Handle }
    local isTimerValid = GetKismetSystemLibrary():K2_IsValidTimerHandle(timerHandle)
    LogDebug(Prefix, "IsValid: "..tostring(isTimerValid))
    if isTimerValid then
        LogDebug(Prefix, "TimerExists: "..tostring(GetKismetSystemLibrary():K2_TimerExistsHandle(WorldContext, timerHandle)))
        LogDebug(Prefix, "IsTimerActive: "..tostring(GetKismetSystemLibrary():K2_IsTimerActiveHandle(WorldContext, timerHandle)))
        LogDebug(Prefix, "IsTimerPaused: "..tostring(GetKismetSystemLibrary():K2_IsTimerPausedHandle(WorldContext, timerHandle)))
        LogDebug(Prefix, "Elapsed: "..GetKismetSystemLibrary():K2_GetTimerElapsedTimeHandle(WorldContext, timerHandle))
        LogDebug(Prefix, "TimerRemaining: "..GetKismetSystemLibrary():K2_GetTimerRemainingTimeHandle(WorldContext, timerHandle))
    end
end

---@param Timeline FTimeline
---@param Prefix string?
function AFUtils.LogTimeline(Timeline, Prefix)
    if not Timeline then return end
    Prefix = Prefix or ""

    LogDebug(Prefix, "LengthMode (enum 0-1): " .. Timeline.LengthMode)
    LogDebug(Prefix, "bLooping: " .. tostring(Timeline.bLooping))
    LogDebug(Prefix, "bReversePlayback: " .. tostring(Timeline.bReversePlayback))
    LogDebug(Prefix, "Length: " .. Timeline.Length)
    LogDebug(Prefix, "Events.Num: " .. #Timeline.Events)
    LogDebug(Prefix, "InterpVectors.Num: " .. #Timeline.InterpVectors)
    LogDebug(Prefix, "InterpFloats.Num: " .. #Timeline.InterpFloats)
    LogDebug(Prefix, "InterpLinearColors.Num: " .. #Timeline.InterpLinearColors)
    LogDebug(Prefix, "DirectionPropertyName: " .. Timeline.DirectionPropertyName:ToString())
end

---@param TimelineComponent UTimelineComponent
---@param Prefix string?
function AFUtils.LogTimelineComponent(TimelineComponent, Prefix)
    if not TimelineComponent or not TimelineComponent:IsValid() then return end
    Prefix = Prefix or ""

    AFUtils.LogTimeline(TimelineComponent.TheTimeline, Prefix, "TheTimeline.")
    LogDebug(Prefix, "bIgnoreTimeDilation: " .. tostring(TimelineComponent.bIgnoreTimeDilation))
end

---Logs in debug scope all relevant properties of FAbiotic_InventoryChangeableDataStruct to console 
---@param ChangeableData FAbiotic_InventoryChangeableDataStruct
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogInventoryChangeableDataStruct(ChangeableData, Prefix)
    if not ChangeableData then return end
    Prefix = Prefix or ""

    if ChangeableData.AssetID_25_06DB7A12469849D19D5FC3BA6BEDEEAB then
        LogDebug(Prefix, "AssetID: " .. ChangeableData.AssetID_25_06DB7A12469849D19D5FC3BA6BEDEEAB:ToString())
    end
    LogDebug(Prefix, "CurrentItemDurability: " .. ChangeableData.CurrentItemDurability_4_24B4D0E64E496B43FB8D3CA2B9D161C8)
    LogDebug(Prefix, "MaxItemDurability: " .. ChangeableData.MaxItemDurability_6_F5D5F0D64D4D6050CCCDE4869785012B)
    LogDebug(Prefix, "CurrentStack: " .. ChangeableData.CurrentStack_9_D443B69044D640B0989FD8A629801A49)
    LogDebug(Prefix, "CurrentAmmoInMagazine: " .. ChangeableData.CurrentAmmoInMagazine_12_D68C190F4B2FA78A4B1D57835B95C53D)
    LogDebug(Prefix, "LiquidLevel: " .. ChangeableData.LiquidLevel_46_D6414A6E49082BC020AADC89CC29E35A)
    LogDebug(Prefix, "CurrentLiquid (enum): " .. ChangeableData.CurrentLiquid_19_3E1652F448223AAE5F405FB510838109)
end

---Logs in debug scope all relevant properties of FAbiotic_InventoryItemSlotStruct to console 
---@param InventoryItemSlotStruct FAbiotic_InventoryItemSlotStruct
---@param Prefix string?
function AFUtils.LogInventoryItemSlotStruct(InventoryItemSlotStruct, Prefix)
    if not InventoryItemSlotStruct then return end
    Prefix = Prefix or ""

    LogDebug(Prefix, "RowName: " .. InventoryItemSlotStruct.ItemDataTable_18_BF1052F141F66A976F4844AB2B13062B.RowName:ToString())
    AFUtils.LogInventoryChangeableDataStruct(InventoryItemSlotStruct.ChangeableData_12_2B90E1F74F648135579D39A49F5A2313, Prefix, "ChangeableData.")
end

---Logs in debug scope all relevant properties of FAbiotic_LiquidStruct to console 
---@param LiquidStruct FAbiotic_LiquidStruct
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogLiquidStruct(LiquidStruct, Prefix)
    if not LiquidStruct then return end
    Prefix = Prefix or ""

    LogDebug(Prefix, "MaxLiquid: " .. LiquidStruct.MaxLiquid_16_80D4968B4CACEDD3D4018E87DA67E8B4)
    LogDebug(Prefix, "AllowedLiquids.Num: " .. #LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3)
    for i = 1, #LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3, 1 do
        local liquiedType = LiquidStruct.AllowedLiquids_7_1DF3EB8C43F49DA3A1E4A2AF908148D3[i]
        LogDebug(Prefix .. string.format("AllowedLiquids[%d]: ", i) .. liquiedType)
    end
    LogDebug(Prefix, "PercentageLiquidToStartWith: " .. LiquidStruct.PercentageLiquidToStartWith_11_835A4C4F440C319874D3EFA75CAFA4C5)
    LogDebug(Prefix, "LiquidToStartWith.Num: " .. #LiquidStruct.LiquidToStartWith_15_F7D753A24D2130B92AF312AB9192AD9C)
end

---Logs in debug scope all relevant properties of FAbiotic_WeaponStruct to console 
---@param WeaponStruct FAbiotic_WeaponStruct
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogWeaponStruct(WeaponStruct, Prefix)
    if not WeaponStruct then return end
    Prefix = Prefix or ""

    LogDebug(Prefix, "Melee: " .. tostring(WeaponStruct.Melee_1_AB17935A4F944DCEEB1AB3A5B598E702))
    LogDebug(Prefix, "MeleeSwingData.RowName: " .. WeaponStruct.MeleeSwingData_80_EA5C63F44178A08106BE41B8F7D8DE36.RowName:ToString())
    LogDebug(Prefix, "TimeBetweenShots: " .. tostring(WeaponStruct.TimeBetweenShots_8_71ACC9414B36314DEF34B3A54649941C))
    LogDebug(Prefix, "MaximumHitscanRange: " .. tostring(WeaponStruct.MaximumHitscanRange_26_F36D29CA48831A6C3AD49EB94F5D2BE2))
    LogDebug(Prefix, "DamagePerHit: " .. tostring(WeaponStruct.DamagePerHit_16_F95199D1425C37191C55CDA0DC07BDDC))
    LogDebug(Prefix, "BulletSpread_Min: " .. tostring(WeaponStruct.BulletSpread_Min_38_08ADC0BA4BEA02135BE0438A60AE5725))
    LogDebug(Prefix, "BulletSpread_Max: " .. tostring(WeaponStruct.BulletSpread_Max_39_4AE2E5744A934A3FFCEC2A9D7A1A6963))
    LogDebug(Prefix, "RecoilAmount: " .. tostring(WeaponStruct.RecoilAmount_42_85AFA9834A1CABF8183C088D857840EE))
    LogDebug(Prefix, "PelletCount: " .. tostring(WeaponStruct.PelletCount_77_4504318146345E7029C78790B317E074))
    LogDebug(Prefix, "MagazineSize: " .. tostring(WeaponStruct.MagazineSize_57_E890A3944240BB8D07EF0B9251F1FBD4))
    LogDebug(Prefix, "RequireAmmo: " .. tostring(WeaponStruct.RequireAmmo_85_8BB1C1954D2A83BB1994549DDEEBA306))
    LogDebug(Prefix, "AmmoType.RowName: " .. WeaponStruct.AmmoType_54_D19EDD9E48E4252D492757BFAAC23A73.RowName:ToString())
    LogDebug(Prefix, "AmmoTypes.Num: " .. #WeaponStruct.AmmoTypes_99_6514B50249092C020B24F9ABF9AF0E37)
    LogDebug(Prefix, "SecondaryAttack (enum 0-5): " .. WeaponStruct.SecondaryAttack_82_0ADE2DC74388F34F125F0DB6D9AAC1CD)
    LogDebug(Prefix, "LoudnessOnPrimaryUse: " .. WeaponStruct.LoudnessOnPrimaryUse_74_7829648A4C3F44A62DCA09B3817DF796)
    LogDebug(Prefix, "LoudnessOnSecondaryUse: " .. WeaponStruct.LoudnessOnSecondaryUse_73_89AB59C84EBC77DEB5DD2C9C88E9C237)
    LogDebug(Prefix, "UnderwaterState (enum 0-2): " .. WeaponStruct.UnderwaterState_95_972463794CBCCEA48AC987A7FA4C0118)
    LogDebug(Prefix, "BurstFireCount: " .. WeaponStruct.BurstFireCount_102_880FB81B4CA5EC7F7B5D6FBDE68275B8)
end

---Logs in debug scope all relevant properties of FAbiotic_InventoryItemStruct to console 
---@param InventoryItemStruct FAbiotic_InventoryItemStruct
---@param Prefix string?
function AFUtils.LogInventoryItemStruct(InventoryItemStruct, Prefix)
    if not InventoryItemStruct then return end
    Prefix = Prefix or ""

    LogDebug(Prefix, "ItemName: " .. InventoryItemStruct.ItemName_51_B88648C048EE5BC2885E4E95F3E13F0A:ToString())
    LogDebug(Prefix, "ItemDescription: " .. InventoryItemStruct.ItemDescription_38_E5F7B38A4F3C41EB9DA52CA14654D303:ToString())
    LogDebug(Prefix, "ItemFlavorText: " .. InventoryItemStruct.ItemFlavorText_39_12D05DD74EA145A5E7D1159C7F326177:ToString())
    -- LogDebug(Prefix, "ToInteractWith_Text: " .. InventoryItemStruct.ToInteractWith_Text_66_C2148289464D5AAA4D19BBA13F15FE41:ToString())
    -- LogDebug(Prefix, "ToLongInteractWith_Text: " .. InventoryItemStruct.ToLongInteractWith_Text_68_4FBE88F341B6A020E3216CA026A1E4E8:ToString())
    -- LogDebug(Prefix, "ToPackage_Text: " .. InventoryItemStruct.ToPackage_Text_71_5094104748FCB4BD2F90C99A2C4C49A8:ToString())
    -- LogDebug(Prefix, "ToLongPackage_Text: " .. InventoryItemStruct.ToLongPackage_Text_72_CB77853E49960F43E6422C90DC967508:ToString())
    -- LogDebug(Prefix, "Scale_WorldMesh: " .. InventoryItemStruct.Scale_WorldMesh_143_AF66D856410026FCC19E70AC421B3667)
    -- LogDebug(Prefix, "Scale_FirstPersonMesh: " .. InventoryItemStruct.Scale_FirstPersonMesh_146_6AFCDB94484AE7625E73C6AFB835D21F)
    -- LogDebug(Prefix, "Scale_TPHeldMesh: " .. InventoryItemStruct.Scale_TPHeldMesh_145_6826D00A4F30AEDBF62E02892E4261E6)
    LogDebug(Prefix, "PlacementOrientationsAllowed enum: " .. InventoryItemStruct.PlacementOrientationsAllowed_122_75894D7C4B93F103C06AB18421167757)
    LogDebug(Prefix, "CanLoseDurability: " .. tostring(InventoryItemStruct.CanLoseDurability_29_42EA515F4AC1EC69D8480DB36C01D5E1))
    LogDebug(Prefix, "MaxItemDurability: " .. InventoryItemStruct.MaxItemDurability_31_6EBCEFC943F9E85DE9350BBC0E249447)
    LogDebug(Prefix, "ChanceToLoseDurability: " .. InventoryItemStruct.ChanceToLoseDurability_97_DF967C464092E2E6AEEBFE84C536ACAB)
    -- ToDo log FAbiotic_ItemDropStruct, InventoryItemStruct.RepairItem_106_C2E89B0B4B7F39FC3B2B828BBD13A391
    LogDebug(Prefix, "StackSize: " .. InventoryItemStruct.StackSize_47_D124F11B4B6D9766B2B33699795845A9)
    LogDebug(Prefix, "Weight: " .. InventoryItemStruct.Weight_119_CE7DB430417207921D739CAF458D4D7C)
    LogDebug(Prefix, "TryPlaceInHotbar: " .. tostring(InventoryItemStruct.TryPlaceInHotbar_128_F78F6AA34A238AEAB278F48066C080BF))
    LogDebug(Prefix, "IsWeapon: " .. tostring(InventoryItemStruct.IsWeapon_63_57F6A703413EA260B1455CA81F2D4911))
    AFUtils.LogWeaponStruct(InventoryItemStruct.WeaponData_61_3C29CF6C4A7F9DD435F9318FEE4B033D, Prefix, "WeaponData.")
    -- ToDo log FAbiotic_Equipment_Struct, InventoryItemStruct.EquipmentData_100_576D05464F36104AFE501B878255E318
    -- ToDo log FAbiotic_Consumable_Struct, InventoryItemStruct.ConsumableData_84_757B6B114FF23016981BEF888A31C670
    -- ToDo log FAbiotic_CookableStruct, InventoryItemStruct.CookableData_94_7EFD1F0A4A7EFB44D3D8B9B14581BF36
    AFUtils.LogLiquidStruct(InventoryItemStruct.LiquidData_110_4D07F09C483C1E65B39024ABC7032FA0, Prefix, "LiquidData.")
    LogDebug(Prefix, "StrippedFromBuild: " .. tostring(InventoryItemStruct.StrippedFromBuild_149_8F18A38A4BB983B801C379B47FC5D5A9))
end

---Logs in debug scope all relevant properties of URechargeableComponent_C to console 
---@param RechargeableComponent URechargeableComponent_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogRechargeableComponent(RechargeableComponent, Prefix)
    if not RechargeableComponent then return end
    Prefix = Prefix or ""

    LogDebug(Prefix, "LightSourceType enum: " .. RechargeableComponent.LightSourceType)
    LogDebug(Prefix, "RechargeableActive: " .. tostring(RechargeableComponent.RechargeableActive))
    LogDebug(Prefix, "LastBatteryLevel: " .. RechargeableComponent.LastBatteryLevel)
    LogDebug(Prefix, "DrainPerTick: " .. RechargeableComponent.DrainPerTick)
    LogDebug(Prefix, "ChargeMultiplier: " .. RechargeableComponent.ChargeMultiplier)
    LogDebug(Prefix, "Headlamp: " .. tostring(RechargeableComponent.Headlamp))
    LogDebug(Prefix, "HeadlampIndex: " .. RechargeableComponent.HeadlampIndex)
    LogDebug(Prefix, "LastItemChargePercentage: " .. RechargeableComponent.LastItemChargePercentage)
    LogDebug(Prefix, "BatteryNotRequiredToFireWeapon: " .. tostring(RechargeableComponent.BatteryNotRequiredToFireWeapon))
    LogDebug(Prefix, "OwnerSlotType: " .. RechargeableComponent.OwnerSlotType)
    LogDebug(Prefix, "PlayerOwned: " .. tostring(RechargeableComponent.PlayerOwned))
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
    AFUtils.LogRechargeableComponent(DeployedBattery.RechargeableComponent, Prefix, "Rechargeable.")
end

---Logs in debug scope all relevant properties of a AAbiotic_Item_ParentBP_C to console 
---@param Item AAbiotic_Item_ParentBP_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogItemParentBP(Item, Prefix)
    if not Item or not Item:IsValid() then return end
    Prefix = Prefix or ""

    LogDebug(Prefix, "ItemDataRow.RowName: " .. Item.ItemDataRow.RowName:ToString())
    AFUtils.LogInventoryItemStruct(Item.ItemData, Prefix, "ItemData.")
    AFUtils.LogInventoryChangeableDataStruct(Item.ChangeableData, Prefix, "ChangeableData.")
    LogDebug(Prefix, "HasBeenPickedUp: " .. tostring(Item.HasBeenPickedUp))
    LogDebug(Prefix, "To Interact with Text: " .. Item["To Interact with Text"]:ToString())
    LogDebug(Prefix, "NoPhysics: " .. tostring(Item.NoPhysics))
    LogDebug(Prefix, "NoCollision: " .. tostring(Item.NoCollision))
    -- LogDebug(Prefix, "PopupAfterSpawned: " .. tostring(Item.PopupAfterSpawned))
    -- LogDebug(Prefix, "ShouldSimulate: " .. tostring(Item.ShouldSimulate))
    -- LogDebug(Prefix, "ProjectilePredict_BaseSpeed: " .. Item.ProjectilePredict_BaseSpeed)
    -- LogDebug(Prefix, "ProjectilePredict_SpeedMultiplier: " .. Item.ProjectilePredict_SpeedMultiplier)
    -- LogDebug(Prefix, "Bounciness: " .. Item.Bounciness)
    -- LogDebug(Prefix, "Collision Radius: " .. Item["Collision Radius"])
    -- LogDebug(Prefix .. string.format("ProjectilePredict_Velocity: X: %f Y: %f Z: %f", Item.ProjectilePredict_Velocity.X, Item.ProjectilePredict_Velocity.Y, Item.ProjectilePredict_Velocity.Z))
    LogDebug(Prefix, "ItemDecayInterval: " .. Item.ItemDecayInterval)
    -- LogDebug(Prefix, "Should Bounce: " .. tostring(Item["Should Bounce"]))
    -- LogDebug(Prefix, "SpawnedFromProjectileImpact: " .. tostring(Item.SpawnedFromProjectileImpact))
    -- local rechargeableComponent = GetBlueprintCreatedComponentByClass(Item, AFUtils.GetClassRechargeableComponent_C())
    -- if rechargeableComponent then
    --     AFUtils.LogRechargeableComponent(rechargeableComponent, Prefix, "RechargeableComponent.")
    -- end
end

---Logs in debug scope all relevant properties of a UAbiotic_InventoryComponent_C to console 
---@param Inventory UAbiotic_InventoryComponent_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogInventoryComponent(Inventory, Prefix)
    if not Inventory or not Inventory:IsValid() then return end
    Prefix = Prefix or ""

    LogDebug(Prefix, "CurrentInventory.Num: " .. #Inventory.CurrentInventory)
    for i = 1, #Inventory.CurrentInventory, 1 do
        local inventoryItemSlotStruct = Inventory.CurrentInventory[i]
        AFUtils.LogInventoryItemSlotStruct(inventoryItemSlotStruct, Prefix, "CurrentInventory["..i.."].")
    end
    LogDebug(Prefix, "MaxSlots: " .. Inventory.MaxSlots)
    LogDebug(Prefix, "InventorySlotType enum: " .. Inventory.InventorySlotType)
    LogDebug(Prefix, "DisplayName: " .. Inventory.DisplayName:ToString())
    LogDebug(Prefix, "ContainerType enum: " .. Inventory.ContainerType)
    LogDebug(Prefix, "SlotAppearance enum: " .. Inventory.SlotAppearance)
    -- LogDebug(Prefix, "DestroyParentWhenEmpty: " .. tostring(Inventory.DestroyParentWhenEmpty))
    LogDebug(Prefix, "EmptyItemRow.RowName: " .. Inventory.EmptyItemRow.RowName:ToString())
    LogDebug(Prefix, "InitialInventorySize: " .. Inventory.InitialInventorySize)
    LogDebug(Prefix, "CurrentTotalInventoryWeight: " .. Inventory.CurrentTotalInventoryWeight)
    LogDebug(Prefix, "CraftingCheck: " .. tostring(Inventory.CraftingCheck))
    LogDebug(Prefix, "ItemDecayInterval: " .. Inventory.ItemDecayInterval)
    LogDebug(Prefix, "InternalTemperature enum: " .. Inventory.InternalTemperature)
    LogDebug(Prefix, "AutoStartItemDecay: " .. tostring(Inventory.AutoStartItemDecay))
    LogDebug(Prefix, "CurrentRadiation: " .. Inventory.CurrentRadiation)
    LogDebug(Prefix, "RadioactiveShielding: " .. Inventory.RadioactiveShielding)
    LogDebug(Prefix, "InventoryUpdateLocked: " .. tostring(Inventory.InventoryUpdateLocked))
end

---Logs in debug scope all relevant properties of a AAbiotic_AIDirector_C to console 
---@param AIDirector AAbiotic_AIDirector_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogAIDirector(AIDirector, Prefix)
    if not AIDirector or not AIDirector:IsValid() then return end
    Prefix = Prefix or ""

    -- AFUtils.LogTimerHandle(AIDirector, AIDirector.Tick_PrioritySpawns, Prefix, "Tick_PrioritySpawns.")
    -- AFUtils.LogTimerHandle(AIDirector, AIDirector.Tick_DormantSpawns, Prefix, "Tick_DormantSpawns.")
    LogDebug(Prefix, "CurrentFacilitySpawns: " .. tostring(AIDirector.CurrentFacilitySpawns))
    LogDebug(Prefix, "ActiveNPCSpawns.Num: " .. #AIDirector.ActiveNPCSpawns)
    LogDebug(Prefix, "DormantNPCSpawns.Num: " .. #AIDirector.DormantNPCSpawns)
    LogDebug(Prefix, "DirectorDebugOn: " .. tostring(AIDirector.DirectorDebugOn))
    LogDebug(Prefix, "DebugNoDayNightManager: " .. tostring(AIDirector.DebugNoDayNightManager))
    LogDebug(Prefix, "NPCArray.Num: " .. #AIDirector.NPCArray)
    LogDebug(Prefix, "NPCCap: " .. AIDirector.NPCCap)
    -- AFUtils.LogTimerHandle(AIDirector, AIDirector.Assault_Timer, Prefix, "Assault_Timer.")
    LogDebug(Prefix, "Assault_CurrentPhase (enum 1-6): " .. AIDirector.Assault_CurrentPhase)
    -- ToDo Log Assault_CurrentData
    -- AFUtils.LogTimerHandle(AIDirector, AIDirector.Assault_ActiveLogicTimer, Prefix, "Assault_ActiveLogicTimer.")
    LogDebug(Prefix, "Assault_TimeLastSpawnedNPC: " .. AIDirector.Assault_TimeLastSpawnedNPC)
    LogDebug(Prefix, "Assault_BenchTargetLocation: " .. VectorToString(AIDirector.Assault_BenchTargetLocation))
    LogDebug(Prefix, "Assault_PatrolTargetLocation: " .. VectorToString(AIDirector.Assault_PatrolTargetLocation))
    LogDebug(Prefix, "Assault_CurrentRow: " .. AIDirector.Assault_CurrentRow:ToString())
    LogDebug(Prefix, "Assault_CurrentSpawnIndex: " .. AIDirector.Assault_CurrentSpawnIndex)
    LogDebug(Prefix, "Assault_TimeOfInitialWarning: " .. AIDirector.Assault_TimeOfInitialWarning)
    -- LogDebug(Prefix, "Assault_PreviousSpawnIndex: " .. AIDirector.Assault_PreviousSpawnIndex)
    LogDebug(Prefix, "TimeBeforeAssaults: " .. AIDirector.TimeBeforeAssaults)
    -- AFUtils.LogTimerHandle(AIDirector, AIDirector.LeyakTimer, Prefix, "LeyakTimer.")
    LogDebug(Prefix, "LeyakCooldown: " .. AIDirector.LeyakCooldown)
    LogDebug(Prefix, "ActiveLeyak IsValid: " .. tostring(AIDirector.ActiveLeyak:IsValid()))
    LogDebug(Prefix, "CurrentLeyakTarget IsValid: " .. tostring(AIDirector.CurrentLeyakTarget:IsValid()))
    LogDebug(Prefix, "LeyakSpawnAttempts: " .. AIDirector.LeyakSpawnAttempts)
    LogDebug(Prefix, "LeyakWorldFlag.RowName: " .. AIDirector.LeyakWorldFlag.RowName:ToString())
    LogDebug(Prefix, "LeyakWorldFlag.DataTablePath: " .. AIDirector.LeyakWorldFlag.DataTablePath:ToString())
    LogDebug(Prefix, "TimeLastLeyakSpawn: " .. AIDirector.TimeLastLeyakSpawn)
    -- AFUtils.LogTimerHandle(AIDirector, AIDirector.CoworkerTimer, Prefix, "CoworkerTimer.")
    LogDebug(Prefix, "MaxAssaultPortals: " .. AIDirector.MaxAssaultPortals)
    LogDebug(Prefix, "LeyakViewCounter: " .. AIDirector.LeyakViewCounter)
    LogDebug(Prefix, "CurrentAssaultPortals: " .. AIDirector.CurrentAssaultPortals)
    LogDebug(Prefix, "LeyakTauntCooldownMultiplier: " .. AIDirector.LeyakTauntCooldownMultiplier)
    LogDebug(Prefix, "DebugDisableNPCFreezing: " .. tostring(AIDirector.DebugDisableNPCFreezing))
end

---Logs in debug scope all relevant properties of a AAI_Controller_Leyak_C to console 
---@param AIControllerLeyak AAI_Controller_Leyak_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogAIControllerLeyak(AIControllerLeyak, Prefix)
    if not AIControllerLeyak then return end
    Prefix = Prefix or ""

    LogDebug(Prefix, "ValidTargets.Num: " .. #AIControllerLeyak.ValidTargets)
    LogDebug(Prefix, "SkipLeyakLevelCheck: " .. tostring(AIControllerLeyak.SkipLeyakLevelCheck))
    LogDebug(Prefix, "MaxLeyakChaseDistance: " .. AIControllerLeyak.MaxLeyakChaseDistance)
    LogDebug(Prefix, "LeyakAggroRange: " .. AIControllerLeyak.LeyakAggroRange)
    LogDebug(Prefix, "WantsToDespawn: " .. tostring(AIControllerLeyak.WantsToDespawn))
    LogDebug(Prefix, "MaxLeyakChaseDistance_Aggrod: " .. AIControllerLeyak.MaxLeyakChaseDistance_Aggrod)
end

---Logs in debug scope all relevant properties of a ANPC_Leyak_C to console 
---@param Leyak ANPC_Leyak_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogNPCLeyak(Leyak, Prefix)
    if not Leyak then return end
    Prefix = Prefix or ""

    LogDebug(Prefix, "ActorLocation: " .. VectorToString(Leyak:K2_GetActorLocation()))
    LogDebug(Prefix, "Timeline_Dissolve_NewTrack: " .. Leyak.Timeline_Dissolve_NewTrack_1_039C1F844D7D7D0E8CA9FEBA672ECF59)
    LogDebug(Prefix, "Timeline_Dissolve__Direction (enum 1-2): " .. Leyak.Timeline_Dissolve__Direction_039C1F844D7D7D0E8CA9FEBA672ECF59)
    LogDebug(Prefix, "RequiredMegalightDuration: " .. Leyak.RequiredMegalightDuration)
    LogDebug(Prefix, "TargetPlayer IsValid: " .. tostring(Leyak.TargetPlayer:IsValid()))
    LogDebug(Prefix, "HasBeenXrayed: " .. tostring(Leyak.HasBeenXrayed))
    LogDebug(Prefix, "ViewedByTarget: " .. tostring(Leyak.ViewedByTarget))
    LogDebug(Prefix, "CachedTimeSeen: " .. Leyak.CachedTimeSeen)
    LogDebug(Prefix, "DistanceDifferenceToDespawn: " .. Leyak.DistanceDifferenceToDespawn)
    LogDebug(Prefix, "SeenDespawnTime: " .. Leyak.SeenDespawnTime)
    LogDebug(Prefix, "DealDamageInfront: " .. tostring(Leyak.DealDamageInfront))
    LogDebug(Prefix, "StuckStartTime: " .. Leyak.StuckStartTime)
    LogDebug(Prefix, "PotentiallyStuck: " .. tostring(Leyak.PotentiallyStuck))
    LogDebug(Prefix, "AbsolutelyStuck: " .. tostring(Leyak.AbsolutelyStuck))
    LogDebug(Prefix, "TimeAllowedToBeStuck: " .. Leyak.TimeAllowedToBeStuck)
end

---Logs in debug scope all relevant properties of a AWeapon_FishingRod_C to console 
---@param FishingRod AWeapon_FishingRod_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogFishingRod(FishingRod, Prefix)
    if not FishingRod then return end
    Prefix = Prefix or ""

    -- LogDebug(Prefix, "FishingLocation: " .. VectorToString(FishingRod.FishingLocation))
    -- LogDebug(Prefix, "ActiveFishingLocation: " .. VectorToString(FishingRod.ActiveFishingLocation))
    -- LogDebug(Prefix, "ActiveCompletionZone: " .. VectorToString(FishingRod.ActiveCompletionZone))
    -- LogDebug(Prefix, "ActiveFishLocation: " .. VectorToString(FishingRod.ActiveFishLocation))
    -- LogDebug(Prefix, "ActivePlayerLocation: " .. VectorToString(FishingRod.ActivePlayerLocation))
    LogDebug(Prefix, "ActiveRodTension: " .. FishingRod.ActiveRodTension)
    LogDebug(Prefix, "NextDirectionChangeTime: " .. FishingRod.NextDirectionChangeTime)
    LogDebug(Prefix, "NextCooldownTime: " .. FishingRod.NextCooldownTime)
    LogDebug(Prefix, "FishCaptureProgress: " .. FishingRod.FishCaptureProgress)
    LogDebug(Prefix, "FishCaptureDistance: " .. FishingRod.FishCaptureDistance)
    LogDebug(Prefix, "FishCaptureStage: " .. FishingRod.FishCaptureStage)
    LogDebug(Prefix, "ActiveFishSpeed: " .. FishingRod.ActiveFishSpeed)
    LogDebug(Prefix, "TimeToStartMinigame: " .. FishingRod.TimeToStartMinigame)
    LogDebug(Prefix, "HasActiveFish: " .. tostring(FishingRod.HasActiveFish))
    LogDebug(Prefix, "ReelAnimTime: " .. FishingRod.ReelAnimTime)
    LogDebug(Prefix, "Reeling: " .. tostring(FishingRod.Reeling))
    LogDebug(Prefix, "HotspotActive: " .. tostring(FishingRod.HotspotActive))
    LogDebug(Prefix, "LastTimeFishingEnded: " .. FishingRod.LastTimeFishingEnded)
    LogDebug(Prefix, "CatchingJunk: " .. tostring(FishingRod.CatchingJunk))
    LogDebug(Prefix, "JunkReward.RowName: " .. FishingRod.JunkReward.RowName:ToString())
    LogDebug(Prefix, "FishReward.RowName: " .. FishingRod.FishReward.RowName:ToString())
    LogDebug(Prefix, "FishReward.DataTablePath: " .. FishingRod.FishReward.DataTablePath:ToString())
    LogDebug(Prefix, "RequiredCaptures: " .. FishingRod.RequiredCaptures)
    LogDebug(Prefix, "TackleboxActive: " .. tostring(FishingRod.TackleboxActive))
    LogDebug(Prefix, "LuckyHat: " .. tostring(FishingRod.LuckyHat))
    LogDebug(Prefix, "OwnerLastKnownLevel: " .. FishingRod.OwnerLastKnownLevel)
end

---Logs in debug scope all relevant properties of a ADayNightManager_C to console 
---@param DayNightManager ADayNightManager_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogDayNightManager(DayNightManager, Prefix)
    if not DayNightManager or not DayNightManager:IsValid() then return end
    Prefix = Prefix or ""

    LogDebug(Prefix, "DefaultStartingHour: " .. DayNightManager.DefaultStartingHour)
    LogDebug(Prefix, "MorningStartHour: " .. DayNightManager.MorningStartHour)
    LogDebug(Prefix, "NightfallStartHour: " .. DayNightManager.NightfallStartHour)
    LogDebug(Prefix, "AssaultCheckHour: " .. DayNightManager.AssaultCheckHour)
    LogDebug(Prefix, "WeatherCheckHour: " .. DayNightManager.WeatherCheckHour)
    LogDebug(Prefix, "CurrentTimeInSeconds: " .. DayNightManager.CurrentTimeInSeconds)
    LogDebug(Prefix, "24HoursInSeconds: " .. DayNightManager["24HoursInSeconds"])
    LogDebug(Prefix, "SecondsPerRealSecond_Day: " .. DayNightManager.SecondsPerRealSecond_Day)
    LogDebug(Prefix, "DoNotModify!DayNightTickRate: " .. DayNightManager["DoNotModify!DayNightTickRate"])
    LogDebug(Prefix, "CurrentDay: " .. DayNightManager.CurrentDay)
    LogDebug(Prefix, "IsNight: " .. tostring(DayNightManager.IsNight))
    LogDebug(Prefix, "LastKnownHour: " .. DayNightManager.LastKnownHour)
    LogDebug(Prefix, "SecondsPerRealSecond_Night: " .. DayNightManager.SecondsPerRealSecond_Night)
    LogDebug(Prefix, "CurrentAnnouncementIndex: " .. DayNightManager.CurrentAnnouncementIndex)
    LogDebug(Prefix, "AmbientTemperature_Day: " .. DayNightManager.AmbientTemperature_Day)
    LogDebug(Prefix, "AmbientTemperature_Night: " .. DayNightManager.AmbientTemperature_Night)
    LogDebug(Prefix, "CurrentAnnouncementJournals.Num: " .. #DayNightManager.CurrentAnnouncementJournals)
    LogDebug(Prefix, "HavePlayersLeftStartingZone: " .. tostring(DayNightManager.HavePlayersLeftStartingZone))
    LogDebug(Prefix, "LastAssaultDay: " .. DayNightManager.LastAssaultDay)
    LogDebug(Prefix, "IsAssaultDay: " .. tostring(DayNightManager.IsAssaultDay))
    LogDebug(Prefix, "SleepingPlayers: " .. DayNightManager.SleepingPlayers)
    LogDebug(Prefix, "LastWeatherDay: " .. DayNightManager.LastWeatherDay)
    LogDebug(Prefix, "CurrentWeatherEvent: " .. DayNightManager.CurrentWeatherEvent:ToString())
    LogDebug(Prefix, "RequiredDaysBetweenWeather: " .. DayNightManager.RequiredDaysBetweenWeather)
    LogDebug(Prefix, "TimeLastAutoSaved: " .. DayNightManager.TimeLastAutoSaved)
    if DayNightManager.ActiveWeatherDirector:IsValid() then
        LogDebug(Prefix, "ActiveWeatherDirector.Class: " .. DayNightManager.ActiveWeatherDirector:GetClass():GetFullName())
    end
    LogDebug(Prefix, "ActiveAmbientRadiation: " .. DayNightManager.ActiveAmbientRadiation)
    LogDebug(Prefix, "CurrentAnnouncementCompendium.Num: " .. #DayNightManager.CurrentAnnouncementCompendium)
    LogDebug(Prefix, "Weather_RequestByPlayer.RowName: " .. DayNightManager.Weather_RequestByPlayer.RowName:ToString())
    LogDebug(Prefix, "Weather_RequestByPlayer.DataTablePath: " .. DayNightManager.Weather_RequestByPlayer.DataTablePath:ToString())
end

---Logs in debug scope all relevant properties of a AAbiotic_Character_ParentBP_C to console 
---@param Character AAbiotic_Character_ParentBP_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogCharacterParentBP(Character, Prefix)
    if not Character or not Character:IsValid() then return end
    Prefix = Prefix or ""

    LogDebug(Prefix, "TotalCombinedHealth: ", Character.TotalCombinedHealth)
    LogDebug(Prefix, "IsDead: ", Character.IsDead)
    LogDebug(Prefix, "IsDBNO: ", Character.IsDBNO)
    LogDebug(Prefix, "HasDBNOState: ", Character.HasDBNOState)
    LogDebug(Prefix, "IsDBNO: ", Character.IsDBNO)
    LogDebug(Prefix, "MeleeRange: ", Character.MeleeRange)
    LogDebug(Prefix, "InteractionRange: ", Character.InteractionRange)
    LogDebug(Prefix, "CurrentHunger: ", Character.CurrentHunger)
    LogDebug(Prefix, "MaxHunger: ", Character.MaxHunger)
    LogDebug(Prefix, "HungerDecayInterval: ", Character.HungerDecayInterval)
    LogDebug(Prefix, "HungerDecayAmount: ", Character.HungerDecayAmount)
    -- LogDebug(Prefix, "HeadBones.Num: ", #Character.HeadBones)
    LogDebug(Prefix, "CurrentFatigue: ", Character.CurrentFatigue)
    LogDebug(Prefix, "MaxFatigue: ", Character.MaxFatigue)
    LogDebug(Prefix, "FatigueIncreaseInterval: ", Character.FatigueIncreaseInterval)
    LogDebug(Prefix, "FatigueIncreaseAmount: ", Character.FatigueIncreaseAmount)
    LogDebug(Prefix, "CurrentThirst: ", Character.CurrentThirst)
    LogDebug(Prefix, "MaxThirst: ", Character.MaxThirst)
    LogDebug(Prefix, "ThirstDecayInterval: ", Character.ThirstDecayInterval)
    LogDebug(Prefix, "ThirstDecayAmount: ", Character.ThirstDecayAmount)
    LogDebug(Prefix, "HasThirst: ", Character.HasThirst)
    LogDebug(Prefix, "HasHunger: ", Character.HasHunger)
    LogDebug(Prefix, "HasFatigue: ", Character.HasFatigue)
    -- LogDebug(Prefix, "TorsoBones.Num: ", #Character.TorsoBones)
    -- LogDebug(Prefix, "LeftArmBones.Num: ", #Character.LeftArmBones)
    -- LogDebug(Prefix, "RightArmBones.Num: ", #Character.RightArmBones)
    -- LogDebug(Prefix, "LeftLegBones.Num: ", #Character.LeftLegBones)
    -- LogDebug(Prefix, "RightLegBones.Num: ", #Character.RightLegBones)
    -- ToDo LastPointDamage
    LogDebug(Prefix, "Faction (enum 0-10): ", Character.Faction)
    LogDebug(Prefix, "CurrentVoiceAudioImportance (enum 0-2): ", Character.CurrentVoiceAudioImportance)
    LogDebug(Prefix, "NPC_Targetable: ", Character.NPC_Targetable)
    LogDebug(Prefix, "Inventory: ", Character.Inventory)
    LogDebug(Prefix, "CurrentBodyTemperature: ", Character.CurrentBodyTemperature)
    LogDebug(Prefix, "LethalBodyTemperature_High: ", Character.LethalBodyTemperature_High)
    LogDebug(Prefix, "LethalBodyTemperature_Low: ", Character.LethalBodyTemperature_Low)
    LogDebug(Prefix, "HasBodyTemperature: ", Character.HasBodyTemperature)
    LogDebug(Prefix, "PreferredBodyTemperature: ", Character.PreferredBodyTemperature)
    LogDebug(Prefix, "LockedInPlaceMontage: ", Character.LockedInPlaceMontage)
    LogDebug(Prefix, "BleedoutStartTime: ", Character.BleedoutStartTime)
    LogDebug(Prefix, "CurrentBleedoutTime: ", Character.CurrentBleedoutTime)
    LogDebug(Prefix, "SelectedDeathAnimation: ", Character.SelectedDeathAnimation)
    LogDebug(Prefix, "DiedExplosively: ", Character.DiedExplosively)
    LogDebug(Prefix, "DamageSpilloverToHead: ", Character.DamageSpilloverToHead)
    LogDebug(Prefix, "IsSleeping: ", Character.IsSleeping)
    LogDebug(Prefix, "IsSittingInSeat: ", Character.IsSittingInSeat)
    LogDebug(Prefix, "IsDrivingVehicle: ", Character.IsDrivingVehicle)
    LogDebug(Prefix, "CurrentBed IsValid: ", Character.CurrentBed:IsValid())
    LogDebug(Prefix, "FatigueRequiredToSleep: ", Character.FatigueRequiredToSleep)
    LogDebug(Prefix, "HasMasterKey: ", Character.HasMasterKey)
    LogDebug(Prefix, "TimeLastRevived: ", Character.TimeLastRevived)
    LogDebug(Prefix, "BloodSplatterType (enum 0-8): ", Character.BloodSplatterType)
    LogDebug(Prefix, "IsReloading: ", Character.IsReloading)
    LogDebug(Prefix, "InvincibleToNPCs: ", Character.InvincibleToNPCs)
    LogDebug(Prefix, "DebuffsImmune.Num: ", #Character.DebuffsImmune)
    LogDebug(Prefix, "TimeOfLastPainYell: ", Character.TimeOfLastPainYell)
    LogDebug(Prefix, "TimeOfLastPainGrunt: ", Character.TimeOfLastPainGrunt)
    LogDebug(Prefix, "CurrentSeat IsValid: ", Character.CurrentSeat:IsValid())
    LogDebug(Prefix, "LastSeatIndex: ", Character.LastSeatIndex)
    LogDebug(Prefix, "ContinenceToReceive: ", Character.ContinenceToReceive)
    LogDebug(Prefix, "HasContinence: ", Character.HasContinence)
    LogDebug(Prefix, "CurrentContinence: ", Character.CurrentContinence)
    LogDebug(Prefix, "MaxContinence: ", Character.MaxContinence)
    LogDebug(Prefix, "ContinenceComputeInterval: ", Character.ContinenceComputeInterval)
    LogDebug(Prefix, "RegeneratesHealth: ", Character.RegeneratesHealth)
    LogDebug(Prefix, "HealthRegenInterval: ", Character.HealthRegenInterval)
    LogDebug(Prefix, "CurrentArmor_Chest: ", Character.CurrentArmor_Chest)
    LogDebug(Prefix, "CurrentArmor_Arms: ", Character.CurrentArmor_Arms)
    LogDebug(Prefix, "CurrentArmor_Legs: ", Character.CurrentArmor_Legs)
    LogDebug(Prefix, "CurrentArmor_Head: ", Character.CurrentArmor_Head)
    LogDebug(Prefix, "Invincible: ", Character.Invincible)
    LogDebug(Prefix, "CharacterSize (enum 0-3): ", Character.CharacterSize)
    LogDebug(Prefix, "ReducedHeadDamage: ", Character.ReducedHeadDamage)
    LogDebug(Prefix, "CurrentLightValue: ", Character.CurrentLightValue)
    LogDebug(Prefix, "DebugMeleeSwings: ", Character.DebugMeleeSwings)
    LogDebug(Prefix, "PerformingMeleeSwing: ", Character.PerformingMeleeSwing)
    -- ToDo CurrentMeleeingData
    LogDebug(Prefix, "ActorsHitThisMeleeSwing.Num: ", #Character.ActorsHitThisMeleeSwing)
    LogDebug(Prefix, "MeleeSwingProgress: ", Character.MeleeSwingProgress)
    LogDebug(Prefix, "CurrentReloadDuration: ", Character.CurrentReloadDuration)
    LogDebug(Prefix, "SpeakingAlpha: ", Character.SpeakingAlpha)
    LogDebug(Prefix, "HasLipsync: ", Character.HasLipsync)
    LogDebug(Prefix, "LipsyncRegistered: ", Character.LipsyncRegistered)
    LogDebug(Prefix, "CurrentSafetyValue: ", Character.CurrentSafetyValue)
    LogDebug(Prefix, "DoTick_GrabZoneCheck: ", Character.DoTick_GrabZoneCheck)
    LogDebug(Prefix, "GrabSocket: ", Character.GrabSocket:ToString())
    LogDebug(Prefix, "GrabbedByCharacter IsValid: ", Character.GrabbedByCharacter:IsValid())
    LogDebug(Prefix, "GrabCheckRadius: ", Character.GrabCheckRadius)
    LogDebug(Prefix, "HoldingCharacter IsValid: ", Character.HoldingCharacter:IsValid())
    LogDebug(Prefix, "InfiniteStamina: ", Character.InfiniteStamina)
    LogDebug(Prefix, "ClimbingLadder: ", Character.ClimbingLadder)
    LogDebug(Prefix, "CurrentLadder IsValid: ", Character.CurrentLadder:IsValid())
    LogDebug(Prefix, "LadderClimbSpeed: ", Character.LadderClimbSpeed)
    LogDebug(Prefix, "LadderStartZ: ", Character.LadderStartZ)
    LogDebug(Prefix, "RecentlyStaggered: ", Character.RecentlyStaggered)
    LogDebug(Prefix, "TemperatureInterval: ", Character.TemperatureInterval)
    LogDebug(Prefix, "TargetBodyTemperature: ", Character.TargetBodyTemperature)
    LogDebug(Prefix, "CurrentRadiation: ", Character.CurrentRadiation)
    LogDebug(Prefix, "CanReceiveRadiation: ", Character.CanReceiveRadiation)
    LogDebug(Prefix, "RadiationCheckInterval: ", Character.RadiationCheckInterval)
    LogDebug(Prefix, "CurrentRadiationBeingReceived: ", Character.CurrentRadiationBeingReceived)
    LogDebug(Prefix, "MaxRadiation: ", Character.MaxRadiation)
    LogDebug(Prefix, "WalkSpeed_Modifiers.Num: ", #Character.WalkSpeed_Modifiers)
    for i = 1, #Character.WalkSpeed_Modifiers do
        local modifier = Character.WalkSpeed_Modifiers[i]
        if modifier then
            LogDebug(Prefix, "WalkSpeed_Modifiers[", i, "]: ", modifier)
        end
    end
    LogDebug(Prefix, "RadiationResistance: ", Character.RadiationResistance)
    LogDebug(Prefix, "Pitch: ", Character.Pitch)
    LogDebug(Prefix, "Yaw: ", Character.Yaw)
    LogDebug(Prefix, "DamageReductionPerArmorPoint: ", Character.DamageReductionPerArmorPoint)
    LogDebug(Prefix, "LastLadderDirectionDown: ", Character.LastLadderDirectionDown)
    LogDebug(Prefix, "UsingZipline: ", Character.UsingZipline)
    LogDebug(Prefix, "CurrentZipline IsValid: ", Character.CurrentZipline:IsValid())
    LogDebug(Prefix, "DamageToNPCs: ", Character.DamageToNPCs)
    LogDebug(Prefix, "DefaultSpottability: ", Character.DefaultSpottability)
    LogDebug(Prefix, "ZenMode: ", Character.ZenMode)
    LogDebug(Prefix, "IsAI: ", Character.IsAI)
    LogDebug(Prefix, "ReviveCount: ", Character.ReviveCount)
    LogDebug(Prefix, "DeadFlailInAir: ", Character.DeadFlailInAir)
    LogDebug(Prefix, "IsShieldBlocking: ", Character.IsShieldBlocking)
    LogDebug(Prefix, "LastBlockedDamagePercentage: ", Character.LastBlockedDamagePercentage)
    LogDebug(Prefix, "WalkSoundVolume: ", Character.WalkSoundVolume)
    LogDebug(Prefix, "SprintSoundVolume: ", Character.SprintSoundVolume)
    LogDebug(Prefix, "TimeLastVomitted: ", Character.TimeLastVomitted)
    LogDebug(Prefix, "LastKilledByInstantDamageType: ", Character.LastKilledByInstantDamageType)
    LogDebug(Prefix, "IsSpeaking: ", Character.IsSpeaking)
    LogDebug(Prefix, "IsStateDrainDisabled: ", Character.IsStateDrainDisabled)
    -- ToDo BloodStainsData
    LogDebug(Prefix, "DefaultMaxFatigue: ", Character.DefaultMaxFatigue)
    LogDebug(Prefix, "SilenceDuringNarrative: ", Character.SilenceDuringNarrative)
    LogDebug(Prefix, "LadderStillOnFloor: ", Character.LadderStillOnFloor)
    LogDebug(Prefix, "LoadedVoiceAsset IsValid: ", Character.LoadedVoiceAsset:IsValid())
    LogDebug(Prefix, "LastStartBlockTime: ", Character.LastStartBlockTime)
    LogDebug(Prefix, "MaxReviveCount: ", Character.MaxReviveCount)
    LogDebug(Prefix, "IsDisabled: ", Character.IsDisabled)
    LogDebug(Prefix, "PerformingWeaponThrow: ", Character.PerformingWeaponThrow)
    LogDebug(Prefix, "WeaponHoldThrowProgress: ", Character.WeaponHoldThrowProgress)
    -- ToDo TempThreshold_ properties
    LogDebug(Prefix, "HasSwimmingStats: ", Character.HasSwimmingStats)
    LogDebug(Prefix, "SwimmingUpdateInterval: ", Character.SwimmingUpdateInterval)
    LogDebug(Prefix, "UnderwaterImmersionDepth: ", Character.UnderwaterImmersionDepth)
    LogDebug(Prefix, "WaddingImmersionDepth: ", Character.WaddingImmersionDepth)
    LogDebug(Prefix, "DrownTime: ", Character.DrownTime)
    LogDebug(Prefix, "RebreatherDrownTime: ", Character.RebreatherDrownTime)
    LogDebug(Prefix, "TotalArmorWeight: ", Character.TotalArmorWeight)
    LogDebug(Prefix, "BodyShieldAbsorbedLastHit: ", Character.BodyShieldAbsorbedLastHit)
    LogDebug(Prefix, "CrouchedWaddingImmersionDepth: ", Character.CrouchedWaddingImmersionDepth)
    LogDebug(Prefix, "MaxArmorDamageReduction: ", Character.MaxArmorDamageReduction)
    LogDebug(Prefix, "HasBeenGrabbed: ", Character.HasBeenGrabbed)
    LogDebug(Prefix, "NoDamageSpillover: ", Character.NoDamageSpillover)
    LogDebug(Prefix, "DefaultGravityScale: ", Character.DefaultGravityScale)
    LogDebug(Prefix, "NearbyFatigueMultiplier: ", Character.NearbyFatigueMultiplier)
    LogDebug(Prefix, "HitReactImpulse_Max: ", Character.HitReactImpulse_Max)
    LogDebug(Prefix, "CanRagdoll: ", Character.CanRagdoll)
    LogDebug(Prefix, "HadRVOEnabled: ", Character.HadRVOEnabled)
    LogDebug(Prefix, "PerformingMeleeAttack: ", Character.PerformingMeleeAttack)
    LogDebug(Prefix, "RagdollDelay: ", Character.RagdollDelay)
    LogDebug(Prefix, "RagdollBlendLength: ", Character.RagdollBlendLength)
    LogDebug(Prefix, "TorsoIsLethal: ", Character.TorsoIsLethal)
    LogDebug(Prefix, "TimeLastVehicleHit: ", Character.TimeLastVehicleHit)
    LogDebug(Prefix, "CurrentHeatResist: ", Character.CurrentHeatResist)
    LogDebug(Prefix, "CurrentColdResist: ", Character.CurrentColdResist)
end

---Logs in debug scope all relevant properties of a ANarrativeNPC_ParentBP_C to console 
---@param NarrativeNPC ANarrativeNPC_ParentBP_C
---@param Prefix string? Prefix that should be added in front of each line
function AFUtils.LogNarrativeNPC(NarrativeNPC, Prefix)
    if not NarrativeNPC or not NarrativeNPC:IsValid() then return end
    Prefix = Prefix or ""

    LogDebug(Prefix, "IsCorpse: " .. tostring(NarrativeNPC.IsCorpse))
    LogDebug(Prefix, "NarrativeNPC_ConversationRow.RowName: " .. tostring(NarrativeNPC.NarrativeNPC_ConversationRow.RowName:ToString()))
    -- LogDebug(Prefix, "HeadBoneLookAtTarget: ", NarrativeNPC.HeadBoneLookAtTarget)
    LogDebug(Prefix, "NarrativeState (enum 0-5): ", NarrativeNPC.NarrativeState)
    LogDebug(Prefix, "LastPlayedNarrativeState (enum 0-5): ", NarrativeNPC.LastPlayedNarrativeState)
    LogDebug(Prefix, "PlayerCharactersInDialogZone.Num: ", #NarrativeNPC.PlayerCharactersInDialogZone)
    LogDebug(Prefix, "IsSpeakingDialog: ", NarrativeNPC.IsSpeakingDialog)
    LogDebug(Prefix, "PlayerCharactersInBeckon: ", #NarrativeNPC.PlayerCharactersInBeckon)
    LogDebug(Prefix, "CurrentMessageIndex: ", NarrativeNPC.CurrentMessageIndex)
    LogDebug(Prefix, "NoHeadLook: ", NarrativeNPC.NoHeadLook)
    LogDebug(Prefix, "NoBeckonZone: ", NarrativeNPC.NoBeckonZone)
    LogDebug(Prefix, "NoDialogZone: ", NarrativeNPC.NoDialogZone)
    LogDebug(Prefix, "HeadLookAlpha: ", NarrativeNPC.HeadLookAlpha)
    LogDebug(Prefix, "BeckonInterval: ", NarrativeNPC.BeckonInterval)
    LogDebug(Prefix, "LastDialogWasBeckon: ", NarrativeNPC.LastDialogWasBeckon)
    LogDebug(Prefix, "ToInteractwithText: ", NarrativeNPC["To Interact with Text"]:ToString())
    LogDebug(Prefix, "LastVoiceLineIndex: ", NarrativeNPC.LastVoiceLineIndex)
    LogDebug(Prefix, "AutoSpeakNextDialog: ", NarrativeNPC.AutoSpeakNextDialog)
    LogDebug(Prefix, "LongInteractBText: ", NarrativeNPC.LongInteractBText:ToString())
    LogDebug(Prefix, "DistanceForBeckonSubtitles: ", NarrativeNPC.DistanceForBeckonSubtitles)
    LogDebug(Prefix, "NonInteractable: ", NarrativeNPC.NonInteractable)
end