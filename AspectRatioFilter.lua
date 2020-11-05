local catalog = import'LrApplication'.activeCatalog()
local tasks = import 'LrTasks'
local logger = import 'LrLogger'('AspectRatioFilter')
logger:enable("logfile")

require 'RatioMapping'
require 'ConcatTables'

AspectRatioFilter = {timeout = 30}

function AspectRatioFilter.processCurrentPhotos()
    logger:trace("Initializing...")
    local activeSources = catalog:getActiveSources()

    local allPhotos = {}

    for key, value in pairs(activeSources) do
        logger:trace(key, " -- ", value:type())
        if value:type() == 'LrFolder' then
            logger:trace("I'm a LrFolder")
            concatTables(allPhotos, value:getPhotos(true))
        elseif value:type() == 'LrCollection' then
            logger:trace("I'm a LrCollection")
        else
            logger:trace("I'm something else: ", value)
        end
    end

    AspectRatioFilter.resetAspectRatioOnPhotos(allPhotos)

end

function AspectRatioFilter.resetAspectRatioOnPhotos(photos)
    for _, photo in ipairs(photos) do
        catalog:withWriteAccessDo('Assign AspectRatio to current photos',
                                  function()
            logger:trace('Processing Photo: ', photo:getRawMetadata('uuid'))

            logger:trace('Raw MetaData ratio: ',
                         photo:getRawMetadata('aspectRatio'))
            local mappedRatio = getRatioMapping(photo:getRawMetadata('aspectRatio'))
            logger:trace('Setting aspect ratio to ', mappedRatio)
            photo:setPropertyForPlugin(_PLUGIN, 'aspectRatio', mappedRatio)
        end, {timeout = AspectRatioFilter.timeout, callback = function()
            logger:info('Task timeout after ' .. AspectRatioFilter.timeout)
        end})
    end
end

tasks.startAsyncTask(AspectRatioFilter.processCurrentPhotos)
