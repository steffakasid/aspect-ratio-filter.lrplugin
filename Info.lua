return {
    LrPluginName = "Aspect Ratio Filter",
    LrSdkVersion = 5.0,
    LrToolkitIdentifier = 'com.adobe.lightroom.sdk.aspect-ratio-filter',
    -- LrExportMenuItems = {
    --     title = "Aspect Ratio Filter", -- The display text for the menu item
    --     file = "ExportMenuItem.lua" -- The script that runs when the item is selected
    -- },
    -- LrLibraryMenuItems = {
    --     title = "Aspect Ratio Filter", -- The display text for the menu item
    --     file = "AspectRatioFilter.lua" -- The script that runs when the item is selected
    -- }
    LrExportFilterProvider = {
        title = "Aspect Ratio Filter", -- The display text for the menu item
        file = "AspectRatioFilter.lua" -- The script that runs when the item is selected
    }
}
