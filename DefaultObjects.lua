
require("AFUtils.AFBase")

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