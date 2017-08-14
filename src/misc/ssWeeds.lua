----------------------------------------------------------------------------------------------------
-- WEEDS SCRIPT
----------------------------------------------------------------------------------------------------
-- Purpose:  
-- Authors:  
-- Credits:  
--
-- Copyright (c) Realismus Modding, 2017
----------------------------------------------------------------------------------------------------

ssWeeds = {}
g_seasons.weeds = ssWeeds


function ssWeeds:load(savegame, key)
end

function ssWeeds:save(savegame, key)
end

function ssWeeds:loadMap(name)
    if g_currentMission:getIsServer() then
        --g_currentMission.environment:addDayChangeListener(self)
        g_seasons.environment:addTransitionChangeListener(self)
        ssDensityMapScanner:registerCallback("ssWeedsUpdate", self, self.weedsUpdate, self.finishWeedsUpdate)
    end
end

function ssWeeds:loadMapFinished()
end



--handle transitionChanged event
function ssWeeds:transitionChanged()
end


-- handle dayChanged event
-- do we need it? Not sure yet. Possibly not
function ssWeeds:dayChanged()
end

-- called by ssDensityScanner to make fruit grow
function ssWeeds:weedsUpdate(startWorldX, startWorldZ, widthWorldX, widthWorldZ, heightWorldX, heightWorldZ, transition)
    local x, z, widthX, widthZ, heightX, heightZ = Utils.getXZWidthAndHeight(g_currentMission.terrainDetailHeightId, startWorldX, startWorldZ, widthWorldX, widthWorldZ, heightWorldX, heightWorldZ)
end

function ssWeeds:finishWeedsUpdate(transition)
end