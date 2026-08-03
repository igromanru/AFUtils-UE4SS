--[[
    Author: Igromanru
    Created Date: 19.08.2024
    Description: Utility functions for the game Abiotic Factor
]]

require("AFUtils.AFBase")

local UEHelpers = require("UEHelpers")

---- Buffs ----
AFUtils.DebuffLegSprain = UEHelpers.FindOrAddFName("Debuff_LegSprain")
AFUtils.DebuffRecentLegInjury = UEHelpers.FindOrAddFName("Debuff_RecentLegInjury")
AFUtils.DebuffLegFracture = UEHelpers.FindOrAddFName("Debuff_LegFracture")
AFUtils.DebuffLegBroken = UEHelpers.FindOrAddFName("Debuff_LegBroken")
AFUtils.DebuffDamaged = UEHelpers.FindOrAddFName("Debuff_Damaged")
AFUtils.DebuffInCombat = UEHelpers.FindOrAddFName("Debuff_InCombat")
AFUtils.DebuffBleeding = UEHelpers.FindOrAddFName("Debuff_Bleeding")
AFUtils.DebuffUnderwater = UEHelpers.FindOrAddFName("Debuff_Underwater")
AFUtils.DebuffWading = UEHelpers.FindOrAddFName("Debuff_Wading")
AFUtils.DebuffDrowning = UEHelpers.FindOrAddFName("Debuff_Drowning")

---- Food ----
AFUtils.IceCreamName = UEHelpers.FindOrAddFName("icecream")
AFUtils.FoodGreyebName = UEHelpers.FindOrAddFName("food_greyeb")

---- NPCs ----
AFUtils.LeyakRowName = UEHelpers.FindOrAddFName("Leyak")
AFUtils.KrasueRowName = UEHelpers.FindOrAddFName("Krasue")

return AFUtils