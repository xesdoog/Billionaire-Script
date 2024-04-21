---@diagnostic disable: undefined-global, lowercase-global
local billionaire_services=gui.get_tab("Billionaire Services")
local airport_index             = 0
local pJet                      = 0
local pilot                     = 0
local copilot                   = 0
local jetHeading                = 0
local setHeading                = 0
local bodyguard_index           = 0
local guard_1                   = 0
local guard_2                   = 0
local guard_3                   = 0
local escort_1                  = 0
local escort_2                  = 0
local escort_3                  = 0
local escortCar                 = 0
local carBlip                   = 0
local limo                      = 0
local limoDriver                = 0
local donutDirection            = 7
local started_landing           = false
local can_land                  = false
local dismissed                 = false
local dismissedGuards           = false
local sittingInEscortCar        = false
local driveStarted              = false
local driveToWp                 = false
local doingBurnout              = false
local doingDriveBy              = false
local doDonuts                  = false
local escortLeftCar             = false
local sittingInLimo             = false
local limoStarted               = false
local bsDebug                   = false
local taskInProgress            = false
local startFollowTask           = true
local currentTask               = "None."
local hangarPos                 = vector3
local spawned_jet               = {}
local spawned_pilot             = {}
local spawned_limo              = {}
local spawned_driver            = {}
local spawned_bodyguards        = {}
local spawned_escorts           = {}
local spawned_SUV               = {}
local guardBlips                = {}
local airports                  = {
  {name = "Los Santos International Airport", hangar = vec3:new(-979.294, -2993.9, 13.9451),  runwayStart = vec3:new(-1305.79, -2148.72, 13.9446),  runwayEnd = vec3:new(-1663.04, -2775.99, 13.9447),  taxiPos = vec3:new(-1046.74, -2971.01, 13.9487),  cutPos = vec3:new(-2204.82, -2554.53, 678.723)},
  {name = "Fort Zancudo",                     hangar = vec3:new(-2140.81, 3255.64, 32.8103),  runwayStart = vec3:new(-1972.55, 2842.36, 32.8104),   runwayEnd = vec3:new(-2620.15, 3208.18, 32.8117),   taxiPos = vec3:new(-2166.8, 3203.57, 32.8049),    cutPos = vec3:new(-3341.66, 3578.68, 595.203) },
  {name = "Sandy Shores Airfield",            hangar = vec3:new(1744.21, 3276.24, 41.1191),   runwayStart = vec3:new(1052.2, 3068.35, 41.6282),     runwayEnd = vec3:new(1624.41, 3233.22, 40.4115),    taxiPos = vec3:new(1705.72, 3254.61, 41.0139),    cutPos = vec3:new(-164.118, 1830.04, 996.586) },
}
local bodyguards = {
  {name = "Private Mercenaries",  pedType = "PED_TYPE_ARMY",                  modelHash = {a = 0x613E626C, b = 0x5076A73B, c = 0xB3F3EE34}, weaponHash = 0x83BF0278, vehicle = 2230595153,  vehCol = 0,   vehRadio = ""                   },  -- Carbine Rifle (can't do driveby's)
  {name = "Private Security",     pedType = "PED_TYPE_COP",                   modelHash = {a = 0xF161D212, b = 0x2930C1AB, c = 0x55FE9B46}, weaponHash = 0x2B5EF5EC, vehicle = 666166960,   vehCol = 0,   vehRadio = ""                   },  -- Ceramic Pistol
  {name = "Ballas OGs",           pedType = "PED_TYPE_GANG_AFRICAN_AMERICAN", modelHash = {a = 0x231AF63F, b = 0xABEF0004, c = 0xDB41B4EF}, weaponHash = 0x1B06D571, vehicle = 3431608412,  vehCol = 145, vehRadio = "RADIO_09_HIPHOP_OLD"},  -- Default Pistol
  {name = "Families OGs",         pedType = "PED_TYPE_GANG_AFRICAN_AMERICAN", modelHash = {a = 0x33A464E5, b = 0xE83B93B7, c = 0x84302B09}, weaponHash = 0x1B06D571, vehicle = 3265236814,  vehCol = 53,  vehRadio = "RADIO_03_HIPHOP_NEW"},  -- //
  {name = "Vagos Esses",          pedType = "PED_TYPE_GANG_PUERTO_RICAN",     modelHash = {a = 0x837B64DE, b = 0x5AA42C21, c = 0x964D12DC}, weaponHash = 0x1B06D571, vehicle = 2254540506,  vehCol = 88,  vehRadio = "RADIO_08_MEXICAN"   },  -- //
  {name = "Lost MC",              pedType = "PED_TYPE_GANG_BIKER_1",          modelHash = {a = 0x32B11CDC, b = 0x4F46D607, c = 0xFD5537DE}, weaponHash = 0x1B06D571, vehicle = 2549763894,  vehCol = 0,   vehRadio = "RADIO_04_PUNK"      },  -- //
  {name = "Armenian Mobsters",    pedType = "PED_TYPE_GANG_ALBANIAN",         modelHash = {a = 0xE7714013, b = 0xFDA94268, c = 0xF1E823A2}, weaponHash = 0x1B06D571, vehicle = 83136452,    vehCol = 111, vehRadio = "RADIO_13_JAZZ"      },  -- //
  {name = "Cartel Sicarios",      pedType = "PED_TYPE_GANG_PUERTO_RICAN",     modelHash = {a = 0x995B3F9F, b = 0x7ED5AD78, c = 0xE6AC74A4}, weaponHash = 0xBFEFFF6D, vehicle = 4256087847,  vehCol = 0,   vehRadio = "RADIO_08_MEXICAN"   },  -- Assault Rifle (can't do driveby's)
  {name = "Bad Bitches",          pedType = "PED_TYPE_PROSTITUTE",            modelHash = {a = 0x28ABF95, b = 0x81441B71, c = 0xAEEA76B5},  weaponHash = 350597077,  vehicle = 461465043,   vehCol = 30,  vehRadio = "RADIO_02_POP"       },  -- Tactical SMG
}
local function updateAirports()
  filteredAirports = {}
  for _, airport in ipairs(airports) do
          table.insert(filteredAirports, airport)
  end
end
local function displayAirports()
  updateAirports()
  local airportNames = {}
  for _, airport in ipairs(filteredAirports) do
    table.insert(airportNames, airport.name)
  end
  airport_index, used = ImGui.Combo("##airportList", airport_index, airportNames, #filteredAirports)
end
local function updateGuards()
  filteredGuards = {}
  for _, bGuard in ipairs(bodyguards) do
    table.insert(filteredGuards, bGuard)
  end
  table.sort(filteredGuards, function(a, b)
    return a.name < b.name
  end)
end
local function displayGuards()
  updateGuards()
  local groupNames = {}
  for _, bGuard in ipairs(filteredGuards) do
      table.insert(groupNames, bGuard.name)
  end
  bodyguard_index, used = ImGui.Combo("##bodyguardList", bodyguard_index, groupNames, #filteredGuards)
end
local function pedConfig(ped)
  script.run_in_fiber(function()
    PED.SET_PED_CONFIG_FLAG(ped, 179, true)
    PED.SET_PED_CONFIG_FLAG(ped, 294, true)
    PED.SET_PED_CONFIG_FLAG(ped, 398, true)
    PED.SET_PED_CONFIG_FLAG(ped, 401, true)
    PED.SET_PED_CONFIG_FLAG(ped, 443, true)
    PED.SET_PED_COMBAT_ABILITY(ped, 2)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 1, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 2, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 3, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 12, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 13, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 20, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 21, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 22, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 27, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 28, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 31, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 34, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 41, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 42, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 50, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 58, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 61, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 71, true)
  end)
end
function nearestPed(closeTo)
  script.run_in_fiber(function(getRandomPed)
    local gtaPeds = entities.get_all_peds_as_handles()
    for _, ped in ipairs(gtaPeds) do
      local thisPos       = ENTITY.GET_ENTITY_COORDS(closeTo, false)
      local randomPedPos  = ENTITY.GET_ENTITY_COORDS(ped, false)
      local distCalc      = SYSTEM.VDIST(thisPos.x, thisPos.y, thisPos.z, randomPedPos.x, randomPedPos.y, randomPedPos.z)
      if distCalc <= 100 then
        if ped ~= self.get_ped() then
          randomPed = ped
          getRandomPed:sleep(500)
        end
      end
    end
  end)
  return randomPed
end
billionaire_services:add_imgui(function()
  ImGui.BeginTabBar("Billionaire Services", ImGuiTabBarFlags.None)
  if ImGui.BeginTabItem("Private Jet") then
    ImGui.Text("Choose an Airport:")
    ImGui.PushItemWidth(280)
    displayAirports()
    ImGui.PopItemWidth()
    local airportData   = filteredAirports[airport_index + 1]
    local jetModel      = 0xB79F589E
    local pilotModel    = 0x864ED68E
    local copilotModel  = 0xE75B4B1C
    if ImGui.Button("Spawn Private Jet") then
      if airport_index == 0 then
        jetHeading = 50
      elseif airport_index == 1 then
        jetHeading = 150
      else
        jetHeading = 132
      end
      if spawned_jet[1] == nil then
        script.run_in_fiber(function(privateJet)
          while not STREAMING.HAS_MODEL_LOADED(jetModel) do
            STREAMING.REQUEST_MODEL(jetModel)
            coroutine.yield()
          end
          pJet = VEHICLE.CREATE_VEHICLE(jetModel, 0.0, 0.0, 0.0, 0.0, true, false, false)
          privateJet:sleep(200)
          ENTITY.SET_ENTITY_COORDS(pJet, airportData.hangar.x, airportData.hangar.y, airportData.hangar.z, true, true, true, true)
          ENTITY.SET_ENTITY_HEADING(pJet, jetHeading)
          ENTITY.SET_ENTITY_INVINCIBLE(pJet, true)
          VEHICLE.SET_VEHICLE_STRONG(pJet, true)
          VEHICLE.SET_VEHICLE_ALLOW_HOMING_MISSLE_LOCKON(pJet, false, 0)
          VEHICLE.SET_VEHICLE_DOOR_OPEN(pJet, 0, false, false)
          AUDIO.SET_VEH_RADIO_STATION(pJet, "RADIO_35_DLC_HEI4_MLR")
          jetBlip = HUD.ADD_BLIP_FOR_ENTITY(pJet)
          HUD.SET_BLIP_SPRITE(jetBlip, 423)
          HUD.SET_BLIP_SCALE(jetBlip, 1.2)
          table.insert(spawned_jet, pJet)
          while not STREAMING.HAS_MODEL_LOADED(pilotModel) do
            STREAMING.REQUEST_MODEL(pilotModel)
            coroutine.yield()
          end
          myGroup = PLAYER.GET_PLAYER_GROUP(self.get_ped())
          pilot = PED.CREATE_PED_INSIDE_VEHICLE(pJet, "PED_TYPE_CIVMALE", pilotModel, -1, true, false)
          ENTITY.SET_ENTITY_INVINCIBLE(pilot, true)
          table.insert(spawned_pilot, pilot)
          PED.SET_PED_AS_GROUP_MEMBER(pilot, myGroup)
          PED.SET_PED_CONFIG_FLAG(pilot, 251, true)
          PED.SET_PED_CONFIG_FLAG(pilot, 255, true)
          PED.SET_PED_CONFIG_FLAG(pilot, 398, true)
          PED.SET_PED_CONFIG_FLAG(pilot, 402, true)
          PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilot, true)
          privateJet:sleep(100)
          while not STREAMING.HAS_MODEL_LOADED(copilotModel) do
            STREAMING.REQUEST_MODEL(copilotModel)
            coroutine.yield()
          end
          copilot = PED.CREATE_PED_INSIDE_VEHICLE(pJet, "PED_TYPE_CIVMALE", copilotModel, 0, true, false)
          ENTITY.SET_ENTITY_INVINCIBLE(copilot, true)
          table.insert(spawned_pilot, copilot)
          PED.SET_PED_AS_GROUP_MEMBER(copilot, myGroup)
          PED.SET_PED_CONFIG_FLAG(copilot, 251, true)
          PED.SET_PED_CONFIG_FLAG(copilot, 255, true)
          PED.SET_PED_CONFIG_FLAG(copilot, 398, true)
          PED.SET_PED_CONFIG_FLAG(copilot, 402, true)
          PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(copilot, true)
        end)
      else
        gui.show_message("Billionaire Services", "You have already spawned a private jet.")
      end
    end
    ImGui.SameLine()
    if ImGui.Button("Dismiss Jet") then
      for k, v in ipairs(spawned_jet) do
        script.run_in_fiber(function()
          if ENTITY.DOES_ENTITY_EXIST(v) then
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(v, true, true)
              VEHICLE.DELETE_VEHICLE(v)
            table.remove(spawned_jet, k)
          end
        end)
      end
      for index, entity in ipairs(spawned_pilot) do
        script.run_in_fiber(function()
          if ENTITY.DOES_ENTITY_EXIST(entity) then
            ENTITY.DELETE_ENTITY(entity)
            table.remove(spawned_pilot, index)
          end
        end)
      end
    end
    if ImGui.Button("Fly Around Waypoint") then
      script.run_in_fiber(function(flyTo)
        local waypoint = HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID())
        if PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), pJet) then
          if HUD.DOES_BLIP_EXIST(waypoint) then
            destination = HUD.GET_BLIP_COORDS(waypoint)
          else
            gui.show_error("Private Jet", "Please set a waypoint on the map first!")
            return
          end
          TASK.TASK_VEHICLE_DRIVE_TO_COORD(pilot, pJet, airportData.taxiPos.x, airportData.taxiPos.y, airportData.taxiPos.z, 5.0, 0, 0xB79F589E, 8388614, -1.0, -1.0)
          flyTo:sleep(6000)
          CAM.DO_SCREEN_FADE_OUT(1000)
          flyTo:sleep(1000)
          CAM.DO_SCREEN_FADE_IN(1000)
          ENTITY.SET_ENTITY_COORDS(pJet, airportData.cutPos.x, airportData.cutPos.y, airportData.cutPos.z, true, true, true, true)
          VEHICLE.SET_VEHICLE_FORWARD_SPEED(pJet, 100.0) --360km/h
          VEHICLE.CONTROL_LANDING_GEAR(pJet, 1)
          TASK.TASK_PLANE_MISSION(pilot, pJet, 0, 0, destination.x, destination.y, destination.z + 600, 4, 100.0, 0, 90, 0, 0, 200)
          flyTo:sleep(500)
        else
          gui.show_message("Private Jet", "Get in your private jet to be able to fly around")
        end
      end)
    end
    ImGui.Spacing()
    ImGui.Spacing()
    ImGui.Text("Landing Options:")
    ImGui.Separator()
    if can_land then
      if ImGui.Button("Land At LSIA") then
        local jetPos      = ENTITY.GET_ENTITY_COORDS(pJet, false)
        local lsiaDist    = SYSTEM.VDIST(jetPos.x, jetPos.y, jetPos.z, -860.534, -1476.28, 286.833)
        local hangarDist  = SYSTEM.VDIST(jetPos.x, jetPos.y, jetPos.z, -979.294, -2993.9, 13.9451)
        script.run_in_fiber(function(lsia)
          if hangarDist <= 100 then
            gui.show_message("Private Jet", "Your private jet is already at LSIA!")
            return
          end
          if lsiaDist > 200 and lsiaDist <= 2000 then
            TASK.TASK_PLANE_LAND(pilot, pJet, -1305.79, -2148.72, 13.9446, -1663.04, -2775.99, 13.9447)
            lsia:sleep(1000)
            started_landing = true
            hangarPos       = vec3:new(-979.294, -2993.9, 13.9451)
            setHeading      = 50
          elseif lsiaDist > 2000 then
            TASK.TASK_PLANE_MISSION(pilot, pJet, 0, 0, -860.534, -1476.28, 286.833, 4, 100.0, 0, 90, 0, 0, 200)
          else
            gui.show_message("Private Jet", "Too close to airport!")
            return
          end
        end)
      end
      if ImGui.Button("Land In Fort Zancudo") then
        local jetPos        = ENTITY.GET_ENTITY_COORDS(pJet, false)
        local zancudoDist   = SYSTEM.VDIST(jetPos.x, jetPos.y, jetPos.z, -1487.91, 2553.82, 266.253)
        local hangarDist    = SYSTEM.VDIST(jetPos.x, jetPos.y, jetPos.z, -2140.81, 3255.64, 32.8103)
        script.run_in_fiber(function(zancudo)
          if hangarDist <= 100 then
            gui.show_message("Private Jet", "Your private jet is already in Fort Zancudo!")
            return
          end
          if zancudoDist > 200 and zancudoDist <= 2000 then
            TASK.TASK_PLANE_LAND(pilot, pJet, -1972.55, 2842.36, 32.8104, -2620.15, 3208.18, 32.8117)
            zancudo:sleep(1000)
            started_landing = true
            hangarPos       = vec3:new(-2140.81, 3255.64, 32.8103)
            setHeading      = 132
          elseif zancudoDist > 2000 then
            TASK.TASK_PLANE_MISSION(pilot, pJet, 0, 0, -1487.91, 2553.82, 266.253, 4, 100.0, 0, 90, 0, 0, 200)
          else
            gui.show_message("Private Jet", "Too close to airport!")
            return
          end
        end)
      end
      if ImGui.Button("Land In Sandy Shores") then
        local jetPos      = ENTITY.GET_ENTITY_COORDS(pJet, false)
        local sandyDist   = SYSTEM.VDIST(jetPos.x, jetPos.y, jetPos.z, 633.196, 2975.52, 263.214)
        local hangarDist  = SYSTEM.VDIST(jetPos.x, jetPos.y, jetPos.z, 1731.53, 3309.03, 41.2235)
        script.run_in_fiber(function(sandy)
          if hangarDist <= 100 then
            gui.show_message("Private Jet", "Your private jet is already in Sandy Shores!")
            return
          end
          if sandyDist > 200 and sandyDist <= 2000 then
            TASK.TASK_PLANE_LAND(pilot, pJet, 1052.2, 3068.35, 41.6282, 1715.62, 3261.5, 41.1267)
            sandy:sleep(1000)
            started_landing = true
            hangarPos       = vec3:new(1744.21, 3276.24, 41.1191)
            setHeading      = 150
          elseif sandyDist > 2000 then
            TASK.TASK_PLANE_MISSION(pilot, pJet, 0, 0, 633.196, 2975.52, 263.214, 4, 100.0, 0, 90, 0, 0, 200)
          else
            gui.show_message("Private Jet", "Too close to airport!")
            return
          end
        end)
      end
    else
      ImGui.Text("Gain some altitude to be able to see landing\noptions.")
    end
    ImGui.EndTabItem()
  end
  if ImGui.BeginTabItem("Private Security") then
    ImGui.Text("Choose a Bodyguard Group:")
    ImGui.PushItemWidth(280)
    displayGuards()
    ImGui.PopItemWidth()
    local bGuardData  = filteredGuards[bodyguard_index + 1]
    local myPos       = ENTITY.GET_ENTITY_COORDS(self.get_ped(), false)
    local forwardX    = ENTITY.GET_ENTITY_FORWARD_X(self.get_ped())
    local forwardY    = ENTITY.GET_ENTITY_FORWARD_Y(self.get_ped())
    local myHeading   = ENTITY.GET_ENTITY_HEADING(self.get_ped())
    invincile, used   = ImGui.Checkbox("Spawn in God Mode", invincile, true)
    if ImGui.Button("Spawn As Bodyguards") then
      if spawned_bodyguards[1] == nil then
        script.run_in_fiber(function()
          local myGroup = PLAYER.GET_PLAYER_GROUP(self.get_ped())
          while not STREAMING.HAS_MODEL_LOADED(bGuardData.modelHash.a) do
            STREAMING.REQUEST_MODEL(bGuardData.modelHash.a)
            coroutine.yield()
          end
          guard_1 = PED.CREATE_PED(bGuardData.pedType, bGuardData.modelHash.a, 0.0, 0.0, 0.0, 0.0, true, false)
          ENTITY.SET_ENTITY_COORDS_NO_OFFSET(guard_1, myPos.x + forwardX * 1.4, myPos.y + forwardY * 1.4, myPos.z, true, false, false)
          ENTITY.SET_ENTITY_HEADING(guard_1, myHeading - 180)
          PED.SET_PED_AS_GROUP_MEMBER(guard_1, myGroup)
          PED.SET_PED_NEVER_LEAVES_GROUP(guard_1, true)
          WEAPON.GIVE_WEAPON_TO_PED(guard_1, bGuardData.weaponHash, 9999, false, true)
          WEAPON.SET_PED_INFINITE_AMMO(guard_1, true, bGuardData.weaponHash)
          PED.SET_GROUP_FORMATION(myGroup, 2)
          PED.SET_GROUP_FORMATION_SPACING(myGroup, 3.0, 3.0, 1.0)
          table.insert(spawned_bodyguards, guard_1)
          pedConfig(guard_1)
          guard_1Blip = HUD.ADD_BLIP_FOR_ENTITY(guard_1)
          HUD.SET_BLIP_AS_FRIENDLY(guard_1Blip, true)
          HUD.SET_BLIP_SCALE(guard_1Blip, 0.8)
          HUD.SHOW_HEADING_INDICATOR_ON_BLIP(guard_1Blip, true)
          table.insert(guardBlips, guard_1Blip)
          if invincile then
            ENTITY.SET_ENTITY_INVINCIBLE(guard_1, true)
          end
          while not STREAMING.HAS_MODEL_LOADED(bGuardData.modelHash.b) do
            STREAMING.REQUEST_MODEL(bGuardData.modelHash.b)
            coroutine.yield()
          end
          guard_2 = PED.CREATE_PED(bGuardData.pedType, bGuardData.modelHash.b, 0.0, 0.0, 0.0, 0.0, true, false)
          ENTITY.SET_ENTITY_COORDS_NO_OFFSET(guard_2, myPos.x + forwardX * 1.4, myPos.y + forwardY * 1.4, myPos.z, true, false, false)
          ENTITY.SET_ENTITY_HEADING(guard_2, myHeading - 180)
          PED.SET_PED_AS_GROUP_MEMBER(guard_2, myGroup)
          PED.SET_PED_NEVER_LEAVES_GROUP(guard_2, true)
          WEAPON.GIVE_WEAPON_TO_PED(guard_2, bGuardData.weaponHash, 9999, false, true)
          WEAPON.SET_PED_INFINITE_AMMO(guard_2, true, bGuardData.weaponHash)
          PED.SET_GROUP_FORMATION(myGroup, 2)
          PED.SET_GROUP_FORMATION_SPACING(myGroup, 3.0, 3.0, 1.0)
          table.insert(spawned_bodyguards, guard_2)
          pedConfig(guard_2)
          guard_2Blip = HUD.ADD_BLIP_FOR_ENTITY(guard_2)
          HUD.SET_BLIP_AS_FRIENDLY(guard_2Blip, true)
          HUD.SET_BLIP_SCALE(guard_2Blip, 0.8)
          HUD.SHOW_HEADING_INDICATOR_ON_BLIP(guard_2Blip, true)
          table.insert(guardBlips, guard_2Blip)
          if invincile then
            ENTITY.SET_ENTITY_INVINCIBLE(guard_2, true)
          end
          while not STREAMING.HAS_MODEL_LOADED(bGuardData.modelHash.c) do
            STREAMING.REQUEST_MODEL(bGuardData.modelHash.c)
            coroutine.yield()
          end
          guard_3 = PED.CREATE_PED(bGuardData.pedType, bGuardData.modelHash.c, 0.0, 0.0, 0.0, 0.0, true, false)
          ENTITY.SET_ENTITY_COORDS_NO_OFFSET(guard_3, myPos.x + forwardX * 1.4, myPos.y + forwardY * 1.4, myPos.z, true, false, false)
          ENTITY.SET_ENTITY_HEADING(guard_3, myHeading - 180)
          PED.SET_PED_AS_GROUP_MEMBER(guard_3, myGroup)
          PED.SET_PED_NEVER_LEAVES_GROUP(guard_3, true)
          WEAPON.GIVE_WEAPON_TO_PED(guard_3, bGuardData.weaponHash, 9999, false, true)
          WEAPON.SET_PED_INFINITE_AMMO(guard_3, true, bGuardData.weaponHash)
          PED.SET_GROUP_FORMATION(myGroup, 2)
          PED.SET_GROUP_FORMATION_SPACING(myGroup, 3.0, 3.0, 1.0)
          table.insert(spawned_bodyguards, guard_3)
          pedConfig(guard_3)
          guard_3Blip = HUD.ADD_BLIP_FOR_ENTITY(guard_3)
          HUD.SET_BLIP_AS_FRIENDLY(guard_3Blip, true)
          HUD.SET_BLIP_SCALE(guard_3Blip, 0.8)
          HUD.SHOW_HEADING_INDICATOR_ON_BLIP(guard_3Blip, true)
          table.insert(guardBlips, guard_3Blip)
          if invincile then
            ENTITY.SET_ENTITY_INVINCIBLE(guard_3, true)
          end
        end)
      else
        gui.show_error("Private Security", "You have already spawned bodyguards. Dismiss them first.")
      end
    end
    ImGui.SameLine()
    if ImGui.Button("Spawn As Escorts") then
      dismissed = false
      if spawned_escorts[1] == nil then
        script.run_in_fiber(function(escort)
          local myGroup     = PLAYER.GET_PLAYER_GROUP(self.get_ped())
          local pedPos      = ENTITY.GET_ENTITY_COORDS(self.get_ped(), false)
          local pedHeading  = ENTITY.GET_ENTITY_HEADING(self.get_ped())
          local pedForwardX = ENTITY.GET_ENTITY_FORWARD_X(self.get_ped())
          local pedForwardY = ENTITY.GET_ENTITY_FORWARD_Y(self.get_ped())
          local retry       = 0
          while not STREAMING.HAS_MODEL_LOADED(bGuardData.vehicle) do
            STREAMING.REQUEST_MODEL(bGuardData.vehicle)
            escort:yield()
            if retry > 100 then
                return
            else
                retry = retry + 1
            end
          end
          escortCar = VEHICLE.CREATE_VEHICLE(bGuardData.vehicle, pedPos.x - (pedForwardX * 10), pedPos.y - (pedForwardY * 10), pedPos.z, pedHeading, true, false, false)
          VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(escortCar, 5.0)
          VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(escortCar, false)
          VEHICLE.SET_VEHICLE_ALLOW_HOMING_MISSLE_LOCKON(escortCar, false, 0)
          VEHICLE.SET_VEHICLE_STRONG(escortCar, true)
          ENTITY.SET_ENTITY_INVINCIBLE(escortCar, true)
          VEHICLE.SET_VEHICLE_MOD_KIT(escortCar, 0)
          VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(escortCar, "MRDR INC")
          VEHICLE.SET_VEHICLE_WINDOW_TINT(escortCar, 1) -- limo black windows
          VEHICLE.SET_VEHICLE_COLOURS(escortCar, bGuardData.vehCol, bGuardData.vehCol)
          VEHICLE.SET_VEHICLE_DISABLE_TOWING(escortCar, true)
          carBlip = HUD.ADD_BLIP_FOR_ENTITY(escortCar)
          HUD.SET_BLIP_SPRITE(carBlip, 229)
          HUD.SET_BLIP_SCALE(carBlip, 1.14)
          PED.SET_PED_VEHICLE_FORCED_SEAT_USAGE(self.get_ped(), escortCar, 2, 0, 0)
          table.insert(spawned_SUV, escortCar)
          escort:sleep(200)
          while not STREAMING.HAS_MODEL_LOADED(bGuardData.modelHash.a) do
            STREAMING.REQUEST_MODEL(bGuardData.modelHash.a)
            coroutine.yield()
          end
          escort_1 = PED.CREATE_PED_INSIDE_VEHICLE(escortCar, bGuardData.pedType, bGuardData.modelHash.a, -1, true, false)
          PED.SET_PED_AS_GROUP_MEMBER(escort_1, myGroup)
          PED.SET_PED_NEVER_LEAVES_GROUP(escort_1, true)
          PED.SET_PED_CAN_EVASIVE_DIVE(escort_1, true)
          PED.SET_DRIVER_AGGRESSIVENESS(escort_1, 1.0)
          WEAPON.GIVE_WEAPON_TO_PED(escort_1, bGuardData.weaponHash, 9999, false, true)
          WEAPON.SET_PED_INFINITE_AMMO(escort_1, true, bGuardData.weaponHash)
          PED.SET_GROUP_FORMATION(myGroup, 2)
          PED.SET_GROUP_FORMATION_SPACING(myGroup, 3.0, 3.0, 1.0)
          PED.SET_PED_VEHICLE_FORCED_SEAT_USAGE(escort_1, escortCar, -1, 0, 0)
          PED.SET_PED_CONFIG_FLAG(escort_1, 402, true)
          PED.SET_PED_CONFIG_FLAG(escort_1, 167, true)
          PED.SET_PED_CONFIG_FLAG(escort_1, 251, true)
          PED.SET_PED_CONFIG_FLAG(escort_1, 255, true)
          table.insert(spawned_escorts, escort_1)
          pedConfig(escort_1)
          escort_1Blip = HUD.ADD_BLIP_FOR_ENTITY(escort_1)
          HUD.SET_BLIP_AS_FRIENDLY(escort_1Blip, true)
          HUD.SET_BLIP_SCALE(escort_1Blip, 0.8)
          HUD.SHOW_HEADING_INDICATOR_ON_BLIP(escort_1Blip, true)
          if invincile then
            ENTITY.SET_ENTITY_INVINCIBLE(escort_1, true)
          end
          while not STREAMING.HAS_MODEL_LOADED(bGuardData.modelHash.b) do
            STREAMING.REQUEST_MODEL(bGuardData.modelHash.b)
            coroutine.yield()
          end
          escort_2 = PED.CREATE_PED_INSIDE_VEHICLE(escortCar, bGuardData.pedType, bGuardData.modelHash.b, 0, true, false)
          PED.SET_PED_AS_GROUP_MEMBER(escort_2, myGroup)
          PED.SET_PED_NEVER_LEAVES_GROUP(escort_2, true)
          WEAPON.GIVE_WEAPON_TO_PED(escort_2, bGuardData.weaponHash, 9999, false, true)
          WEAPON.SET_PED_INFINITE_AMMO(escort_2, true, bGuardData.weaponHash)
          PED.SET_GROUP_FORMATION(myGroup, 2)
          PED.SET_GROUP_FORMATION_SPACING(myGroup, 3.0, 3.0, 1.0)
          PED.SET_PED_VEHICLE_FORCED_SEAT_USAGE(escort_2, escortCar, 0, 0, 0)
          PED.SET_PED_CONFIG_FLAG(escort_2, 402, true)
          PED.SET_PED_CONFIG_FLAG(escort_2, 167, true)
          PED.SET_PED_CONFIG_FLAG(escort_2, 251, true)
          PED.SET_PED_CONFIG_FLAG(escort_2, 255, true)
          table.insert(spawned_escorts, escort_2)
          pedConfig(escort_2)
          escort_2Blip = HUD.ADD_BLIP_FOR_ENTITY(escort_2)
          HUD.SET_BLIP_AS_FRIENDLY(escort_2Blip, true)
          HUD.SET_BLIP_SCALE(escort_2Blip, 0.8)
          HUD.SHOW_HEADING_INDICATOR_ON_BLIP(escort_2Blip, true)
          if invincile then
            ENTITY.SET_ENTITY_INVINCIBLE(escort_2, true)
          end
          while not STREAMING.HAS_MODEL_LOADED(bGuardData.modelHash.c) do
            STREAMING.REQUEST_MODEL(bGuardData.modelHash.c)
            coroutine.yield()
          end
          escort_3 = PED.CREATE_PED_INSIDE_VEHICLE(escortCar, bGuardData.pedType, bGuardData.modelHash.c, 1, true, false)
          PED.SET_PED_AS_GROUP_MEMBER(escort_3, myGroup)
          PED.SET_PED_NEVER_LEAVES_GROUP(escort_3, true)
          WEAPON.GIVE_WEAPON_TO_PED(escort_3, bGuardData.weaponHash, 9999, false, true)
          WEAPON.SET_PED_INFINITE_AMMO(escort_3, true, bGuardData.weaponHash)
          PED.SET_GROUP_FORMATION(myGroup, 2)
          PED.SET_GROUP_FORMATION_SPACING(myGroup, 3.0, 3.0, 1.0)
          PED.SET_PED_VEHICLE_FORCED_SEAT_USAGE(escort_3, escortCar, 1, 0, 0)
          PED.SET_PED_CONFIG_FLAG(escort_3, 402, true)
          PED.SET_PED_CONFIG_FLAG(escort_3, 167, true)
          PED.SET_PED_CONFIG_FLAG(escort_3, 251, true)
          PED.SET_PED_CONFIG_FLAG(escort_3, 255, true)
          table.insert(spawned_escorts, escort_3)
          pedConfig(escort_3)
          escort_3Blip = HUD.ADD_BLIP_FOR_ENTITY(escort_3)
          HUD.SET_BLIP_AS_FRIENDLY(escort_3Blip, true)
          HUD.SET_BLIP_SCALE(escort_3Blip, 0.8)
          HUD.SHOW_HEADING_INDICATOR_ON_BLIP(escort_3Blip, true)
          if invincile then
            ENTITY.SET_ENTITY_INVINCIBLE(escort_3, true)
          end
          VEHICLE.SET_VEHICLE_ENGINE_ON(escortCar, true, false, false)
          gui.show_message("Private Security", "Your escort vehicle is waiting behind you.")
          escort:sleep(1000)
          AUDIO.SET_VEH_RADIO_STATION(escortCar, bGuardData.vehRadio)
        end)
      else
        gui.show_error("Private Security", "You have already spawned escorts. Dismiss them first.")
      end
    end
    if ImGui.Button(" Dismiss Bodyguards  ") then
      dismissedGuards = true
      if spawned_bodyguards[1] ~= nil then
        script.run_in_fiber(function(dismissGuards)
          if ENTITY.DOES_ENTITY_EXIST(guard_1) then
            if PED.IS_PED_SITTING_IN_ANY_VEHICLE(guard_1) then
              TASK.TASK_LEAVE_ANY_VEHICLE(guard_1, 100, 0)
            end
            TASK.TASK_GO_STRAIGHT_TO_COORD(guard_1, 2270.28, 3011.74, 45.6148, 1, 10000, 0, 0.0)
          end
          if ENTITY.DOES_ENTITY_EXIST(guard_2) then
            if PED.IS_PED_SITTING_IN_ANY_VEHICLE(guard_2) then
              TASK.TASK_LEAVE_ANY_VEHICLE(guard_2, 100, 0)
            end
            TASK.TASK_GO_STRAIGHT_TO_COORD(guard_2, 2270.28, 3011.74, 45.6148, 1, 10000, 0, 0.0)
          end
          if ENTITY.DOES_ENTITY_EXIST(guard_3) then
            if PED.IS_PED_SITTING_IN_ANY_VEHICLE(guard_3) then
              TASK.TASK_LEAVE_ANY_VEHICLE(guard_3, 100, 0)
            end
            TASK.TASK_GO_STRAIGHT_TO_COORD(guard_3, 2270.28, 3011.74, 45.6148, 1, 10000, 0, 0.0)
          end
          spawned_bodyguards = {}
          dismissGuards:sleep(20000)
          PED.DELETE_PED(guard_1)
          PED.DELETE_PED(guard_2)
          PED.DELETE_PED(guard_3)
        end)
      else
        gui.show_error("Private Security", "There are no bodyguards to dismiss!")
      end
    end
    ImGui.SameLine()
    if ImGui.Button("  Dismiss Escorts  ") then
      if dismissed then
        gui.show_error("Private Security", "Your private escort has already been dismissed!")
        return
      end
      if spawned_escorts[1] ~= nil then
        dismissed     = true
        doingDriveBy  = false
        doDonuts      = false
        doingBurnout  = false
        driveStarted  = false
        driveToWp     = false
        script.run_in_fiber(function(dismissEscorts)
          if sittingInEscortCar then
            TASK.TASK_LEAVE_VEHICLE(self.get_ped(), escortCar, 0)
            dismissEscorts:sleep(2000)
          end
          if ENTITY.DOES_ENTITY_EXIST(escortCar) then
            if escortLeftCar then
              TASK.CLEAR_PED_SECONDARY_TASK(escort_1)
              TASK.CLEAR_PED_SECONDARY_TASK(escort_2)
              TASK.CLEAR_PED_SECONDARY_TASK(escort_3)
              PED.SET_PED_CONFIG_FLAG(escort_1, 402, true)
              PED.SET_PED_CONFIG_FLAG(escort_2, 402, true)
              PED.SET_PED_CONFIG_FLAG(escort_3, 402, true)
              TASK.TASK_ENTER_VEHICLE(escort_1, escortCar, 10000, -1, 2.0, 1, 0, 0)
              TASK.TASK_ENTER_VEHICLE(escort_2, escortCar, 10000, 0, 2.0, 1, 0, 0)
              PED.SET_PED_INTO_VEHICLE(escort_3, escortCar, 1)
              escortLeftCar = false
              dismissEscorts:sleep(6000)
            end
            TASK.TASK_VEHICLE_DRIVE_WANDER(escort_1, escortCar, 25, 2883621)
            dismissEscorts:sleep(10000)
            spawned_escorts = {}
            TASK.CLEAR_PRIMARY_VEHICLE_TASK(escortCar)
            PED.DELETE_PED(escort_1)
            PED.DELETE_PED(escort_2)
            PED.DELETE_PED(escort_3)
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(escortCar, true, true)
            dismissEscorts:sleep(200)
            VEHICLE.DELETE_VEHICLE(escortCar)
            dismissed = false
          else
            TASK.TASK_GO_STRAIGHT_TO_COORD(escort_1, 2270.28, 3011.74, 45.6148, 1, 10000, 0, 0.0)
            TASK.TASK_GO_STRAIGHT_TO_COORD(escort_2, 2270.28, 3011.74, 45.6148, 1, 10000, 0, 0.0)
            TASK.TASK_GO_STRAIGHT_TO_COORD(escort_3, 2270.28, 3011.74, 45.6148, 1, 10000, 0, 0.0)
            dismissEscorts:sleep(10000)
            PED.DELETE_PED(escort_1)
            PED.DELETE_PED(escort_2)
            PED.DELETE_PED(escort_3)
            spawned_escorts = {}
            dismissed = false
          end
        end)
        gui.show_message("Private Security", "Security escort service has been dismissed.")
      else
        gui.show_error("Private Security", "There are no security escorts to dismiss!")
      end
    end
    if spawned_escorts[1] ~= nil then
      ImGui.Spacing();ImGui.SameLine();ImGui.Spacing();ImGui.SameLine();ImGui.Spacing();ImGui.SameLine();ImGui.Spacing();ImGui.SameLine();ImGui.Spacing();ImGui.SameLine();ImGui.Spacing();
      ImGui.SameLine();ImGui.Dummy(20, 1);ImGui.SameLine()
      if not escortLeftCar then
        if ImGui.Button("Ask To Leave Vehicle") then
          if not taskInProgress then
            script.run_in_fiber(function()
              if ENTITY.DOES_ENTITY_EXIST(escort_1) and not ENTITY.IS_ENTITY_DEAD(escort_1) then
                PED.SET_PED_CONFIG_FLAG(escort_1, 402, false)
                TASK.TASK_LEAVE_VEHICLE(escort_1, escortCar, 1)
              end
              if ENTITY.DOES_ENTITY_EXIST(escort_2) and not ENTITY.IS_ENTITY_DEAD(escort_2) then
                PED.SET_PED_CONFIG_FLAG(escort_2, 402, false)
                TASK.TASK_LEAVE_VEHICLE(escort_2, escortCar, 1)
              end
              if ENTITY.DOES_ENTITY_EXIST(escort_3) and not ENTITY.IS_ENTITY_DEAD(escort_3) then
                PED.SET_PED_CONFIG_FLAG(escort_3, 402, false)
                TASK.TASK_LEAVE_VEHICLE(escort_3, escortCar, 1)
              end
              escortLeftCar = true
            end)
          else
            gui.show_message("Private Security", "Stop "..currentTask.." first.")
            return
          end
        end
      end
      if escortLeftCar then
        if ImGui.Button("Get Back In The Vehicle") then
          script.run_in_fiber(function()
            if ENTITY.DOES_ENTITY_EXIST(escort_1) and not ENTITY.IS_ENTITY_DEAD(escort_1) then
              PED.SET_PED_CONFIG_FLAG(escort_1, 402, true)
              TASK.TASK_ENTER_VEHICLE(escort_1, escortCar, 10000, -1, 2.0, 1, 0, 0)
            end
            if ENTITY.DOES_ENTITY_EXIST(escort_2) and not ENTITY.IS_ENTITY_DEAD(escort_2) then
              PED.SET_PED_CONFIG_FLAG(escort_2, 402, true)
              TASK.TASK_ENTER_VEHICLE(escort_2, escortCar, 10000, 0, 2.0, 1, 0, 0)
            end
            if ENTITY.DOES_ENTITY_EXIST(escort_3) and not ENTITY.IS_ENTITY_DEAD(escort_3) then
              PED.SET_PED_CONFIG_FLAG(escort_3, 402, true)
              TASK.CLEAR_PED_TASKS_IMMEDIATELY(escort_3)
              PED.SET_PED_INTO_VEHICLE(escort_3, escortCar, 1) --would stop responding if tasked with entering the vehicle like the other two so I'm just teleporting them directly into the vehicle.
            end
            escortLeftCar = false
          end)
        end
      end
      ImGui.Dummy(120, 1);ImGui.SameLine()
      if ImGui.Button("Repair Vehicle") then
        script.run_in_fiber(function()
        VEHICLE.SET_VEHICLE_FIXED(escortCar)
        VEHICLE.SET_VEHICLE_DEFORMATION_FIXED(escortCar)
        end)
      end
    end
    ImGui.Spacing();ImGui.Spacing()
    ImGui.Text("More Options:")
    ImGui.Separator()
    ImGui.Spacing()
    if sittingInEscortCar then
      if ImGui.Button("Drive To Waypoint") then
        script.run_in_fiber(function()
          local waypoint = HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID())
          if HUD.DOES_BLIP_EXIST(waypoint) then
            destination = HUD.GET_BLIP_COORDS(waypoint)
          else
            gui.show_error("Private Security", "Please set a waypoint on the map first!")
            return
          end
          if escortLeftCar then
            TASK.CLEAR_PED_SECONDARY_TASK(escort_1)
            TASK.CLEAR_PED_SECONDARY_TASK(escort_2)
            TASK.CLEAR_PED_SECONDARY_TASK(escort_3)
            PED.SET_PED_CONFIG_FLAG(escort_1, 402, true)
            PED.SET_PED_CONFIG_FLAG(escort_2, 402, true)
            PED.SET_PED_CONFIG_FLAG(escort_3, 402, true)
            TASK.TASK_ENTER_VEHICLE(escort_1, escortCar, 10000, -1, 2.0, 1, 0, 0)
            TASK.TASK_ENTER_VEHICLE(escort_2, escortCar, 10000, 0, 2.0, 1, 0, 0)
            PED.SET_PED_INTO_VEHICLE(escort_3, escortCar, 1)
            escortLeftCar = false
            cruisin:sleep(5000)
          end
          TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(escort_1, escortCar, destination.x, destination.y, destination.z, 25, 2883621, 20.0)
          driveToWp       = true
          driveStarted    = false
          doingBurnout    = false
          doingDriveBy    = false
          doDonuts        = false
          taskInProgress  = true
          currentTask     = "driving to waypoint"
        end)
      end
      ImGui.SameLine();ImGui.Spacing();ImGui.SameLine()
      if ImGui.Button("Cruise Around") then
        script.run_in_fiber(function(cruisin)
          if escortLeftCar then
            TASK.CLEAR_PED_SECONDARY_TASK(escort_1)
            TASK.CLEAR_PED_SECONDARY_TASK(escort_2)
            TASK.CLEAR_PED_SECONDARY_TASK(escort_3)
            PED.SET_PED_CONFIG_FLAG(escort_1, 402, true)
            PED.SET_PED_CONFIG_FLAG(escort_2, 402, true)
            PED.SET_PED_CONFIG_FLAG(escort_3, 402, true)
            TASK.TASK_ENTER_VEHICLE(escort_1, escortCar, 10000, -1, 2.0, 1, 0, 0)
            TASK.TASK_ENTER_VEHICLE(escort_2, escortCar, 10000, 0, 2.0, 1, 0, 0)
            PED.SET_PED_INTO_VEHICLE(escort_3, escortCar, 1)
            escortLeftCar = false
            cruisin:sleep(5000)
          end
          TASK.TASK_VEHICLE_DRIVE_WANDER(escort_1, escortCar, 25, 786603)
          cruisin:sleep(500)
          driveStarted    = true
          driveToWp       = false
          doingBurnout    = false
          doingDriveBy    = false
          doDonuts        = false
          taskInProgress  = true
          currentTask     = "cruising around"
        end)
      end
      if driveStarted or driveToWp then
        ImGui.SameLine()
        if ImGui.Button(" Stop ") then
          script.run_in_fiber(function()
            TASK.CLEAR_PED_TASKS(escort_1)
            TASK.CLEAR_PED_SECONDARY_TASK(escort_1)
            TASK.CLEAR_PRIMARY_VEHICLE_TASK(escortCar)
            TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, 1, 2000)
            driveStarted    = false
            driveToWp       = false
            wpReached       = false
            taskInProgress  = false
            currentTask     = "None."
          end)
        end
      end
      ImGui.Text("Start Doing a Burnout.")
      if ImGui.Button("Do Burnout") then
        doingBurnout    = true
        driveStarted    = false
        driveToWp       = false
        doingDriveBy    = false
        doDonuts        = false
        taskInProgress  = true
        currentTask     = "doing a burnout"
        script.run_in_fiber(function(burnout)
          TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, 30, 1000000)
          if escortLeftCar then
            TASK.CLEAR_PED_SECONDARY_TASK(escort_2)
            TASK.CLEAR_PED_SECONDARY_TASK(escort_3)
            PED.SET_PED_CONFIG_FLAG(escort_2, 402, true)
            PED.SET_PED_CONFIG_FLAG(escort_3, 402, true)
            TASK.TASK_ENTER_VEHICLE(escort_1, escortCar, 10000, -1, 2.0, 1, 0, 0)
            TASK.TASK_ENTER_VEHICLE(escort_2, escortCar, 10000, 0, 2.0, 1, 0, 0)
            PED.SET_PED_INTO_VEHICLE(escort_3, escortCar, 1)
            escortLeftCar = false
            burnout:sleep(5000)
          end
        end)
      end
      if doingBurnout then
        ImGui.SameLine()
          if ImGui.Button("   Stop   ") then
            script.run_in_fiber(function()
              TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, 1, 1000)
              doingBurnout    = false
              taskInProgress  = false
              currentTask     = "None."
            end)
          end
      end
      ImGui.Text("Start Doing Donuts");ImGui.SameLine();ImGui.TextDisabled("(?)")
      if ImGui.IsItemHovered() then
        ImGui.BeginTooltip()
        ImGui.Text("You can use the \"Change Direction\" button\nto turn donuts into mad drifts.")
        ImGui.EndTooltip()
      end
      if ImGui.Button("Do Donuts") then
        script.run_in_fiber(function(donuts)
          if not VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(escortCar) then
            VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(escortCar, 5.0)
          end
          if escortLeftCar then
            TASK.CLEAR_PED_SECONDARY_TASK(escort_1)
            TASK.CLEAR_PED_SECONDARY_TASK(escort_2)
            TASK.CLEAR_PED_SECONDARY_TASK(escort_3)
            PED.SET_PED_CONFIG_FLAG(escort_1, 402, true)
            PED.SET_PED_CONFIG_FLAG(escort_2, 402, true)
            PED.SET_PED_CONFIG_FLAG(escort_3, 402, true)
            TASK.TASK_ENTER_VEHICLE(escort_1, escortCar, 10000, -1, 2.0, 1, 0, 0)
            TASK.TASK_ENTER_VEHICLE(escort_2, escortCar, 10000, 0, 2.0, 1, 0, 0)
            PED.SET_PED_INTO_VEHICLE(escort_3, escortCar, 1)
            escortLeftCar = false
            donuts:sleep(5000)
          end
          doDonuts        = true
          doingBurnout    = false
          driveStarted    = false
          driveToWp       = false
          doingDriveBy    = false
          taskInProgress  = true
          currentTask     = "doing MAAAD donuts"
        end)
      end
      if doDonuts then
        ImGui.SameLine()
        if ImGui.Button("Change Direction") then
          if donutDirection == 7 then
           donutDirection   = donutDirection + 1
          else
            donutDirection  = donutDirection - 1
          end
        end
        ImGui.SameLine()
        if ImGui.Button("   Stop  ") then
          script.run_in_fiber(function()
            TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, 1, 1000)
            VEHICLE.SET_DRIFT_TYRES(escortCar, false)
            VEHICLE.SET_VEHICLE_REDUCE_GRIP(escortCar, false)
            VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(escortCar, 1.0)
            TASK.CLEAR_PRIMARY_VEHICLE_TASK(escortCar)
          end)
          doDonuts        = false
          taskInProgress  = false
          currentTask     = "None."
        end
      end
      ImGui.Text("Start Shooting Random Civilians")
      if ImGui.Button("Start Driveby") then
        script.run_in_fiber(function(driveBy)
          if escortLeftCar then
            TASK.CLEAR_PED_SECONDARY_TASK(escort_1)
            TASK.CLEAR_PED_SECONDARY_TASK(escort_2)
            TASK.CLEAR_PED_SECONDARY_TASK(escort_3)
            PED.SET_PED_CONFIG_FLAG(escort_1, 402, true)
            PED.SET_PED_CONFIG_FLAG(escort_2, 402, true)
            PED.SET_PED_CONFIG_FLAG(escort_3, 402, true)
            TASK.TASK_ENTER_VEHICLE(escort_1, escortCar, 10000, -1, 2.0, 1, 0, 0)
            TASK.TASK_ENTER_VEHICLE(escort_2, escortCar, 10000, 0, 2.0, 1, 0, 0)
            PED.SET_PED_INTO_VEHICLE(escort_3, escortCar, 1)
            escortLeftCar = false
            driveBy:sleep(5000)
          end
          doingDriveBy    = true
          doDonuts        = false
          doingBurnout    = false
          driveStarted    = false
          driveToWp       = false
          taskInProgress  = true
          currentTask     = "shooting innocent people"
        end)
      end
      if doingDriveBy then
        ImGui.SameLine()
        if ImGui.Button("   Stop  ") then
          script.run_in_fiber(function()
            TASK.CLEAR_PED_TASKS(escort_1)
            TASK.CLEAR_PED_SECONDARY_TASK(escort_1)
            TASK.CLEAR_PRIMARY_VEHICLE_TASK(escortCar)
            TASK.CLEAR_PED_TASKS(escort_2)
            TASK.CLEAR_PED_TASKS(escort_3)
            TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, 1, 1000)
            doingDriveBy    = false
            taskInProgress  = false
            currentTask     = "None."
          end)
        end
      end
    else
      ImGui.Text("Your private escort can follow your car and\ncan drive you around as well.\nGet in the escort vehicle to see more options.")
    end
    ImGui.EndTabItem()
  end
  if ImGui.BeginTabItem("Private Limo") then
    ImGui.Spacing();ImGui.Spacing()
    if ImGui.Button("   Call Limo   ") then
      if spawned_limo[1] == nil then
        script.run_in_fiber(function(limoService)
          local pedPos      = ENTITY.GET_ENTITY_COORDS(self.get_ped(), false)
          local pedHeading  = ENTITY.GET_ENTITY_HEADING(self.get_ped())
          local pedForwardX = ENTITY.GET_ENTITY_FORWARD_X(self.get_ped())
          local pedForwardY = ENTITY.GET_ENTITY_FORWARD_Y(self.get_ped())
          local myGroup     = PLAYER.GET_PLAYER_GROUP(self.get_ped())
          local retry       = 0
          while not STREAMING.HAS_MODEL_LOADED(0xE6E967F8) do
            STREAMING.REQUEST_MODEL(0xE6E967F8)
            limoService:yield()
            if retry > 100 then
                return
            else
                retry = retry + 1
            end
          end
          limo = VEHICLE.CREATE_VEHICLE(0xE6E967F8, pedPos.x + (pedForwardX * 10), pedPos.y + (pedForwardY * 10), pedPos.z, pedHeading, true, false, false)
          VEHICLE.SET_VEHICLE_MOD_KIT(escortCar, 0)
          VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(limo, "BALL3R")
          VEHICLE.SET_VEHICLE_WINDOW_TINT(escortCar, 1) -- limo black windows //
          VEHICLE.SET_VEHICLE_COLOURS(limo, 111, 111)
          VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(limo, false)
          VEHICLE.SET_VEHICLE_INDIVIDUAL_DOORS_LOCKED(limo, 0, 2)
          VEHICLE.SET_VEHICLE_INDIVIDUAL_DOORS_LOCKED(limo, 1, 2)
          VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(limo, false)
          VEHICLE.SET_VEHICLE_ALLOW_HOMING_MISSLE_LOCKON(limo, false, 0)
          VEHICLE.SET_VEHICLE_STRONG(limo, true)
          VEHICLE.SET_VEHICLE_DISABLE_TOWING(limo, true)
          ENTITY.SET_ENTITY_INVINCIBLE(limo, true)
          limoBlip = HUD.ADD_BLIP_FOR_ENTITY(limo)
          HUD.SET_BLIP_SPRITE(limoBlip, 724)
          HUD.SET_BLIP_SCALE(limoBlip, 1.12)
          table.insert(spawned_limo, limo)
          limoService:sleep(500)
          while not STREAMING.HAS_MODEL_LOADED(0xE75B4B1C) do
            STREAMING.REQUEST_MODEL(0xE75B4B1C)
            coroutine.yield()
          end
          limoDriver = PED.CREATE_PED("PED_TYPE_CIVMALE", 0xE75B4B1C, pedPos.x + (pedForwardX * 10), pedPos.y + (pedForwardY * 10), pedPos.z, pedHeading, true, false)
          PED.SET_PED_INTO_VEHICLE(limoDriver, limo, -1)
          PED.SET_PED_AS_GROUP_MEMBER(limoDriver, myGroup)
          PED.SET_PED_CONFIG_FLAG(limoDriver, 402, true)
          PED.SET_PED_CONFIG_FLAG(limoDriver, 398, true)
          PED.SET_PED_CONFIG_FLAG(limoDriver, 167, true)
          PED.SET_PED_CONFIG_FLAG(limoDriver, 251, true)
          PED.SET_PED_CONFIG_FLAG(limoDriver, 255, true)
          VEHICLE.SET_VEHICLE_ENGINE_ON(limo, true, false, false)
          table.insert(spawned_driver, limoDriver)
          limoService:sleep(1000)
          AUDIO.SET_VEH_RADIO_STATION(limo, "RADIO_22_DLC_BATTLE_MIX1_RADIO")
        end)
      end
    end
    ImGui.SameLine();ImGui.Spacing();ImGui.SameLine();ImGui.Spacing();ImGui.SameLine();ImGui.Spacing();ImGui.SameLine();ImGui.Spacing();ImGui.SameLine();ImGui.Spacing();ImGui.SameLine();ImGui.Spacing();ImGui.SameLine();ImGui.Spacing();ImGui.SameLine();ImGui.Spacing();ImGui.SameLine();ImGui.Spacing();ImGui.SameLine()
    if ImGui.Button("   Dismiss   ") then
      if spawned_limo[1] ~= nil then
        script.run_in_fiber(function(dismissLimo)
          TASK.TASK_VEHICLE_DRIVE_WANDER(limoDriver, limo, 25, 2883621)
          dismissLimo:sleep(10000)
          TASK.CLEAR_PRIMARY_VEHICLE_TASK(limo)
          PED.DELETE_PED(limoDriver)
          ENTITY.SET_ENTITY_AS_MISSION_ENTITY(limo, true, true)
          dismissLimo:sleep(200)
          VEHICLE.DELETE_VEHICLE(limo)
        end)
      else
        gui.show_error("Private Limo", "There is no limo to dismiss!")
      end
    end
    ImGui.Spacing();ImGui.Spacing()
    ImGui.Text("Limo Options:")
    ImGui.Separator()
    if sittingInLimo then
      ImGui.Spacing();ImGui.Spacing()
      if ImGui.Button("Drive To Waypoint") then
        script.run_in_fiber(function(limoService)
          local waypoint = HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID())
          if HUD.DOES_BLIP_EXIST(waypoint) then
            destination = HUD.GET_BLIP_COORDS(waypoint)
          else
            gui.show_error("Private Limo", "Please set a waypoint on the map first!")
            return
          end
            TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(limoDriver, limo, destination.x, destination.y, destination.z, 25, 786603, 1.0)
            limoService:sleep(500)
            limoStarted = true
            gui.show_message("Private Limo", "Driving to waypoint...")
        end)
      end
      ImGui.SameLine()ImGui.Spacing();ImGui.SameLine()ImGui.SameLine();ImGui.Spacing();ImGui.SameLine()ImGui.SameLine();ImGui.Spacing();ImGui.SameLine();ImGui.Spacing();ImGui.SameLine()
      if ImGui.Button(" Cruise Around ") then
        limoStarted = true
        script.run_in_fiber(function(limoService)
          TASK.TASK_VEHICLE_DRIVE_WANDER(limoDriver, limo, 25, 786603)
          limoService:sleep(500)
        end)
        gui.show_message("Private Limo", "Going for a ride...")
      end
      if limoStarted then
        if ImGui.Button("   Cancel    ") then
          script.run_in_fiber(function()
            TASK.CLEAR_PED_TASKS(limoDriver)
            TASK.CLEAR_PED_SECONDARY_TASK(limoDriver)
            TASK.CLEAR_PRIMARY_VEHICLE_TASK(limo)
            TASK.TASK_VEHICLE_TEMP_ACTION(limoDriver, limo, 1, 2000)
            limoStarted = false
          end)
        end
      end
    else
      ImGui.Text("Get inside the limo to see the options.")
    end
    ImGui.EndTabItem()
  end
  --------------------debug section------------------------------------------------------------------------------
  ImGui.Spacing()
  ImGui.TextDisabled("_")
  if ImGui.IsItemHovered() and ImGui.IsItemClicked(0) then
    bsDebug = not bsDebug
  end
  if bsDebug then
    ImGui.Separator()
    if ImGui.Button("Debug Stuff") then
      script.run_in_fiber(function()
        local myPos = ENTITY.GET_ENTITY_COORDS(self.get_ped())
        retVal = PED.IS_ANY_PED_SHOOTING_IN_AREA(myPos.x - 10, myPos.y - 10, myPos.z - 10, myPos.x + 10, myPos.y + 10, myPos.z + 10, false, false)
        -- local myPos = ENTITY.GET_ENTITY_COORDS(self.get_ped(), false)
        -- local jetSpeed = (ENTITY.GET_ENTITY_SPEED(pJet) * 3.6)
        -- local debugJetHeading = ENTITY.GET_ENTITY_HEADING(pJet)
        -- local jetPos = ENTITY.GET_ENTITY_COORDS(pJet, false)
        -- local JetAltitude = jetPos.z
        -- local vDist = SYSTEM.VDIST(jetPos.x, jetPos.y, jetPos.z, -1643.2, -2773.15, 13.9447)
        -- local shooterPos = ENTITY.GET_ENTITY_COORDS(escort_1, false)
        -- -- local randomPed = PED.GET_CLOSEST_PED(shooterPos.x, shooterPos.y, shooterPos.z, 400, 1, 0, 0, 0, 0, 0)
        -- local randomVeh = VEHICLE.GET_CLOSEST_VEHICLE(shooterPos.x, shooterPos.y, shooterPos.z, 400, 0, 70)
        -- local randomPed = nearestPed(self.get_ped())
        -- local pedCoords = ENTITY.GET_ENTITY_COORDS(randomPed, false)
        -- log.debug("My Position: "..tostring(myPos))
        -- log.debug("Distance: "..tostring(vDist))
        -- log.debug("Jet Speed: "..tostring(jetSpeed))
        -- log.debug("in_car: "..tostring(sittingInEscortCar))
        -- log.debug("jet alt: "..tostring(JetAltitude))
        -- log.debug("bool check: "..tostring(dismissed))
        -- log.debug("car blip: "..tostring(carBlip))
        -- log.debug("shooter pos: "..tostring(shooterPos))
        -- log.debug("randomPedCoords: "..tostring(pedCoords))
        -- log.debug("randomVeh: "..tostring(randomVeh))
        -- log.debug("randomPed: "..tostring(randomPed))
        log.debug("randomPed: "..tostring(retVal))
      end)
    end
  end
  -------------------------------------------------------------------------------------------------------------
end)
script.register_looped("blipManager", function(bilpMgr)
  if HUD.DOES_BLIP_EXIST(jetBlip) then
    if PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), pJet) then
        HUD.SET_BLIP_ALPHA(jetBlip, 0.0)
    else
      HUD.SET_BLIP_ALPHA(jetBlip, 1000.0)
    end
  end
  if HUD.DOES_BLIP_EXIST(carBlip) then
    if PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), escortCar) then
        HUD.SET_BLIP_ALPHA(carBlip, 0.0)
    else
      HUD.SET_BLIP_ALPHA(carBlip, 1000.0)
    end
    if PED.IS_PED_IN_VEHICLE(escort_1, escortCar, false) then
      HUD.SET_BLIP_ALPHA(escort_1Blip, 0.0)
    else
      HUD.SET_BLIP_ALPHA(escort_1Blip, 1000.0)
    end
    if PED.IS_PED_IN_VEHICLE(escort_2, escortCar, false) then
      HUD.SET_BLIP_ALPHA(escort_2Blip, 0.0)
    else
      HUD.SET_BLIP_ALPHA(escort_2Blip, 1000.0)
    end
    if PED.IS_PED_IN_VEHICLE(escort_3, escortCar, false) then
      HUD.SET_BLIP_ALPHA(escort_3Blip, 0.0)
    else
      HUD.SET_BLIP_ALPHA(escort_3Blip, 1000.0)
    end
  end
  if HUD.DOES_BLIP_EXIST(limoBlip) then
    if PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), limo) then
        HUD.SET_BLIP_ALPHA(limoBlip, 0.0)
    else
      HUD.SET_BLIP_ALPHA(limoBlip, 1000.0)
    end
  end
  for _, v in ipairs(guardBlips) do
    if HUD.DOES_BLIP_EXIST(v) then
      for key, guard in ipairs(spawned_bodyguards) do
        if PED.IS_PED_SITTING_IN_ANY_VEHICLE(guard) then
          HUD.SET_BLIP_ALPHA(v, 0.0)
        else
          HUD.SET_BLIP_ALPHA(v, 1000.0)
        end
        if ENTITY.IS_ENTITY_DEAD(guard) then
          bilpMgr:sleep(3000)
          PED.DELETE_PED(guard)
          table.remove(spawned_bodyguards, key)
        end
      end
      for index, escort in ipairs(spawned_escorts) do
        if PED.IS_PED_SITTING_IN_ANY_VEHICLE(escort) then
          HUD.SET_BLIP_ALPHA(v, 0.0)
        else
          HUD.SET_BLIP_ALPHA(v, 1000.0)
        end
        if ENTITY.IS_ENTITY_DEAD(escort) then
          bilpMgr:sleep(3000)
          PED.DELETE_PED(escort)
          table.remove(spawned_escorts, index)
        end
      end
    end
  end
end)
script.register_looped("services", function(services)
  if spawned_bodyguards[1] ~= nil then
    if PED.IS_PED_IN_MELEE_COMBAT(self.get_ped()) then
      local enemy = PED.GET_PED_TARGET_FROM_COMBAT_PED(self.get_ped(), 1)
      TASK.TASK_COMBAT_PED(guard_1, enemy, 0, 16)
      TASK.TASK_COMBAT_PED(guard_2, enemy, 0, 16)
      TASK.TASK_COMBAT_PED(guard_3, enemy, 0, 16)
    end
    if dismissedGuards then
      HUD.SET_BLIP_ALPHA(guard_1Blip, 100.0)
      HUD.SET_BLIP_ALPHA(guard_2Blip, 100.0)
      HUD.SET_BLIP_ALPHA(guard_3Blip, 100.0)
    end
  end
  if spawned_escorts[1] ~= nil then
    if PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), escortCar) then
      sittingInEscortCar = true
    else
      sittingInEscortCar = false
    end
    if driveStarted or driveToWp then
      if not sittingInEscortCar then
        TASK.CLEAR_PED_TASKS(escort_1)
        TASK.CLEAR_PED_SECONDARY_TASK(escort_1)
        TASK.CLEAR_PRIMARY_VEHICLE_TASK(escortCar)
        TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, 1, 2000)
        driveStarted  = false
        driveToWp     = false
      end
    end
    if driveToWp then
      if ENTITY.DOES_ENTITY_EXIST(escortCar) then
        local wp = HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID())
        if HUD.DOES_BLIP_EXIST(wp) then
          local vehCoods  = ENTITY.GET_ENTITY_COORDS(escortCar)
          local wpCoords  = HUD.GET_BLIP_COORDS(wp)
          local dist      = SYSTEM.VDIST(vehCoods.x, vehCoods.y, vehCoods.z, wpCoords.x, wpCoords.y, wpCoords.z)
          if dist <= 50.0 then
            driveToWp = false
            services:sleep(1000)
            gui.show_message("Private Security", "You have reached your destination.")
          end
        else
          TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, 1, 2000)
          driveToWp = false
        end
      else
        driveToWp = false
      end
    end
    if dismissed then
      if HUD.DOES_BLIP_EXIST(carBlip) then
        HUD.SET_BLIP_ALPHA(carBlip, 100.0)
      end
    end
    if ENTITY.DOES_ENTITY_EXIST(escortCar) then
      if ENTITY.IS_ENTITY_DEAD(escort_1) and ENTITY.IS_ENTITY_DEAD(escort_2) and ENTITY.IS_ENTITY_DEAD(escort_3) then
        if HUD.DOES_BLIP_EXIST(carBlip) then
          HUD.SET_BLIP_ALPHA(carBlip, 0.0)
        end
        VEHICLE.SET_VEHICLE_DOORS_SHUT(escortCar, true)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(escortCar, true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(escortCar, true, true)
        services:sleep(5000)
        VEHICLE.DELETE_VEHICLE(escortCar)
      end
      if not PED.IS_PED_SITTING_IN_VEHICLE(escort_1, escortCar) then
        local tryingToEnter = PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(self.get_ped())
        if tryingToEnter == escortCar then
          local side = PED.GET_SEAT_PED_IS_TRYING_TO_ENTER(self.get_ped())
          if side ~= 2 then
            TASK.CLEAR_PED_TASKS(self.get_ped())
            TASK.TASK_ENTER_VEHICLE(self.get_ped(), escortCar, 10000, 2, 2.0, 1, 0, 0)
          end
        end
      end
    end
    if ENTITY.DOES_ENTITY_EXIST(escort_1) and ENTITY.IS_ENTITY_DEAD(escort_1) then
      PED.DELETE_PED(escort_1)
    end
    if ENTITY.DOES_ENTITY_EXIST(escort_2) and ENTITY.IS_ENTITY_DEAD(escort_2) then
      PED.DELETE_PED(escort_2)
    end
    if ENTITY.DOES_ENTITY_EXIST(escort_3) and ENTITY.IS_ENTITY_DEAD(escort_3) then
      PED.DELETE_PED(escort_3)
    end
  end
  if spawned_limo[1] ~= nil then
    if PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), limo) then
      sittingInLimo = true
    else
      sittingInLimo = false
    end
    if limoStarted then
      if not sittingInLimo then
        TASK.CLEAR_PED_TASKS(limoDriver)
        TASK.CLEAR_PED_SECONDARY_TASK(limoDriver)
        TASK.CLEAR_PRIMARY_VEHICLE_TASK(limo)
        TASK.TASK_VEHICLE_TEMP_ACTION(limoDriver, limo, 1, 2000)
        limoStarted = false
      end
    end
  end
end)
script.register_looped("jet manager", function(jetMgr)
  local jetPos = ENTITY.GET_ENTITY_COORDS(pJet, false)
  local jetAltitude = jetPos.z
  if PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), pJet) then
    if jetAltitude >= 150 then
      can_land = true
    else
      can_land = false
    end
  end
  if started_landing then
    if (ENTITY.GET_ENTITY_SPEED(pJet) * 3.6) <= 10.0 then
      TASK.CLEAR_PED_TASKS(pilot)
      TASK.CLEAR_PED_SECONDARY_TASK(pilot)
      TASK.CLEAR_PRIMARY_VEHICLE_TASK(pJet)
      VEHICLE.BRING_VEHICLE_TO_HALT(pJet, 5.0, 2000, true)
      jetMgr:sleep(1500)
      CAM.DO_SCREEN_FADE_OUT(1000)
      jetMgr:sleep(1000)
      CAM.DO_SCREEN_FADE_IN(1000)
      ENTITY.SET_ENTITY_COORDS(pJet, hangarPos.x, hangarPos.y, hangarPos.z, true, true, true, true)
      ENTITY.SET_ENTITY_HEADING(pJet, setHeading)
      VEHICLE.SET_VEHICLE_DOOR_OPEN(pJet, 0, false, false)
      jetMgr:sleep(500)
      started_landing = false
    end
  end
end)
script.register_looped("Escort In/Out", function()
  if PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) and not sittingInEscortCar then
    if PAD.IS_CONTROL_PRESSED(0, 23) and not dismissed then
      PED.SET_PED_CONFIG_FLAG(escort_2, 402, false)
      PED.SET_PED_CONFIG_FLAG(escort_3, 402, false)
      TASK.TASK_LEAVE_VEHICLE(escort_2, escortCar, 1)
      TASK.TASK_LEAVE_VEHICLE(escort_3, escortCar, 1)
      escortLeftCar = true
    end
  end
end)
script.register_looped("misc", function(misc)
  misc:yield()
  if PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) and not sittingInEscortCar then
    local myVeh   = PED.GET_VEHICLE_PED_IS_USING(self.get_ped())
    local mySpeed = ENTITY.GET_ENTITY_SPEED(myVeh)
    if escortLeftCar then
      TASK.CLEAR_PED_SECONDARY_TASK(escort_2)
      TASK.CLEAR_PED_SECONDARY_TASK(escort_3)
      PED.SET_PED_CONFIG_FLAG(escort_1, 402, true)
      PED.SET_PED_CONFIG_FLAG(escort_2, 402, true)
      PED.SET_PED_CONFIG_FLAG(escort_3, 402, true)
      TASK.TASK_ENTER_VEHICLE(escort_2, escortCar, 10000, 0, 2.0, 1, 0, 0)
      PED.SET_PED_INTO_VEHICLE(escort_3, escortCar, 1)
      escortLeftCar = false
      -- startFollowTask = true
    end
    misc:sleep(500)
    if not dismissed then
      TASK.TASK_VEHICLE_ESCORT(escort_1, escortCar, myVeh, -1, mySpeed + 6.0, 1074528293, 3.0, 3.0, 3.0)
    end
  end
  if doDonuts then
    VEHICLE.SET_DRIFT_TYRES(escortCar, true)
    VEHICLE.SET_VEHICLE_REDUCE_GRIP(escortCar, true)
    VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(escortCar, 2)
    VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(escortCar, 1.8)
    TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, donutDirection, 100000)
  else -- in case you don't press stop before choosing a different option, thiw will reset the vehicle back to stock.
    VEHICLE.SET_DRIFT_TYRES(escortCar, false)
    VEHICLE.SET_VEHICLE_REDUCE_GRIP(escortCar, false)
    VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(escortCar, 1.0)
  end
  if doingDriveBy then
    -- local shooterPos = ENTITY.GET_ENTITY_COORDS(escort_1, false)
    local randomPed = nearestPed(escort_1)
    -- local pedCoords = ENTITY.GET_ENTITY_COORDS(randomPed, false)
    -- local randomVeh = VEHICLE.GET_CLOSEST_VEHICLE(shooterPos.x, shooterPos.y, shooterPos.z, 400, 0, 70) -- we're shooting peds instead of vehicles.
    TASK.TASK_VEHICLE_DRIVE_WANDER(escort_1, escortCar, 26, 2883621) --8388614
    TASK.TASK_DRIVE_BY(escort_2, randomPed, 0, 0.0, 0.0, 0.0, 100, 100, false, joaat("firing_pattern_burst_fire_driveby"))
    TASK.TASK_DRIVE_BY(escort_3, randomPed, 0, 0.0, 0.0, 0.0, 100, 100, false, joaat("firing_pattern_burst_fire_driveby"))
  end
  if not dismissed then
    local myPos = ENTITY.GET_ENTITY_COORDS(self.get_ped())
    if PED.IS_PED_SHOOTING_IN_AREA(self.get_ped(), myPos.x - 20, myPos.y - 20, myPos.z -10, myPos.x + 20, myPos.y + 20, myPos.z + 20, false, true) then
      PED.SET_PED_CONFIG_FLAG(escort_1, 402, false)
      PED.SET_PED_CONFIG_FLAG(escort_2, 402, false)
      PED.SET_PED_CONFIG_FLAG(escort_3, 402, false)
      TASK.TASK_LEAVE_VEHICLE(escort_1, escortCar, 256)
      TASK.TASK_LEAVE_VEHICLE(escort_2, escortCar, 256)
      TASK.TASK_LEAVE_VEHICLE(escort_3, escortCar, 256)
      escortLeftCar = true
    end
  end
  if sittingInEscortCar then
    if escortLeftCar then
      TASK.CLEAR_PED_SECONDARY_TASK(escort_1)
      TASK.CLEAR_PED_SECONDARY_TASK(escort_2)
      TASK.CLEAR_PED_SECONDARY_TASK(escort_3)
      PED.SET_PED_CONFIG_FLAG(escort_1, 402, true)
      PED.SET_PED_CONFIG_FLAG(escort_2, 402, true)
      PED.SET_PED_CONFIG_FLAG(escort_3, 402, true)
      TASK.TASK_ENTER_VEHICLE(escort_1, escortCar, 10000, -1, 2.0, 1, 0, 0)
      TASK.TASK_ENTER_VEHICLE(escort_2, escortCar, 10000, 0, 2.0, 1, 0, 0)
      PED.SET_PED_INTO_VEHICLE(escort_3, escortCar, 1)
      escortLeftCar = false
    end
  end
end)
event.register_handler(menu_event.ScriptsReloaded, function()
    if spawned_jet[1] ~= nil then
      for _, v in ipairs(spawned_jet) do
        if ENTITY.DOES_ENTITY_EXIST(v) then
          ENTITY.SET_ENTITY_AS_MISSION_ENTITY(v, true, true)
          VEHICLE.DELETE_VEHICLE(pJet)
        end
      end
    end
    if spawned_pilot[1] ~= nil then
      for _, v in ipairs(spawned_pilot) do
        if ENTITY.DOES_ENTITY_EXIST(v) then
          PED.DELETE_PED(v)
          PED.DELETE_PED(v)
        end
      end
    end
    if spawned_bodyguards[1] ~= nil then
      for _, v in ipairs(spawned_bodyguards) do
        if ENTITY.DOES_ENTITY_EXIST(v) then
          PED.DELETE_PED(v)
          PED.DELETE_PED(v)
          PED.DELETE_PED(v)
        end
      end
    end
    if spawned_SUV[1] ~= nil then
      for _, v in ipairs(spawned_SUV) do
        if ENTITY.DOES_ENTITY_EXIST(v) then
          ENTITY.SET_ENTITY_AS_MISSION_ENTITY(v, true, true)
          VEHICLE.DELETE_VEHICLE(v)
        end
      end
    end
    if spawned_escorts[1] ~= nil then
      for _, v in ipairs(spawned_escorts) do
        if ENTITY.DOES_ENTITY_EXIST(v) then
          PED.DELETE_PED(v)
          PED.DELETE_PED(v)
          PED.DELETE_PED(v)
        end
      end
    end
    if spawned_limo[1] ~= nil then
      for _, v in ipairs(spawned_limo) do
        if ENTITY.DOES_ENTITY_EXIST(v) then
          ENTITY.SET_ENTITY_AS_MISSION_ENTITY(v, true, true)
          VEHICLE.DELETE_VEHICLE(v)
          PED.DELETE_PED(v)
        end
      end
    end
    if spawned_driver[1] ~= nil then
      for _, v in ipairs(spawned_driver) do
        if ENTITY.DOES_ENTITY_EXIST(v) then
          PED.DELETE_PED(v)
        end
      end
    end
end)
event.register_handler(menu_event.MenuUnloaded, function()
    if spawned_jet[1] ~= nil then
      for _, v in ipairs(spawned_jet) do
        if ENTITY.DOES_ENTITY_EXIST(v) then
          ENTITY.SET_ENTITY_AS_MISSION_ENTITY(v, true, true)
          VEHICLE.DELETE_VEHICLE(pJet)
        end
      end
    end
    if spawned_pilot[1] ~= nil then
      for _, v in ipairs(spawned_pilot) do
        if ENTITY.DOES_ENTITY_EXIST(v) then
          PED.DELETE_PED(v)
          PED.DELETE_PED(v)
        end
      end
    end
    if spawned_bodyguards[1] ~= nil then
      for _, v in ipairs(spawned_bodyguards) do
        if ENTITY.DOES_ENTITY_EXIST(v) then
          PED.DELETE_PED(v)
          PED.DELETE_PED(v)
          PED.DELETE_PED(v)
        end
      end
    end
    if spawned_SUV[1] ~= nil then
      for _, v in ipairs(spawned_SUV) do
        if ENTITY.DOES_ENTITY_EXIST(v) then
          ENTITY.SET_ENTITY_AS_MISSION_ENTITY(v, true, true)
          VEHICLE.DELETE_VEHICLE(v)
        end
      end
    end
    if spawned_escorts[1] ~= nil then
      for _, v in ipairs(spawned_escorts) do
        if ENTITY.DOES_ENTITY_EXIST(v) then
          PED.DELETE_PED(v)
          PED.DELETE_PED(v)
          PED.DELETE_PED(v)
        end
      end
    end
    if spawned_limo[1] ~= nil then
      for _, v in ipairs(spawned_limo) do
        if ENTITY.DOES_ENTITY_EXIST(v) then
          ENTITY.SET_ENTITY_AS_MISSION_ENTITY(v, true, true)
          VEHICLE.DELETE_VEHICLE(v)
          PED.DELETE_PED(v)
        end
      end
    end
    if spawned_driver[1] ~= nil then
      for _, v in ipairs(spawned_driver) do
        if ENTITY.DOES_ENTITY_EXIST(v) then
          PED.DELETE_PED(v)
        end
      end
    end
end)