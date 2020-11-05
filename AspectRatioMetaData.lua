local logger = import 'LrLogger'('AspectRatioFilterUpdate')
logger:enable("logfile")

require "PluginInit"
require "RatioMapping"

return {

    metadataFieldsForPhotos = {

        {id = 'aspectRatioFilter'}, {
            id = 'aspectRatio',
            title = 'Aspect Ratio',
            dataType = 'string',
            browsable = true,
            searchable = true
        }
    },

    schemaVersion = 16, -- must be a number, preferably a positive integer

    updateFromEarlierSchemaVersion = function(catalog, previousSchemaVersion)

        logger:info('Run migrations...')
        catalog:assertHasPrivateWriteAccess(
            "AspectRatioMetaData.updateFromEarlierSchemaVersion")

        -- Retrieve photos that have been used already with the custom metadata.
        logger:trace('previousSchemaVersion '..previousSchemaVersion)
        local photosToMigrate = {}
        if previousSchemaVersion then
            photosToMigrate = catalog:findPhotosWithProperty(
                                  PluginInit.pluginID, 'aspectRatio',
                                  previousSchemaVersion)
        else
            logger:trace('Getting all photos from catalog for initialization.')
            photosToMigrate = catalog:getAllPhotos()
        end

        for _, photo in ipairs(photosToMigrate) do
            -- local currentAsprectRatio = photo:getPropertyForPlugin(PluginInit.pluginID, 'aspectRatio')
            logger:trace('AspectRatio from Metadata: ',
                         photo:getRawMetadata('aspectRatio'))

            local stringAspectRatio = getRatioMapping(photo:getRawMetadata('aspectRatio'))

            if stringAspectRatio == nil then
                stringAspectRatio = 'unkown'
            end

            logger:trace('AspectRatio for Filter: ', stringAspectRatio)

            photo:setPropertyForPlugin(_PLUGIN, 'aspectRatio', stringAspectRatio)
        end
    end

}
