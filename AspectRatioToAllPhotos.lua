local catalog = import'LrApplication'.activeCatalog()
local dialogs = import 'LrDialogs'
local selection = import 'LrSelection'
local tasks = import 'LrTasks'

require 'AspectRatio'
require 'AspectRatioMapping'
require 'Logger'
require 'TableHelper'

ApplyAspectRatio = {timeout = 30}

function ApplyAspectRatio.processTargetPhotos()
    logger:trace("Reset aspect ratio on all photos")

    for _, photo in ipairs(catalog:getAllPhotos()) do
        catalog:withWriteAccessDo('Assign AspectRatio to target photos',
                                  function()
            AspectRatio.setAspectRatioOnPhoto(photo)
        end, {
            timeout = ApplyAspectRatio.timeout,
            callback = function()
                logger:info('Task timeout after ' .. ApplyAspectRatio.timeout)
            end
        })
    end
end

tasks.startAsyncTask(ApplyAspectRatio.processTargetPhotos)
