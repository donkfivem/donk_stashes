Config = {}

Config.PoliceOpen = true -- Can Police open all stashes

Config.Stashes = {
    ["gang_vagos"] = {
        stashName = "gang_vagos",
        coords = vector3(351.279, -2023.785, 22.363), 
        requirecid = false,
        jobrequired = false,
        gangrequired = true,
        gang = "vagos",
        grade = 0,
        job = "",
        cid = {},  
        stashSize = 750000,
        stashSlots = 60, 
    },
    ["ambulancestash"] = {
        stashName = "Ambulance Stash",
        coords = vector3(310.92541, -592.8532, 38.331008), 
        requirecid = false,
        jobrequired = true,
        gangrequired = false,
        gang = "",
        grade = 0,
        job = "ambulance",
        cid = {},  
        stashSize = 4500000,
        stashSlots = 150, 
    },
}