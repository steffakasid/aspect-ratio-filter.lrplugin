require "PluginInit"
require "Logger"
require "AspectRatioMapping"
require "AspectRatio"
require "TableHelper"

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

    schemaVersion = 17, -- must be a number, preferably a positive integer

    updateFromEarlierSchemaVersion = function(catalog, previousSchemaVersion)

        logger:info('Run migrations...')
        catalog:assertHasPrivateWriteAccess(
            "AspectRatioMetaData.updateFromEarlierSchemaVersion")

        -- Retrieve photos that have been used already with the custom metadata.
        logger:trace('previousSchemaVersion '..tostring(previousSchemaVersion))
        local photosToMigrate = {}
        if previousSchemaVersion then
          logger:trace('Find photos to migrate.')
            photosToMigrate = catalog:findPhotosWithProperty(
                                  PluginInit.pluginID, 'aspectRatio',
                                  previousSchemaVersion)
        else
            logger:trace('Getting all photos from catalog for initialization.')
            photosToMigrate = catalog:getAllPhotos()
        end
        logger:info('Set aspect ratio for '..tostring(getTableSize(photosToMigrate)..' photos.'))

        for _, photo in ipairs(photosToMigrate) do
          AspectRatio.setAspectRatioOnPhoto(photo)
        end
    end

}
