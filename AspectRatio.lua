require "Logger"

AspectRatio = {}

function AspectRatio.setAspectRatioOnPhoto(photo)
    logger:trace('AspectRatio from Metadata: ',
                 photo:getRawMetadata('aspectRatio'))

    local stringAspectRatio = getRatioMapping(
                                  photo:getRawMetadata('aspectRatio'))

    if stringAspectRatio == nil then stringAspectRatio = 'unkown' end

    logger:trace('AspectRatio for Filter: ', stringAspectRatio)

    photo:setPropertyForPlugin(_PLUGIN, 'aspectRatio', stringAspectRatio)
end
