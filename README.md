# Donk Stashes - Advanced Stash System for QBox

A comprehensive stash management system designed specifically for QBox framework with full ox_inventory integration and advanced permission controls.

## Features

- 🔐 **Multi-Permission System** - Job, gang, citizen ID, and police access controls
- 📦 **ox_inventory Integration** - Full compatibility with ox_inventory stash system
- 🚔 **Police Override** - LEO access to stashes when enabled
- 👥 **Gang Support** - Built-in QBox gang system integration
- 💼 **Job Restrictions** - Job and grade-based access control
- 🆔 **Citizen ID Whitelist** - Specific player access via citizen ID
- ⚡ **Optimized Performance** - Efficient permission checking
- 🎯 **Easy Configuration** - Simple config-based setup

## Requirements

- **QBox Framework** (Latest version)
- **ox_inventory** - For stash functionality
- **ox_lib** - For notifications and utilities
- **ox_target** (Optional) - For targeting interactions

## Installation

1. Download the latest release
2. Extract `donk_stashes` to your `resources` folder
3. Add `ensure donk_stashes` to your `server.cfg`
4. Configure your stashes in `config.lua`
5. Restart your server

## Configuration

### Basic Stash Setup
```lua
Config.Stashes = {
    ['police_armory'] = {
        stashName = 'police_armory',
        stashSlots = 50,
        stashSize = 100000,
        coords = vector3(451.51, -979.44, 30.68),
        
        -- Permission Settings
        jobrequired = true,
        job = 'police',
        grade = 2,
        
        gangrequired = false,
        requirecid = false,
    },
    
    ['gang_warehouse'] = {
        stashName = 'ballas_warehouse',
        stashSlots = 100,
        stashSize = 500000,
        coords = vector3(105.40, -1885.21, 24.32),
        
        -- Gang Access
        jobrequired = false,
        gangrequired = true,
        gang = 'ballas',
        grade = 1,
        
        requirecid = false,
    },
    
    ['private_vault'] = {
        stashName = 'private_vault',
        stashSlots = 25,
        stashSize = 50000,
        coords = vector3(240.06, 360.84, 105.89),
        
        -- Specific Players Only
        jobrequired = false,
        gangrequired = false,
        requirecid = true,
        cid = {'ABC12345', 'DEF67890'},
    }
}
```

### Global Settings
```lua
Config.PoliceOpen = true  -- Allow LEO to access non-job restricted stashes
```

## Permission Types

### 1. Job-Based Access
```lua
jobrequired = true,
job = 'police',
grade = 2,  -- Minimum grade required
```

### 2. Gang-Based Access
```lua
gangrequired = true,
gang = 'ballas',
grade = 1,  -- Minimum gang grade
```

### 3. Citizen ID Whitelist
```lua
requirecid = true,
cid = {'ABC12345', 'DEF67890', 'GHI11223'},
```

### 4. Police Override
When `Config.PoliceOpen = true`, LEO jobs can access stashes that don't have `jobrequired = true`.

## Usage Examples

### Creating Interactive Stashes

#### With ox_target
```lua
-- Add to client-side script
exports.ox_target:addBoxZone({
    coords = Config.Stashes['police_armory'].coords,
    size = vec3(2, 2, 2),
    rotation = 45,
    options = {
        {
            name = 'open_police_armory',
            icon = 'fas fa-box',
            label = 'Open Armory',
            onSelect = function()
                TriggerEvent('donk_stashes:client:openStash', 'police_armory')
            end
        }
    }
})
```

#### With Command
```lua
-- Add to client-side script
RegisterCommand('openstash', function(source, args)
    local stashId = args[1]
    if Config.Stashes[stashId] then
        TriggerEvent('donk_stashes:client:openStash', stashId)
    else
        lib.notify({
            description = 'Invalid stash ID',
            type = 'error'
        })
    end
end)
```

### Permission Examples

#### Multi-Permission Stash
```lua
['secure_evidence'] = {
    stashName = 'evidence_locker',
    stashSlots = 75,
    stashSize = 200000,
    coords = vector3(475.39, -996.67, 26.27),
    
    -- Multiple access methods
    jobrequired = true,
    job = 'police',
    grade = 3,
    
    -- Backup access for specific people
    requirecid = true,
    cid = {'CHIEF001', 'CAPTAIN002'},
}
```

## Events

### Client Events
```lua
-- Open specific stash
TriggerEvent('donk_stashes:client:openStash', stashId)
```

### Server Events
```lua
-- Load stash data (automatically triggered)
TriggerServerEvent('donk-stashes:server:loadStashes', stashName, stashId, slots, size, coords)
```

## Advanced Features

### Dynamic Stash Creation
```lua
-- Add new stash at runtime
Config.Stashes['new_stash'] = {
    stashName = 'dynamic_stash',
    stashSlots = 30,
    stashSize = 75000,
    coords = GetEntityCoords(PlayerPedId()),
    jobrequired = true,
    job = 'mechanic',
    grade = 0,
}
```

### Permission Checking Function
```lua
-- Check if player can access stash (client-side)
local function canAccessStash(stashId)
    local PlayerData = QBX:GetPlayerData()
    -- Add your custom permission logic here
    return true -- or false
end
```

## Troubleshooting

### Common Issues

**Stash Won't Open**
- Check player permissions match config requirements
- Verify stash coordinates are correct
- Ensure ox_inventory is running

**Permission Denied**
- Confirm job/gang names match exactly
- Check grade levels are sufficient
- Verify citizen IDs are correct format

**Stash Not Loading**
- Check server console for errors
- Verify config syntax is correct
- Ensure all required resources are running

### Debug Commands
```lua
-- Check player data (client console)
-- This will show current job, gang, and citizen ID
print(json.encode(QBX:GetPlayerData(), {indent = true}))
```

## Performance Notes

- Stashes are loaded on-demand to reduce memory usage
- Permission checks are client-side for faster response
- ox_inventory handles all inventory operations efficiently
- Supports unlimited concurrent stash access

## Compatibility

- ✅ **QBox Framework** - Full integration
- ✅ **ox_inventory** - Native support
- ✅ **ox_lib** - Notifications and utilities
- ✅ **ox_target** - Optional targeting support

## Support & Contributing
- 💬 [Discord Support](https://discord.gg/donkdev)

### Contributing
1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## Credits

- **Framework**: QBox Framework
- **Inventory**: Overextended (ox_inventory)
- **Libraries**: Overextended (ox_lib)
- **Script**: Donk Development

---

⭐ **If this script helps your server, please consider starring the repository!**
