## Bug Report

**Problem/Title**: Channel selection displays all channels instead of selected AP group channel when switching back from custom settings

**Description**: 
When switching from "Customize" radio settings back to "Use AP group settings", the Channel selection field displays all available channels instead of showing only the channel that was previously selected in the AP group settings. This occurs during the following workflow:

1. Set up Channel selection method to Manual and select a specific channel in AP group settings
2. Navigate to Wi-Fi > Access Points > AP List
3. Click on the AP name and select Configure
4. Go to the Radio tab (default shows AP group settings)
5. Click "Customize" option to modify radio settings
6. Switch back to "Use AP group settings"
7. **Issue**: Channel selection field shows all channels instead of the previously selected channel from AP group settings

**Expected Behavior**: When switching back to "Use AP group settings", the Channel selection field should display only the channel that was selected in the AP group configuration.

**Actual Behavior**: Channel selection field displays all available channels instead of the specific channel selected in AP group settings.

**Steps to Reproduce**:
1. Set up Channel selection method to Manual and select a specific channel in AP group settings
2. On the navigation bar, click Wi-Fi > Access Points > AP List
3. Click the name of the AP for which you want to customize the AP radio settings, then on the Overview page, click Configure
4. Select the Radio tab. The default setting is to use the radio settings of the AP group settings
5. To customize any of the radio settings, click the Customize option; the fields become active, allowing you to modify the settings
6. Switch back to Use AP group settings
7. Observe that the Channel selection field shows all channels instead of the selected AP group channel

**Note**: This appears to be a UI refresh issue where the channel selection from the AP group settings is not being properly restored when reverting from custom settings back to group settings. The system should remember and display only the channel that was configured in the AP group settings.
