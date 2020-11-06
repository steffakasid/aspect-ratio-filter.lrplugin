local LrCatalog = import'LrApplication'.activeCatalog()
local LrDialogs = import 'LrDialogs'
local LrSelection = import 'LrSelection'
local LrTasks = import 'LrTasks'

require 'AspectRatio'
require 'AspectRatioMapping'
require 'Logger'
require 'TableHelper'

ApplyAspectRatio = {timeout = 30}

function ApplyAspectRatio.processTargetPhotos()
    logger:info("Reset aspect ratio on target photos")

    selectedPhoto = LrCatalog:getTargetPhoto()

    if (selectedPhoto ~= nil) then
        okOrCancel = LrDialogs.confirm('There is a photo selected!',
                                     'Do you want to only update this foto?',
                                     'OK', 'Deselect & Proceed')
        if (okOrCancel ~= 'ok') then LrSelection.selectNone() end
    end
    AspectRatio.processPhotos(LrCatalog:getTargetPhotos())
end

LrTasks.startAsyncTask(ApplyAspectRatio.processTargetPhotos)
