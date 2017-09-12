----------------------------------------------------------------------------------------------------
-- PATCH FOR FABRIKSCRIPT
----------------------------------------------------------------------------------------------------
-- Purpose:  Changes production rates to normalize over season length
-- Authors:  Rahkiin
--
-- Copyright (c) Realismus Modding, 2017
----------------------------------------------------------------------------------------------------

ssCompanyFactory = {}
g_seasons.companyFactory = ssCompanyFactory

function ssCompanyFactory:preLoad()
    Placeable.finalizePlacement = Utils.appendedFunction(Placeable.finalizePlacement, ssCompanyFactory.placeableFinalizePlacement)
end

function ssCompanyFactory:loadMap()
    g_seasons.environment:addSeasonLengthChangeListener(self)
end

function ssCompanyFactory:loadGameFinished()
    self:updateProductionFactors()
end

function ssCompanyFactory:findFactories()
    local factories = {}

    if g_currentMission.onCreateLoadedObjects ~= nil then
        for _, object in pairs(g_currentMission.onCreateLoadedObjects) do
            if object.FabrikScriptDirtyFlag or object.mCompanyFactoryDirtyFlag then
                object.ssOriginalProductPerHour = object.ProduktPerHour

                table.insert(factories, object)
            end
        end
    end

    if g_currentMission.ownedItems ~= nil then
        for _, items in pairs(g_currentMission.ownedItems) do
            for _, object in pairs(items.items) do
                if object.FabrikScriptDirtyFlag or object.mCompanyFactoryDirtyFlag then
                    object.ssOriginalProductPerHour = object.ProduktPerHour

                    table.insert(factories, object)
                end
            end
        end
    end

    return factories
end

function ssCompanyFactory:seasonLengthChanged()
    self:updateProductionFactors()
end

function ssCompanyFactory:updateProductionFactors()
    for _, factory in ipairs(self.factories) do
        factory.ProduktPerHour = factory.ssOriginalProductPerHour * 6 / g_seasons.environment.daysInSeason
    end
end

function ssCompanyFactory:placeableFinalizePlacement()
    self.ssOriginalProductPerHour = self.ProduktPerHour
    self.ProduktPerHour = self.ssOriginalProductPerHour * 6 / g_seasons.environment.daysInSeason
end
