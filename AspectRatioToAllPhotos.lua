local LrCatalog = import'LrApplication'.activeCatalog()
local LrTasks = import 'LrTasks'
local LrProgressScope = import 'LrProgressScope'
local LrFunctionContext = import 'LrFunctionContext'

require 'AspectRatio'
require 'AspectRatioMapping'
require 'Logger'
require 'TableHelper'

ApplyAspectRatio = {timeout = 30}

function ApplyAspectRatio.processTargetPhotos()
    logger:info("Reset aspect ratio on all photos")
    local allPhotos = LrCatalog:getAllPhotos()
    local parentProgressScope = LrProgressScope(
                                    {title = 'Reset aspect ratio on all photos'})
    parentProgressScope:attachToFunctionContext(
        LrFunctionContext.callWithContext(
            'AspectRatioFilter.applyMetadataToAllPhotos', function(context)
                local i = 0
                local allPhotosLength = getTableSize(allPhotos)
                for _, photo in ipairs(allPhotos) do

                  if parentProgressScope:isCanceled() then break end

                    LrCatalog:withWriteAccessDo(
                        'Assign AspectRatio to target photos',
                        function(context)
                          logger:debug('Percent done '..tostring(i / allPhotosLength))
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

LrTasks.startAsyncTask(ApplyAspectRatio.processTargetPhotos)
