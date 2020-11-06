local LrCatalog = import'LrApplication'.activeCatalog()
local LrProgressScope = import 'LrProgressScope'
local LrFunctionContext = import 'LrFunctionContext'

require "Logger"

AspectRatio = {}

function AspectRatio.setAspectRatioOnPhoto(photo)
    logger:debug('AspectRatio from Metadata: ',
                 photo:getRawMetadata('aspectRatio'))

    local stringAspectRatio = getRatioMapping(
                                  photo:getRawMetadata('aspectRatio'))

    logger:debug('AspectRatio for Filter: ', stringAspectRatio)

    photo:setPropertyForPlugin(_PLUGIN, 'aspectRatio', stringAspectRatio)
end

function AspectRatio.processPhotos(photos)
    local parentProgressScope = LrProgressScope(
                                    {title = 'Reset aspect ratio on all photos'})
    parentProgressScope:attachToFunctionContext(
        LrFunctionContext.callWithContext(
            'AspectRatioFilter.applyMetadataToAllPhotos', function(context)
                local i = 0
                local allPhotosLength = getTableSize(photos)
                for _, photo in ipairs(photos) do

                    if parentProgressScope:isCanceled() then
                        break
                    end

                    LrCatalog:withWriteAccessDo(
                        'Assign AspectRatio to target photos',
                        function(context)
                            logger:debug(
                                'Percent done ' .. tostring(i / allPhotosLength))
                            local subProgress =
                                LrProgressScope(
                                    {
                                        parent = parentProgressScope,
                                        parentEndRange = i / allPhotosLength,
                                        caption = photo:getFormattedMetadata(
                                            'fileName'),
                                        functionContext = context
                                    })
                            AspectRatio.setAspectRatioOnPhoto(photo)
                        end, {
                            timeout = ApplyAspectRatio.timeout,
                            callback = function()
                                logger:trace(
                                    'Task timeout after ' ..
                                        ApplyAspectRatio.timeout)
                            end
                        })
                    i = i + 1
                end
                parentProgressScope:done()
            end))
    logger:debug("I'm done!")
end

