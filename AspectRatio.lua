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
