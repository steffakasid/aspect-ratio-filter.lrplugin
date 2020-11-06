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
    logger:info("Reset aspect ratio on target photos")

    selectedPhoto = catalog:getTargetPhoto()

    if (selectedPhoto ~= nil) then
        okOrCancel = dialogs.confirm('There is a photo selected!',
                                     'Do you want to only update this foto?',
                                     'OK', 'Deselect & Proceed')
        if (okOrCancel ~= 'ok') then selection.selectNone() end
    end

    for _, photo in ipairs(catalog:getTargetPhotos()) do
        catalog:withWriteAccessDo('Assign AspectRatio to target photos',
                                  function()
            AspectRatio.setAspectRatioOnPhoto(photo)
        end, {
            timeout = ApplyAspectRatio.timeout,
            callback = function()
                logger:trace('Task timeout after ' .. ApplyAspectRatio.timeout)
            end
        })
    end
end

tasks.startAsyncTask(ApplyAspectRatio.processTargetPhotos)
