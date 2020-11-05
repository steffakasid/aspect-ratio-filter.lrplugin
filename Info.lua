return {

	LrSdkVersion = 3.0,
	LrSdkMinimumVersion = 2.0,
	LrToolkitIdentifier = 'de.steffen-rumpf.aspectRatioFilter',

	LrPluginName = "Aspect Ratio Filter",
	LrPluginInfoUrl = "http://www.adobe.com",
	
	-- Add the Metadata Definition File
	LrMetadataProvider = 'AspectRatioMetaData.lua',
    
    -- Manually add aspectRatio Metadata to currently viewed images
    LrLibraryMenuItems = {
        title = "Aspect Ratio Filter", -- The display text for the menu item
        file = "AspectRatioFilter.lua" -- The script that runs when the item is selected
    },
    
	VERSION = { major=1, minor=0, revision=0, build="20201105", },

}
