
--[[
    Author: Igromanru
    Created Date: 19.08.2024
    Description: Utility functions for the game Abiotic Factor
]]

require("AFUtils.AFBase")

local AbioticFunctionLibraryCache = CreateInvalidObject() ---@cast AbioticFunctionLibraryCache UAbioticFunctionLibrary_C
---@return UAbioticFunctionLibrary_C
function AFUtils.GetAbioticFunctionLibrary()
    if IsNotValid(AbioticFunctionLibraryCache) then
        AbioticFunctionLibraryCache = StaticFindObject("/Game/Blueprints/Libraries/AbioticFunctionLibrary.Default__AbioticFunctionLibrary_C")
        ---@cast AbioticFunctionLibraryCache UAbioticFunctionLibrary_C
    end
    return AbioticFunctionLibraryCache
end

local LevelStreamingCustomCache = CreateInvalidObject() ---@cast LevelStreamingCustomCache ULevelStreamingCustom
---@return ULevelStreamingCustom
function AFUtils.GetLevelStreamingCustom()
    if IsNotValid(LevelStreamingCustomCache) then
        LevelStreamingCustomCache = StaticFindObject("/Script/AbioticFactor.Default__LevelStreamingCustom")
        ---@cast LevelStreamingCustomCache ULevelStreamingCustom
    end
    return LevelStreamingCustomCache
end


local WeatherEventHandleFunctionLibraryCache = CreateInvalidObject() ---@cast WeatherEventHandleFunctionLibraryCache UWeatherEventHandleFunctionLibrary
---@return UWeatherEventHandleFunctionLibrary
function AFUtils.GetWeatherEventHandleFunctionLibrary()
    if IsNotValid(WeatherEventHandleFunctionLibraryCache) then
        WeatherEventHandleFunctionLibraryCache = StaticFindObject("/Script/AbioticFactor.Default__WeatherEventHandleFunctionLibrary")
        ---@cast WeatherEventHandleFunctionLibraryCache UWeatherEventHandleFunctionLibrary
    end
    return WeatherEventHandleFunctionLibraryCache
end

return AFUtils