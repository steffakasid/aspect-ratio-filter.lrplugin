local LrCatalog = import'LrApplication'.activeCatalog()
local LrTasks = import 'LrTasks'

require 'AspectRatio'
require 'AspectRatioMapping'
require 'Logger'
require 'TableHelper'

ApplyAspectRatio = {timeout = 30}

function ApplyAspectRatio.processAllPhotos()
    logger:info("Reset aspect ratio on all photos")
    local allPhotos = LrCatalog:getAllPhotos()
    AspectRatio.processPhotos(allPhotos)
end

LrTasks.startAsyncTask(ApplyAspectRatio.processAllPhotos)
