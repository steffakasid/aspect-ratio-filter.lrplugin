return {

    LrSdkVersion = 3.0,
    LrSdkMinimumVersion = 2.0,
    LrToolkitIdentifier = 'de.steffen-rumpf.aspectRatioFilter',

    LrPluginName = "Aspect Ratio Filter",
    LrPluginInfoUrl = "http://www.adobe.com",

    LrMetadataProvider = 'AspectRatioMetaData.lua',

    LrLibraryMenuItems = {
        {
            title = "Aspect Ratio Filter (current photos)",
            file = "AspectRatioToCurrentPhotos.lua",
            enabledWhen = 'photosAvailable'
        },
        {
          title = "Aspect Ratio Filter (all photos)",
          file = "AspectRatioToAllPhotos.lua"
        }
    },

    VERSION = {major = 1, minor = 0, revision = 0, build = "20201105"}

}
