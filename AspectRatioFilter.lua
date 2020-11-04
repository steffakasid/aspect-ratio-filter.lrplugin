local LrDialogs = import 'LrDialogs'
local catalog = import'LrApplication'.activeCatalog()
local logger = import 'LrLogger'('AspectRatioFilter')
logger:enable("logfile")

AspectRatioFilter = {}
function AspectRatioFilter.createFilter()
    logger:trace("Initializing...")
    local activeSources = catalog:getActiveSources()

    local allPhotos = {}

    for key, value in pairs(activeSources) do
        logger:trace(key, " -- ", value:type())
        if value:type() == 'LrFolder' then
            logger:trace("I'm a LrFolder")
            concatTables(allPhotos,value:getPhotos(true))
        elseif value:type() == 'LrCollection' then
            logger:trace("I'm a LrCollection")
        else
            logger:trace("I'm something else: ", value)
        end
    end

    createFilter(allPhotos)

    local currentViewFilter = catalog:getCurrentViewFilter()
    for key, value in pairs(currentViewFilter) do
        logger:trace(key, ' -- ', value)
        if type(value) == 'table' then
            for key2, value2 in pairs(value) do
                logger:trace(key2, ' --- ', value2)
                for key3, value3 in pairs(value2) do
                    logger:trace(key3, ' ---- ', value3)
                    -- for key4, value4 in pairs(value3) do
                    --     logger:trace(key4, '-----', value4)
                    -- end
                end
            end
        end
    end

end

function createFilter(photos)
    for _, photo in ipairs(photos) do
        -- logger:trace(photo:getRawMetadata('aspectRatio'))
    end
end

function concatTables(targetTable, sourceTable)
    for _,v in ipairs(sourceTable) do 
        table.insert(targetTable, v)
    end
end

import'LrTasks'.startAsyncTask(AspectRatioFilter.createFilter)
