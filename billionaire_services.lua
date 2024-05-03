---@diagnostic disable: undefined-global, lowercase-global
local billionaire_services=gui.get_tab("Billionaire Services")
local airport_index             = 0
local pJet                      = 0
local pilot                     = 0
local copilot                   = 0
local jetSeat                   = 2
local setHeading                = 0
local bodyguard_index           = 0
local playerIndex               = 0
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
local limoSeat                  = 2
local donutDirection            = 7
local dbgclc                    = 0
local targetPlayer              = 0
local btnPress                  = 0
local meleeIdx                  = 0
local pistolIdx                 = 0
local smgIdx                    = 0
local sgIdx                     = 0
local arIdx                     = 0
local mgIdx                     = 0
local srIdx                     = 0
local hvyIdx                    = 0
local grIdx                     = 0
local bg_unarmed                = false
local es_unarmed                = false
local wpnWindow                 = false
local nineEleven                = false
local plyrWindow                = false
local bg_attack                 = false
local es_attack                 = false
local dbgWindow                 = false
local bgAutoTp                  = true
local esAutoTp                  = true
local arprtLstTop               = true
local disableArprtLst           = false
local jetTpBtn                  = false
local initialFlight             = false
local newFlight                 = false
local flying                    = false
local can_land                  = false
local started_landing           = false
local startLandingProcess       = false
local showLandingSkip           = false
local showSkipNotif             = false
local skippedLandingProcess     = false
local jetDismissed              = false
local showPilotLeavingMsg       = false
local showBailMsg               = false
local dismissed                 = false
local dismissedGuards           = false
local sittingInEscortCar        = false
local driveStarted              = false
local driveToWp                 = false
local doingBurnout              = false
local doingDriveBy              = false
local doDonuts                  = false
local escortLeftCar             = false
local onFoot                    = false
local escortCarAway             = false
local askedToLeave              = false
local sittingInLimo             = false
local limoWp                    = false
local limoCr                    = false
local limoDismissed             = false
local showLimoMsg               = false
local taskInProgress            = false
local startFollowTask           = false
local followOnFoot              = false
local validModel                = false
local allowInside               = false
local currentTask               = "None."
local hangarPos                 = vector3
local destination               = vector3
local newDestination            = vector3
local spawned_jet               = {}
local spawned_pilot             = {}
local spawned_limo              = {}
local spawned_driver            = {}
local spawned_bodyguards        = {}
local spawned_escorts           = {}
local spawned_SUV               = {}
local guardBlips                = {}
local airports                  = {
  {name = "Los Santos International Airport", hangar = vec3:new(-979.294, -2993.9, 13.9451), runwayStart = vec3:new(-1305.79, -2148.72, 13.9446), runwayEnd = vec3:new(-1663.04, -2775.99, 13.9447), taxiPos = vec3:new(-1046.74, -2971.01, 13.9487), cutPos = vec3:new(-2204.82, -2554.53, 678.723), checkPos = vec3:new(-860.534, -1476.28, 286.833), checkPosHdng = 143.321,  heading = 50,  escrtPos = vec3:new(-991.083, -3005.92, 13.9451), escrtHdng = 15.427},
  {name = "Fort Zancudo",                     hangar = vec3:new(-2140.81, 3255.64, 32.8103), runwayStart = vec3:new(-1972.55, 2842.36, 32.8104),  runwayEnd = vec3:new(-2598.1, 3199.13, 32.8118),   taxiPos = vec3:new(-2166.8, 3203.57, 32.8049),   cutPos = vec3:new(-3341.66, 3578.68, 595.203),  checkPos = vec3:new(-1487.91, 2553.82, 266.253),  checkPosHdng = 55.7258,  heading = 132, escrtPos = vec3:new(-2134.02, 3241.4, 32.8103),   escrtHdng = 97.989},
  {name = "Sandy Shores Airfield",            hangar = vec3:new(1744.21, 3276.24, 41.1191),  runwayStart = vec3:new(1052.2, 3068.35, 41.6282),    runwayEnd = vec3:new(1718.24, 3254.43, 41.1363),   taxiPos = vec3:new(1705.72, 3254.61, 41.0139),   cutPos = vec3:new(-164.118, 1830.04, 996.586),  checkPos = vec3:new(633.196, 2975.52, 263.214),   checkPosHdng = 277.875,  heading = 150, escrtPos = vec3:new(1755.6, 3261.15, 41.3516),    escrtHdng = 83.893},
}
local bodyguards = {
  {name = "Private Mercenaries",  pedType = "PED_TYPE_ARMY",                  modelHash = {a = 0x613E626C, b = 0x5076A73B, c = 0xB3F3EE34}, weaponHash = {main = 0x83BF0278, sec = 350597077},  vehicle = 2230595153,  vehCol = 0,   vehRadio = "RADIO_19_USER"      },  -- Carbine Rifle + Tactical SMG
  {name = "Private Security",     pedType = "PED_TYPE_COP",                   modelHash = {a = 0xF161D212, b = 0x2930C1AB, c = 0x55FE9B46}, weaponHash = {main = 0x2B5EF5EC, sec = 0},          vehicle = 666166960,   vehCol = 0,   vehRadio = "RADIO_19_USER"      },  -- Ceramic Pistol
  {name = "Ballas OGs",           pedType = "PED_TYPE_GANG_AFRICAN_AMERICAN", modelHash = {a = 0x231AF63F, b = 0xABEF0004, c = 0xDB41B4EF}, weaponHash = {main = 0x1B06D571, sec = 0},          vehicle = 3431608412,  vehCol = 145, vehRadio = "RADIO_09_HIPHOP_OLD"},  -- Default Pistol
  {name = "Families OGs",         pedType = "PED_TYPE_GANG_AFRICAN_AMERICAN", modelHash = {a = 0x33A464E5, b = 0xE83B93B7, c = 0x84302B09}, weaponHash = {main = 0x1B06D571, sec = 0},          vehicle = 3265236814,  vehCol = 53,  vehRadio = "RADIO_03_HIPHOP_NEW"},  -- //
  {name = "Vagos Esses",          pedType = "PED_TYPE_GANG_PUERTO_RICAN",     modelHash = {a = 0x837B64DE, b = 0x5AA42C21, c = 0x964D12DC}, weaponHash = {main = 0x1B06D571, sec = 0},          vehicle = 2254540506,  vehCol = 88,  vehRadio = "RADIO_08_MEXICAN"   },  -- //
  {name = "Lost MC",              pedType = "PED_TYPE_GANG_BIKER_1",          modelHash = {a = 0x32B11CDC, b = 0x4F46D607, c = 0xFD5537DE}, weaponHash = {main = 0x1B06D571, sec = 0},          vehicle = 2549763894,  vehCol = 0,   vehRadio = "RADIO_04_PUNK"      },  -- //
  {name = "Armenian Mobsters",    pedType = "PED_TYPE_GANG_ALBANIAN",         modelHash = {a = 0xE7714013, b = 0xFDA94268, c = 0xF1E823A2}, weaponHash = {main = 0x1B06D571, sec = 0},          vehicle = 83136452,    vehCol = 111, vehRadio = "RADIO_15_MOTOWN"    },  -- //
  {name = "Cartel Sicarios",      pedType = "PED_TYPE_GANG_PUERTO_RICAN",     modelHash = {a = 0x995B3F9F, b = 0x7ED5AD78, c = 0xE6AC74A4}, weaponHash = {main = 0xBFEFFF6D, sec = 350597077},  vehicle = 4256087847,  vehCol = 0,   vehRadio = "RADIO_08_MEXICAN"   },  -- Assault Rifle + Tactical SMG
  {name = "Bad Bitches",          pedType = "PED_TYPE_PROSTITUTE",            modelHash = {a = 0x28ABF95,  b = 0x81441B71, c = 0xAEEA76B5}, weaponHash = {main = 350597077,  sec = 0},          vehicle = 461465043,   vehCol = 30,  vehRadio = "RADIO_02_POP"       },  -- Tactical SMG
}
local melee_weapons = {0x92A27487, 0x958A4A8F, 0xF9E6AA4B, 0x84BD7BFD, 0x8BB05FD7, 0x440E4788, 0x4E875F73, 0xF9DCBF2D, 0xD8DF3C3C, 0x99B507EA, 0xDD5DF8D9, 0xDFE37640, 0x678B81B1, 0x19044EE0, 0xCD274149, 0x94117305, 0x3813FC08,}
local handguns = {0x1B06D571, 0xBFE256D4, 0x5EF9FEC4, 0x22D8FE39, 0x3656C8C1, 0x99AEEB3B, 0xBFD21232, 0x88374054, 0xD205520E, 0x83839C4 , 0x47757124, 0xDC4DB296, 0xC1B3C3D1, 0xCB96392F, 0x97EA20B8, 0xAF3696A1, 0x2B5EF5EC, 0x917F6C8C,}
local smg = {0x13532244, 0x2BE6766B, 0x78A97CD0, 0xEFE7E2DF, 0xA3D4D34, 0xDB1AA450, 0xBD248B55, 0x476BF155,}
local shotguns = {0x1D073A89, 0x555AF99A, 0x7846A318, 0xE284C527, 0x9D61E50F, 0xA89CB99E, 0x3AABBBAA, 0xEF951FBB, 0x12E82D3D,}
local assault_rifles = {0xBFEFFF6D, 0x394F415C, 0x83BF0278, 0xFAD1F1C9, 0xAF113F99, 0xC0A3098D, 0x969C3D67, 0x7F229F94, 0x84D6FAFD, 0x624FE830,}
local machine_guns = {0x9D07F764, 0x7FD62962, 0xDBBD7280, 0x61012683,}
local sniper_rifles = {0x5FC3C11, 0xC472FE2, 0xA914799, 0xC734385A, 0x6A6C02E0,}
local heavy_weapons = {0xB1CA77B1, 0xA284510B, 0x4DD2DC56, 0x42BF8A85, 0x7F7497E5, 0x6D544C99, 0x63AB0442, 0x781FE4A, 0xB62D1F67,}
local throwables = {0x93E220BD, 0xA0973D5E, 0xFDBC8A50, 0x497FACC3, 0x24B17070, 0x2C3731D9, 0xAB564B93, 0x787F0BB, 0xBA45E8B8, 0x23C9F95C,}
-- local misc_weapons = {0x34A67B97, 0x60EC506, 0xFBAB5776, 0xBA536372,}
local function displayMelee()
  local meleeNames = {}
  for _, wpn in ipairs(melee_weapons) do
    local weaponName = weapons.get_weapon_display_name(wpn)
    table.insert(meleeNames, weaponName)
  end
  meleeIdx, used = ImGui.Combo("##meleeWeapons", meleeIdx, meleeNames, #melee_weapons)
end
local function displayHandguns()
  local pistolNames = {}
  for _, wpn in ipairs(handguns) do
    local weaponName = weapons.get_weapon_display_name(wpn)
    table.insert(pistolNames, weaponName)
  end
  pistolIdx, used = ImGui.Combo("##pistols", pistolIdx, pistolNames, #handguns)
end
local function displaySmg()
  local smgNames = {}
  for _, wpn in ipairs(smg) do
    local weaponName = weapons.get_weapon_display_name(wpn)
    table.insert(smgNames, weaponName)
  end
  smgIdx, used = ImGui.Combo("##smg", smgIdx, smgNames, #smg)
end
local function displayShotguns()
  local sgNames = {}
  for _, wpn in ipairs(shotguns) do
    local weaponName = weapons.get_weapon_display_name(wpn)
    table.insert(sgNames, weaponName)
  end
  sgIdx, used = ImGui.Combo("##shotguns", sgIdx, sgNames, #shotguns)
end
local function displayARs()
  local arNames = {}
  for _, wpn in ipairs(assault_rifles) do
    local weaponName = weapons.get_weapon_display_name(wpn)
    table.insert(arNames, weaponName)
  end
  arIdx, used = ImGui.Combo("##rifles", arIdx, arNames, #assault_rifles)
end
local function displayMGs()
  local mgNames = {}
  for _, wpn in ipairs(machine_guns) do
    local weaponName = weapons.get_weapon_display_name(wpn)
    table.insert(mgNames, weaponName)
  end
  mgIdx, used = ImGui.Combo("##machineGuns", mgIdx, mgNames, #machine_guns)
end
local function displaySRs()
  local srNames = {}
  for _, wpn in ipairs(sniper_rifles) do
    local weaponName = weapons.get_weapon_display_name(wpn)
    table.insert(srNames, weaponName)
  end
  srIdx, used = ImGui.Combo("##sniperRifles", srIdx, srNames, #sniper_rifles)
end
local function displayHvys()
  local hvyNames = {}
  for _, wpn in ipairs(heavy_weapons) do
    local weaponName = weapons.get_weapon_display_name(wpn)
    table.insert(hvyNames, weaponName)
  end
  hvyIdx, used = ImGui.Combo("##heavyWeapons", hvyIdx, hvyNames, #heavy_weapons)
end
local function displayGrs()
  local grNames = {}
  for _, wpn in ipairs(throwables) do
    local weaponName = weapons.get_weapon_display_name(wpn)
    table.insert(grNames, weaponName)
  end
  grIdx, used = ImGui.Combo("##throwables", grIdx, grNames, #throwables)
end
-- local function displayMiscW()
--   local miscNames = {}
--   for _, wpn in ipairs(misc_weapons) do
--     local weaponName = weapons.get_weapon_display_name(wpn)
--     table.insert(miscNames, weaponName)
--   end
--   miscIdx, used = ImGui.Combo("##miscWeapons", miscIdx, miscNames, #misc_weapons)
-- end

-- local function sleep(s)
--   local ntime = os.clock() + s/10
--   repeat
--     coroutine.yield()
--   until os.clock() > ntime
-- end

local function coloredText(text, color)
  ImGui.PushStyleColor(ImGuiCol.Text, color[1]/255, color[2]/255, color[3]/255, color[4])
  ImGui.PushTextWrapPos(ImGui.GetFontSize() * 20)
  ImGui.TextWrapped(text)
  ImGui.PushTextWrapPos(ImGui.GetFontSize() * 20)
  ImGui.PopStyleColor(1)
end

local function helpmarker(colorFlag, text, color)
  ImGui.SameLine()
  ImGui.TextDisabled("(?)")
  if ImGui.IsItemHovered() then
    ImGui.SetNextWindowBgAlpha(0.8)
    ImGui.BeginTooltip()
    if colorFlag == true then
      coloredText(text, color)
    else
      ImGui.PushTextWrapPos(ImGui.GetFontSize() * 20)
      ImGui.TextWrapped(text)
      ImGui.PopTextWrapPos()
    end
      ImGui.EndTooltip()
  end
end

local function widgetToolTip(colorFlag, text, color)
  if ImGui.IsItemHovered() then
    ImGui.SetNextWindowBgAlpha(0.8)
    ImGui.BeginTooltip()
    if colorFlag == true then
      coloredText(text, color)
    else
      ImGui.PushTextWrapPos(ImGui.GetFontSize() * 20)
      ImGui.TextWrapped(text)
      ImGui.PopTextWrapPos()
    end
      ImGui.EndTooltip()
  end
end

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
  if disableArprtLst then
    ImGui.BeginDisabled(true)
    airport_index, used = ImGui.Combo("##airportList", airport_index, airportNames, #filteredAirports)
    ImGui.EndDisabled()
  else
    airport_index, used = ImGui.Combo("##airportList", airport_index, airportNames, #filteredAirports)
  end
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
local function updatePlayerList()
  filteredPlayers = {}
  local players = entities.get_all_peds_as_handles()
  for _, ped in ipairs(players) do
    if PED.IS_PED_A_PLAYER(ped) then
      if NETWORK.NETWORK_IS_PLAYER_ACTIVE(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ped)) then
        table.insert(filteredPlayers, ped)
      end
    end
  end
end
local function displayPlayerList()
  updatePlayerList()
  local playerNames = {}
  for _, player in ipairs(filteredPlayers) do
    playerName = PLAYER.GET_PLAYER_NAME(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(player))
    table.insert(playerNames, playerName)
  end
  playerIndex, used = ImGui.Combo("##playerList", playerIndex, playerNames, #filteredPlayers)
end
local function pedConfig(ped)
    PED.SET_PED_CONFIG_FLAG(ped, 2, true)
    PED.SET_PED_CONFIG_FLAG(ped, 43, true)
    PED.SET_PED_CONFIG_FLAG(ped, 48, false)
    PED.SET_PED_CONFIG_FLAG(ped, 140, false)
    PED.SET_PED_CONFIG_FLAG(ped, 141, true)
    PED.SET_PED_CONFIG_FLAG(ped, 144, true)
    PED.SET_PED_CONFIG_FLAG(ped, 177, true)
    PED.SET_PED_CONFIG_FLAG(ped, 179, true)
    PED.SET_PED_CONFIG_FLAG(ped, 249, true)
    PED.SET_PED_CONFIG_FLAG(ped, 294, true)
    PED.SET_PED_CONFIG_FLAG(ped, 311, true)
    PED.SET_PED_CONFIG_FLAG(ped, 398, true)
    PED.SET_PED_CONFIG_FLAG(ped, 401, true)
    PED.SET_PED_CONFIG_FLAG(ped, 443, true)
    PED.SET_PED_COMBAT_ABILITY(ped, 2)
    PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
    PED.SET_PED_COMBAT_MOVEMENT(ped, 2)
    PED.SET_PED_COMBAT_RANGE(ped, 2)
    PED.SET_PED_SEEING_RANGE(ped, 300.0)
    PED.SET_PED_HEARING_RANGE(ped, 300.0)
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
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 54, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 55, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 58, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 61, true)
    PED.SET_PED_COMBAT_ATTRIBUTES(ped, 71, true)
    PED.SET_PED_ACCURACY(ped, math.random(70, 100))
    PED.SET_PED_CAN_SWITCH_WEAPON(ped, true)
    -- PED.SET_PED_DIES_WHEN_INJURED(ped, false)
    PED.SET_PED_CAN_BE_TARGETED_WHEN_INJURED(ped, false)
    WEAPON.SET_PED_DROPS_WEAPONS_WHEN_DEAD(ped, false)
    PED.SET_PED_SUFFERS_CRITICAL_HITS(ped, false)
end
local function list_iter(t)
  local i = 0
  local n = #t
  return function ()
    i = i + 1
    if i <= n then
      return t[i]
    end
  end
end
local function nearestPed(closeTo)
  script.run_in_fiber(function()
    local gtaPeds = entities.get_all_peds_as_handles()
    local myGroup = PED.GET_PED_GROUP_INDEX(self.get_ped())
    for _, ped in ipairs(gtaPeds) do
      if PED.IS_PED_HUMAN(ped) then
        if ped ~= self.get_ped() then
          if not PED.IS_PED_GROUP_MEMBER(ped, myGroup) then
            local thisPos       = ENTITY.GET_ENTITY_COORDS(closeTo, true)
            local randomPedPos  = ENTITY.GET_ENTITY_COORDS(ped, true)
            local distCalc      = SYSTEM.VDIST(thisPos.x, thisPos.y, thisPos.z, randomPedPos.x, randomPedPos.y, randomPedPos.z)
            if distCalc < 50 then
              if not ENTITY.IS_ENTITY_DEAD(ped) then
                randomPed = ped
              end
            end
          end
        end
      end
    end
  end)
  return randomPed
end
local function giveWeapon(ped, weapon, wpnName, ped_category)
  if not WEAPON.HAS_PED_GOT_WEAPON(ped, weapon, false) then
	  WEAPON.GIVE_WEAPON_TO_PED(ped, weapon, 9999, false, false)
    gui.show_message("Private Security", "Added "..wpnName.." to your "..ped_category.." inventory.")
  else
	  gui.show_error("Private Security", "Your "..ped_category.." already have this weapon.")
  end
end
local function removeWeapon(ped, weapon, wpnName, ped_category)
  if WEAPON.HAS_PED_GOT_WEAPON(ped, weapon, false) then
    WEAPON.REMOVE_WEAPON_FROM_PED(ped, weapon)
    gui.show_message("Private Security", "Removed "..wpnName.." from your "..ped_category.." inventory.")
  else
    gui.show_error("Private Security", "Your "..ped_category.." do not have this weapon.")
  end
end
billionaire_services:add_imgui(function()
  ImGui.BeginTabBar("Billionaire Services", ImGuiTabBarFlags.None)
  if ImGui.BeginTabItem("Private Jet") then
    if arprtLstTop then
      if disableArprtLst then
        ImGui.TextDisabled("Choose an Airport:")
      else
        ImGui.Text("Choose an Airport:")
      end
      ImGui.PushItemWidth(280)
      displayAirports()
      ImGui.PopItemWidth()
    end
    local airportData   = filteredAirports[airport_index + 1]
    local jetModel      = 0xB79F589E
    local pilotModel    = 0x864ED68E
    local copilotModel  = 0xE75B4B1C
    if spawned_jet[1] == nil then
      if ImGui.Button("Call Your Private Jet") then
        jetDismissed = false
        script.run_in_fiber(function(privateJet)
          local myGroup = PED.GET_PED_GROUP_INDEX(self.get_ped())
          if not PED.DOES_GROUP_EXIST(myGroup) then
            myGroup = PED.CREATE_GROUP(0)
          end
          PED.SET_PED_AS_GROUP_LEADER(self.get_ped(), myGroup)
          PED.SET_GROUP_SEPARATION_RANGE(myGroup, 16960)
          PED.SET_GROUP_FORMATION(myGroup, 2)
          PED.SET_GROUP_FORMATION_SPACING(myGroup, 3.0, 3.0, 1.0)
          while not STREAMING.HAS_MODEL_LOADED(jetModel) do
            STREAMING.REQUEST_MODEL(jetModel)
            coroutine.yield()
          end
          pJet = VEHICLE.CREATE_VEHICLE(jetModel, 0.0, 0.0, 0.0, 0.0, true, false, false)
          privateJet:sleep(200)
          MISC.CLEAR_AREA_OF_VEHICLES(airportData.hangar.x, airportData.hangar.y, airportData.hangar.z, 5.0, false, false, false, false, false, false, 0)
          ENTITY.SET_ENTITY_COORDS(pJet, airportData.hangar.x, airportData.hangar.y, airportData.hangar.z, true, true, true, true)
          ENTITY.SET_ENTITY_HEADING(pJet, airportData.heading)
          ENTITY.SET_ENTITY_INVINCIBLE(pJet, true)
          VEHICLE.SET_ALLOW_VEHICLE_EXPLODES_ON_CONTACT(pJet, false)
          VEHICLE.SET_VEHICLE_STRONG(pJet, true)
          VEHICLE.SET_VEHICLE_ALLOW_HOMING_MISSLE_LOCKON(pJet, false, 0)
          VEHICLE.SET_VEHICLE_DOOR_OPEN(pJet, 0, false, false)
          jetBlip = HUD.ADD_BLIP_FOR_ENTITY(pJet)
          HUD.SET_BLIP_SPRITE(jetBlip, 423)
          HUD.SET_BLIP_SCALE(jetBlip, 1.2)
          table.insert(spawned_jet, pJet)
          while not STREAMING.HAS_MODEL_LOADED(pilotModel) do
            STREAMING.REQUEST_MODEL(pilotModel)
            coroutine.yield()
          end
          pilot = PED.CREATE_PED_INSIDE_VEHICLE(pJet, "PED_TYPE_CIVMALE", pilotModel, -1, true, false)
          ENTITY.SET_ENTITY_INVINCIBLE(pilot, true)
          table.insert(spawned_pilot, pilot)
          PED.SET_PED_CONFIG_FLAG(pilot, 251, true)
          PED.SET_PED_CONFIG_FLAG(pilot, 255, true)
          PED.SET_PED_CONFIG_FLAG(pilot, 398, true)
          PED.SET_PED_CONFIG_FLAG(pilot, 402, true)
          PED.SET_PED_CONFIG_FLAG(pilot, 167, true)
          PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilot, true)
          privateJet:sleep(100)
          while not STREAMING.HAS_MODEL_LOADED(copilotModel) do
            STREAMING.REQUEST_MODEL(copilotModel)
            coroutine.yield()
          end
          copilot = PED.CREATE_PED_INSIDE_VEHICLE(pJet, "PED_TYPE_CIVMALE", copilotModel, 0, true, false)
          ENTITY.SET_ENTITY_INVINCIBLE(copilot, true)
          table.insert(spawned_pilot, copilot)
          PED.SET_PED_CONFIG_FLAG(copilot, 251, true)
          PED.SET_PED_CONFIG_FLAG(copilot, 255, true)
          PED.SET_PED_CONFIG_FLAG(copilot, 398, true)
          PED.SET_PED_CONFIG_FLAG(copilot, 402, true)
          PED.SET_PED_CONFIG_FLAG(copilot, 167, true)
          PED.SET_PED_AS_GROUP_MEMBER(copilot, myGroup)
          PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(copilot, true)
          VEHICLE.SET_VEHICLE_ENGINE_ON(pJet, true, false, false)
          if NETWORK.NETWORK_IS_SESSION_STARTED() then
            AUDIO.SET_VEH_RADIO_STATION(pJet, "RADIO_35_DLC_HEI4_MLR")
          else
            AUDIO.SET_VEH_RADIO_STATION(pJet, "RADIO_22_DLC_BATTLE_MIX1_RADIO")
          end
        end)
        gui.show_message("Private Jet", "Your private jet is waiting for you at "..airportData.name..".")
      end
    else
      arprtLstTop = false
      if not jetDismissed then
        ImGui.Spacing();ImGui.Spacing()
        if ImGui.Button(" Dismiss Your Jet ") then
          if not flying then
            showPilotLeavingMsg = true
            jetDismissed        = true
            script.run_in_fiber(function(dismissJet)
              if PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), pJet) then
                TASK.TASK_LEAVE_VEHICLE(self.get_ped(), pJet, 256)
                dismissJet:sleep(2000)
              end
              if ENTITY.DOES_ENTITY_EXIST(pilot) or ENTITY.DOES_ENTITY_EXIST(copilot) then
                VEHICLE.SET_VEHICLE_ENGINE_ON(pJet, false, false, false)
                TASK.TASK_LEAVE_VEHICLE(pilot, pJet, 256)
                TASK.TASK_LEAVE_VEHICLE(copilot, pJet, 256)
                gui.show_message("Private Jet", "Your private jet has been dismissed. Please wait for your pilots to leave.")
                TASK.TASK_WANDER_STANDARD(pilot, 10.0, 10)
                TASK.TASK_WANDER_STANDARD(copilot, 10.0, 10)
                dismissJet:sleep(10000)
                PED.REMOVE_PED_FROM_GROUP(copilot)
                PED.DELETE_PED(pilot)
                PED.DELETE_PED(copilot)
                if ENTITY.DOES_ENTITY_EXIST(pJet) then
                  ENTITY.SET_ENTITY_AS_MISSION_ENTITY(pJet, true, true)
                  dismissJet:sleep(200)
                  VEHICLE.DELETE_VEHICLE(pJet)
                end
                arprtLstTop = true
              end
              for k, _ in ipairs(spawned_jet) do
                table.remove(spawned_jet, k)
              end
              for index, _ in ipairs(spawned_pilot) do
                table.remove(spawned_pilot, index)
              end
            end)
          else
            gui.show_error("Private Jet", "Ask your pilot to land before dismissing your private jet.")
            return
          end
        end
        if jetTpBtn then
          ImGui.SameLine();ImGui.Dummy(60, 1);ImGui.SameLine()
          if ImGui.Button("Teleport To Jet") then
            script.run_in_fiber(function(jettp)
              CAM.DO_SCREEN_FADE_OUT(500)
              jettp:sleep(1000)
              TASK.CLEAR_PED_TASKS_IMMEDIATELY(self.get_ped())
              PED.SET_PED_INTO_VEHICLE(self.get_ped(), pJet, 1)
              jettp:sleep(1000)
              CAM.DO_SCREEN_FADE_IN(500)
            end)
          end
        end
        ImGui.Spacing();ImGui.Text("Jet Options:");ImGui.Separator()
        if not flying and not newFlight then
          if PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), pJet) then
            ImGui.Dummy(75, 1);ImGui.SameLine()
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
                  if NETWORK.NETWORK_IS_SESSION_STARTED() then
                    AUDIO.SET_VEH_RADIO_STATION(pJet, "RADIO_35_DLC_HEI4_MLR") -- music locker for online
                  else
                    AUDIO.SET_VEH_RADIO_STATION(pJet, "RADIO_22_DLC_BATTLE_MIX1_RADIO") -- LSUR for SP
                  end
                  flying        = true
                  initialFlight = true
                  VEHICLE.SET_VEHICLE_DOORS_SHUT(pJet, false)
                  TASK.TASK_VEHICLE_DRIVE_TO_COORD(pilot, pJet, airportData.taxiPos.x, airportData.taxiPos.y, airportData.taxiPos.z, 5.0, 0, 0xB79F589E, 8388614, 10.0, 10.0)
                  flyTo:sleep(6000)
                  CAM.DO_SCREEN_FADE_OUT(1000)
                  flyTo:sleep(1000)
                  CAM.DO_SCREEN_FADE_IN(1000)
                  ENTITY.SET_ENTITY_COORDS(pJet, airportData.cutPos.x, airportData.cutPos.y, airportData.cutPos.z, true, true, true, true)
                  VEHICLE.SET_VEHICLE_FORWARD_SPEED(pJet, 100.0) --360km/h
                  VEHICLE.CONTROL_LANDING_GEAR(pJet, 1)
                  TASK.TASK_PLANE_MISSION(pilot, pJet, 0, 0, destination.x, destination.y, destination.z + 600, 4, 100.0, 0, 90, 0, 0, 200)
                  flyTo:sleep(500)
                  initialFlight = false
                else
                  gui.show_message("Private Jet", "Get in your private jet to be able to fly around.")
                end
              end)
            end
          else
            ImGui.TextWrapped("Board your private jet to see more options.")
          end
        end
      else
        if showPilotLeavingMsg then
          local timer = 0
          ImGui.TextWrapped("Your private jet has been dismissed. Please wait for your pilots to leave.")
          timer = timer + 1
          if timer > 50 then
            showPilotLeavingMsg = false
          end
        end
      end
      if flying and not initialFlight then
        if PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), pJet) then
          if not started_landing and not startLandingProcess then
            ImGui.Dummy(75, 1);ImGui.SameLine()
            if ImGui.Button("Fly To New Waypoint") then
              script.run_in_fiber(function(newWp)
                local newWaypoint = HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID())
                if HUD.DOES_BLIP_EXIST(newWaypoint) then
                  newDestination = HUD.GET_BLIP_COORDS(newWaypoint)
                  if newDestination ~= destination then
                    TASK.TASK_PLANE_MISSION(pilot, pJet, 0, 0, newDestination.x, newDestination.y, newDestination.z + 600, 4, 100.0, 0, 90, 0, 0, 200)
                    newWp:sleep(500)
                    newFlight = true
                    flying    = true
                  else
                    gui.show_error("Private Jet", "Please set a different waypoint on the map first!")
                    return
                  end
                else
                  gui.show_error("Private Jet", "Please set a waypoint on the map first!")
                  return
                end
              end)
            end
          end
        else
          ImGui.TextWrapped("Board your private jet to see more options.")
        end
      end
      if flying and PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), pJet) and not initialFlight then
        if not started_landing and not startLandingProcess then
          if btnPress == 0 then
            ImGui.Dummy(120, 1);ImGui.SameLine()
            if ImGui.Button("Do a 9/11") then
              btnPress = btnPress + 1
            end
          elseif btnPress == 1 then
            ImGui.Dummy(70, 1);ImGui.SameLine()
            ImGui.Text("Are you sure about that?")
            ImGui.Dummy(85, 1);ImGui.SameLine()
            if ImGui.Button("YES, DO IT!") then
              if not started_landing and not skippedLandingProcess then
                gui.show_error("Private Jet", "What's wrong with you? Fucking terrorist!")
                AUDIO.SET_VEH_RADIO_STATION(pJet, "OFF")
                script.run_in_fiber(function(terroristCunt)
                  nineEleven      = true
                  initialFlight   = true
                  newFlight       = true
                  TASK.TASK_PLANE_MISSION(pilot, pJet, 0, 0, -77.7393, -802.863, 207.17, 6, 100.0, 0, 90.0, 0, 0, -5000) -- -77.7393, -802.863, 307.17
                  terroristCunt:sleep(2000)
                  btnPress = btnPress + 1
                end)
              else
                gui.show_message("Private Jet", "Your pilots can not commit acts of terrorism while in the process of landing.")
              end
            end
            ImGui.SameLine();ImGui.Spacing();ImGui.SameLine()
            if ImGui.Button(" No ") then
              btnPress = 0
            end
          end
        end
      end
      if PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), pJet) then
        ImGui.Spacing()
        ImGui.Dummy(140, 1);ImGui.SameLine();ImGui.Text("Radio")
        if AUDIO.IS_VEHICLE_RADIO_ON(pJet) then
          ImGui.Dummy(125, 1);ImGui.SameLine()
          if ImGui.Button("Turn Off") then
            AUDIO.SET_VEH_RADIO_STATION(pJet, "OFF")
          end
          ImGui.Dummy(5, 1);ImGui.SameLine()
          if ImGui.Button("< Previous Station") then
            AUDIO.SET_RADIO_RETUNE_DOWN()
          end
          ImGui.SameLine();ImGui.Spacing();ImGui.SameLine()
          if ImGui.Button("Next Station >") then
            AUDIO.SET_RADIO_RETUNE_UP()
          end
          local stationName = AUDIO.GET_PLAYER_RADIO_STATION_NAME()
          local displayName = HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(stationName)
          ImGui.Text("Now Playing: "..displayName)
        else
          ImGui.Dummy(125, 1);ImGui.SameLine()
          if ImGui.Button("Turn On") then
            AUDIO.SET_VEH_RADIO_STATION(pJet, "RADIO_22_DLC_BATTLE_MIX1_RADIO")
          end
        end
        ImGui.Spacing();ImGui.Separator()
        ImGui.Dummy(140, 1);ImGui.SameLine();ImGui.Text("Seats")
        ImGui.Dummy(5, 1);ImGui.SameLine()
        if ImGui.Button(" < Previous Seat  ") then
          script.run_in_fiber(function()
            local numSeats = VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(pJet)
            if jetSeat <= 1 then
              jetSeat = numSeats
            end
            jetSeat = jetSeat - 1
            if VEHICLE.IS_VEHICLE_SEAT_FREE(pJet, jetSeat, true) then
              PED.SET_PED_INTO_VEHICLE(self.get_ped(), pJet, jetSeat)
            else
              gui.show_message("Private Jet", "Seat currently occupied.")
              jetSeat = jetSeat - 1
              return
            end
          end)
        end
        ImGui.SameLine();ImGui.Spacing();ImGui.SameLine()
        if ImGui.Button("  Next Seat  >") then
          script.run_in_fiber(function()
            local numSeats = VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(pJet)
            if jetSeat >= (numSeats - 1) then
              jetSeat = 0
            end
            jetSeat = jetSeat + 1
            if VEHICLE.IS_VEHICLE_SEAT_FREE(pJet, jetSeat, true) then
              PED.SET_PED_INTO_VEHICLE(self.get_ped(), pJet, jetSeat)
            else
              gui.show_message("Private Jet", "Seat currently occupied.")
              jetSeat = jetSeat + 1
              return
            end
          end)
        end
        ImGui.Spacing()
        ImGui.Spacing()
        ImGui.Text("Landing Options:")
        ImGui.Separator()
        if can_land then
          if not arprtLstTop then
            if disableArprtLst then
              ImGui.TextDisabled("Choose an Airport:")
            else
              ImGui.Text("Choose an Airport:")
            end
            ImGui.PushItemWidth(280)
            displayAirports()
            ImGui.PopItemWidth()
          end
          if not startLandingProcess and not started_landing then
            if not disableArprtLst then
              if ImGui.Button("Land At "..airportData.name) then
                local jetPos      = ENTITY.GET_ENTITY_COORDS(pJet, false)
                local hangarDist  = SYSTEM.VDIST(jetPos.x, jetPos.y, jetPos.z, airportData.hangar.x, airportData.hangar.y, airportData.hangar.z)
                if hangarDist <= 200 then
                  gui.show_message("Private Jet", "Your private jet is already at "..airportData.name)
                  return
                else
                  skippedLandingProcess = false
                  startLandingProcess   = true
                  script.run_in_fiber(function(script)
                    if spawned_escorts[1] ~= nil then
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
                        end
                        gui.show_message("Private Jet", "Flying towards "..airportData.name..". Your private escort will meet you there. Enjoy the rest of your flight!")
                        STREAMING.REQUEST_COLLISION_AT_COORD(airportData.escrtPos.x, airportData.escrtPos.y, airportData.escrtPos.z)
                        script:sleep(5000)
                        MISC.CLEAR_AREA_OF_VEHICLES(airportData.escrtPos.x, airportData.escrtPos.y, airportData.escrtPos.z, 5.0, false, false, false, false, false, false, 0)
                        ENTITY.SET_ENTITY_COORDS(escortCar, airportData.escrtPos.x, airportData.escrtPos.y, airportData.escrtPos.z, true, false, false, true)
                        ENTITY.SET_ENTITY_HEADING(escortCar, airportData.escrtHdng)
                      end
                    else
                      gui.show_message("Private Jet", "Flying towards "..airportData.name..". Enjoy the rest of your flight!")
                    end
                  end)
                end
              end
            end
          else
            if not showLandingSkip then
              ImGui.TextWrapped("Your pilot is now heading towards the airport. You can either wait for him to land your private jet or when you get closer to the runway, a skip button will appear which you can use to skip the landing process.")
            end
          end
        else
          if not showLandingSkip and not nineEleven then
            ImGui.Text("Gain some altitude to be able to see landing\noptions.")
          end
        end
      end
      if showLandingSkip then
        if ImGui.Button("Skip Landing Process") then
          skippedLandingProcess = true
          script.run_in_fiber(function(skipLanding)
            CAM.DO_SCREEN_FADE_OUT(1000)
            TASK.CLEAR_PED_TASKS(pilot)
            TASK.CLEAR_PED_SECONDARY_TASK(pilot)
            TASK.CLEAR_PRIMARY_VEHICLE_TASK(pJet)
            VEHICLE.CONTROL_LANDING_GEAR(pJet, 0)
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(pJet, 0.0)
            VEHICLE.BRING_VEHICLE_TO_HALT(pJet, 1.0, 1000, true)
            skipLanding:sleep(1000)
            MISC.CLEAR_AREA_OF_VEHICLES(hangarPos.x, hangarPos.y, hangarPos.z, 5.0, false, false, false, false, false, false, 0)
            ENTITY.SET_ENTITY_COORDS(pJet, hangarPos.x, hangarPos.y, hangarPos.z, true, true, true, true)
            ENTITY.SET_ENTITY_HEADING(pJet, setHeading)
            VEHICLE.SET_VEHICLE_ENGINE_ON(pJet, false, true, false)
            VEHICLE.SET_VEHICLE_DOOR_OPEN(pJet, 0, false, false)
            skipLanding:sleep(1000)
            CAM.DO_SCREEN_FADE_IN(1000)
            started_landing     = false
            startLandingProcess = false
            initialFlight       = true
            newFlight           = false
            flying              = false
            disableArprtLst     = false
            skipLanding:sleep(1000)
            gui.show_message("Private Jet", "Welcome to "..airportData.name..". We hope you've had a good flight!")
            showLandingSkip = false
          end)
        end
      end
    end
    ImGui.EndTabItem()
  end
  if ImGui.BeginTabItem("Private Limo") then
    ImGui.Spacing();ImGui.Spacing()
    if spawned_limo[1] == nil then
      if ImGui.Button("   Call Limo   ") then
        if flying then
          gui.show_error("Private Limo", "Land your private jet first!")
          return
        end
        if INTERIOR.GET_INTERIOR_FROM_ENTITY(self.get_ped()) == 0 then
          script.run_in_fiber(function(limoService)
            local pedPos      = ENTITY.GET_ENTITY_COORDS(self.get_ped(), true)
            local pedHeading  = ENTITY.GET_ENTITY_HEADING(self.get_ped())
            local pedForwardX = ENTITY.GET_ENTITY_FORWARD_X(self.get_ped())
            local pedForwardY = ENTITY.GET_ENTITY_FORWARD_Y(self.get_ped())
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
            VEHICLE.SET_VEHICLE_MOD_KIT(limo, 0)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(limo, "BALL3R")
            VEHICLE.SET_VEHICLE_WINDOW_TINT(limo, 1) -- limo black windows //
            VEHICLE.SET_VEHICLE_COLOURS(limo, 111, 111)
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(limo, false)
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(limo, false)
            VEHICLE.SET_VEHICLE_ALLOW_HOMING_MISSLE_LOCKON(limo, false, 0)
            VEHICLE.SET_VEHICLE_STRONG(limo, true)
            VEHICLE.SET_VEHICLE_DISABLE_TOWING(limo, true)
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(limo, false)
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
            PED.SET_PED_CONFIG_FLAG(limoDriver, 402, true)
            PED.SET_PED_CONFIG_FLAG(limoDriver, 398, true)
            PED.SET_PED_CONFIG_FLAG(limoDriver, 167, true)
            PED.SET_PED_CONFIG_FLAG(limoDriver, 251, true)
            PED.SET_PED_CONFIG_FLAG(limoDriver, 255, true)
            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(limoDriver, true)
            ENTITY.SET_ENTITY_INVINCIBLE(limoDriver, true)
            VEHICLE.SET_VEHICLE_ENGINE_ON(limo, true, false, false)
            table.insert(spawned_driver, limoDriver)
            limoService:sleep(1000)
            AUDIO.SET_VEH_RADIO_STATION(limo, "RADIO_22_DLC_BATTLE_MIX1_RADIO")
            VEHICLE.SET_VEHICLE_INDIVIDUAL_DOORS_LOCKED(limo, 1, 2)
          end)
        else
          gui.show_error("Private Limo", "You can not call your private limo while staying indoors. Go outside and stand in an open area with enough room in front of you then try again.")
        end
      end
    else
      if ImGui.Button("   Dismiss   ") then
        script.run_in_fiber(function(dismissLimo)
          if limoWp or limoCr then
            TASK.CLEAR_PED_TASKS(limoDriver)
            TASK.CLEAR_PED_SECONDARY_TASK(limoDriver)
            TASK.CLEAR_PRIMARY_VEHICLE_TASK(limo)
            TASK.TASK_VEHICLE_TEMP_ACTION(limoDriver, limo, 1, 2000)
            limoWp        = false
            limoCr        = false
            limoDismissed = true
          end
          if sittingInLimo then
            if not VEHICLE.IS_VEHICLE_STOPPED(limo) then
              repeat
                dismissLimo:sleep(1000)
              until
              VEHICLE.IS_VEHICLE_STOPPED(limo) == true
            end
            TASK.TASK_LEAVE_VEHICLE(self.get_ped(), limo, 0)
            dismissLimo:sleep(2000)
          end
          TASK.TASK_VEHICLE_DRIVE_WANDER(limoDriver, limo, 25, 2883621)
          gui.show_message("Private Limo", "Your limo has been dismissed. Please wait for it to leave.")
          dismissLimo:sleep(10000)
          PED.REMOVE_PED_FROM_GROUP(limoDriver)
          TASK.CLEAR_PRIMARY_VEHICLE_TASK(limo)
          PED.DELETE_PED(limoDriver)
          ENTITY.SET_ENTITY_AS_MISSION_ENTITY(limo, true, true)
          dismissLimo:sleep(200)
          VEHICLE.DELETE_VEHICLE(limo)
          spawned_limo = {}
        end)
      end
    end
    ImGui.Spacing();ImGui.Spacing()
    if spawned_limo[1] ~= nil then
      ImGui.Text("Limo Options:")
      ImGui.Separator()
      if sittingInLimo then
        ImGui.Spacing()
        if ImGui.Button("Drive To Waypoint") then
          script.run_in_fiber(function(limoService)
            local waypoint = HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID())
            if HUD.DOES_BLIP_EXIST(waypoint) then
              destination = HUD.GET_BLIP_COORDS(waypoint)
            else
              gui.show_error("Private Limo", "Please set a waypoint on the map first!")
              return
            end
              TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(limoDriver, limo, destination.x, destination.y, destination.z, 25, 786603, 20.0)
              limoService:sleep(500)
              limoWp = true
              gui.show_message("Private Limo", "Driving to waypoint...")
          end)
        end
        ImGui.SameLine()
        if ImGui.Button("Cruise Around") then
          script.run_in_fiber(function(limoService)
            TASK.TASK_VEHICLE_DRIVE_WANDER(limoDriver, limo, 25, 786603)
            limoService:sleep(500)
            limoCr = true
          end)
          if limoWp then
              gui.show_message("Private Limo", "Drive To Waypoint canceled. Going for a ride instead.")
              limoWp = false
          else
            gui.show_message("Private Limo", "Going for a ride...")
          end
        end
        if limoWp or limoCr then
          ImGui.SameLine()
          if ImGui.Button("Stop") then
            script.run_in_fiber(function()
              TASK.CLEAR_PED_TASKS(limoDriver)
              TASK.CLEAR_PED_SECONDARY_TASK(limoDriver)
              TASK.CLEAR_PRIMARY_VEHICLE_TASK(limo)
              TASK.TASK_VEHICLE_TEMP_ACTION(limoDriver, limo, 1, 2000)
              limoWp = false
              limoCr = false
            end)
          end
        end
        ImGui.Spacing()
        ImGui.SameLine();ImGui.Text(" _________________Radio______________")
        if AUDIO.IS_VEHICLE_RADIO_ON(limo) then
          ImGui.Dummy(125, 1);ImGui.SameLine()
          if ImGui.Button("Turn Off") then
            AUDIO.SET_VEH_RADIO_STATION(limo, "OFF")
          end
          ImGui.Dummy(5, 1);ImGui.SameLine()
          if ImGui.Button("< Previous Station") then
            AUDIO.SET_RADIO_RETUNE_DOWN()
          end
          ImGui.SameLine();ImGui.Spacing();ImGui.SameLine()
          if ImGui.Button("Next Station >") then
            AUDIO.SET_RADIO_RETUNE_UP()
          end
          local stationName = AUDIO.GET_PLAYER_RADIO_STATION_NAME()
          local displayName = HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(stationName)
          ImGui.Text("Now Playing: "..displayName)
        else
          ImGui.Dummy(125, 1);ImGui.SameLine()
          if ImGui.Button("Turn On") then
            AUDIO.SET_VEH_RADIO_STATION(limo, "RADIO_22_DLC_BATTLE_MIX1_RADIO")
          end
        end
        ImGui.Spacing();ImGui.Separator()
        ImGui.SameLine();ImGui.Text(" _________________Seats_____________")
        ImGui.Dummy(5, 1);ImGui.SameLine()
        if ImGui.Button(" < Previous Seat  ") then
          script.run_in_fiber(function()
            local numSeats = VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(limo)
            if limoSeat <= 1 then
              limoSeat = numSeats
            end
            limoSeat = limoSeat - 1
            if VEHICLE.IS_VEHICLE_SEAT_FREE(limo, limoSeat, true) then
              PED.SET_PED_INTO_VEHICLE(self.get_ped(), limo, limoSeat)
            else
              gui.show_message("Private Limo", "Seat currently occupied.")
              limoSeat = limoSeat - 1
              return
            end
          end)
        end
        ImGui.SameLine();ImGui.Spacing();ImGui.SameLine()
        if ImGui.Button("  Next Seat  >") then
          script.run_in_fiber(function()
            local numSeats = VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(limo)
            if limoSeat >= (numSeats - 1) then
              limoSeat = 0
            end
            limoSeat = limoSeat + 1
            if VEHICLE.IS_VEHICLE_SEAT_FREE(limo, limoSeat, true) then
              PED.SET_PED_INTO_VEHICLE(self.get_ped(), limo, limoSeat)
            else
              gui.show_message("Private Limo", "Seat currently occupied.")
              limoSeat = limoSeat + 1
              return
            end
          end)
        end
      else
        ImGui.Text("Get inside the limo to see the options.")
      end
    end
    ImGui.EndTabItem()
  end
  if ImGui.BeginTabItem("Private Security") then
    ImGui.Text("Choose a Bodyguard Group:")
    ImGui.PushItemWidth(280)
    displayGuards()
    ImGui.PopItemWidth()
    local bGuardData  = filteredGuards[bodyguard_index + 1]
    local myPos       = ENTITY.GET_ENTITY_COORDS(self.get_ped(), true)
    local forwardX    = ENTITY.GET_ENTITY_FORWARD_X(self.get_ped())
    local forwardY    = ENTITY.GET_ENTITY_FORWARD_Y(self.get_ped())
    local myHeading   = ENTITY.GET_ENTITY_HEADING(self.get_ped())
    if spawned_bodyguards[1] == nil then
      if ImGui.Button("Spawn Bodyguards") then
        if flying then
          gui.show_error("Private Security", "Land your private jet first!")
          return
        end
        script.run_in_fiber(function()
          local distMpl = 1.4
          if PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) then
            distMpl = 7
          end
          local myGroup = PED.GET_PED_GROUP_INDEX(self.get_ped())
          if not PED.DOES_GROUP_EXIST(myGroup) then
            myGroup = PED.CREATE_GROUP(0)
          end
          PED.SET_PED_AS_GROUP_LEADER(self.get_ped(), myGroup)
          PED.SET_GROUP_SEPARATION_RANGE(myGroup, 16960)
          PED.SET_GROUP_FORMATION(myGroup, 2)
          PED.SET_GROUP_FORMATION_SPACING(myGroup, 3.0, 3.0, 1.0)
          while not STREAMING.HAS_MODEL_LOADED(bGuardData.modelHash.a) do
            STREAMING.REQUEST_MODEL(bGuardData.modelHash.a)
            coroutine.yield()
          end
          guard_1 = PED.CREATE_PED(bGuardData.pedType, bGuardData.modelHash.a, 0.0, 0.0, 0.0, 0.0, true, false)
          ENTITY.SET_ENTITY_COORDS_NO_OFFSET(guard_1, myPos.x + forwardX * distMpl, myPos.y + forwardY * distMpl, myPos.z, true, false, false)
          ENTITY.SET_ENTITY_HEADING(guard_1, myHeading - 180)
          ENTITY.SET_ENTITY_MAX_HEALTH(guard_1, 1000)
          ENTITY.SET_ENTITY_HEALTH(guard_1, 1000, 0, 0)
          PED.SET_PED_AS_GROUP_MEMBER(guard_1, myGroup)
          PED.SET_PED_NEVER_LEAVES_GROUP(guard_1, true)
          PED.SET_PED_ARMOUR(guard_1, 100)
          WEAPON.GIVE_WEAPON_TO_PED(guard_1, bGuardData.weaponHash.main, 9999, false, true)
          WEAPON.SET_PED_INFINITE_AMMO(guard_1, true, bGuardData.weaponHash.main)
          if bGuardData.weaponHash.sec ~= 0 then
            WEAPON.GIVE_WEAPON_TO_PED(guard_1, bGuardData.weaponHash.sec, 9999, false, true)
            WEAPON.SET_PED_INFINITE_AMMO(guard_1, true, bGuardData.weaponHash.sec)
          end
          table.insert(spawned_bodyguards, guard_1)
          pedConfig(guard_1)
          guard_1Blip = HUD.ADD_BLIP_FOR_ENTITY(guard_1)
          HUD.SET_BLIP_AS_FRIENDLY(guard_1Blip, true)
          HUD.SET_BLIP_SCALE(guard_1Blip, 0.8)
          HUD.SHOW_HEADING_INDICATOR_ON_BLIP(guard_1Blip, true)
          table.insert(guardBlips, guard_1Blip)
          while not STREAMING.HAS_MODEL_LOADED(bGuardData.modelHash.b) do
            STREAMING.REQUEST_MODEL(bGuardData.modelHash.b)
            coroutine.yield()
          end
          guard_2 = PED.CREATE_PED(bGuardData.pedType, bGuardData.modelHash.b, 0.0, 0.0, 0.0, 0.0, true, false)
          ENTITY.SET_ENTITY_COORDS_NO_OFFSET(guard_2, myPos.x + forwardX * distMpl, myPos.y + forwardY * distMpl, myPos.z, true, false, false)
          ENTITY.SET_ENTITY_HEADING(guard_2, myHeading - 180)
          ENTITY.SET_ENTITY_MAX_HEALTH(guard_2, 1000)
          ENTITY.SET_ENTITY_HEALTH(guard_2, 1000, 0, 0)
          PED.SET_PED_AS_GROUP_MEMBER(guard_2, myGroup)
          PED.SET_PED_NEVER_LEAVES_GROUP(guard_2, true)
          PED.SET_PED_ARMOUR(guard_2, 100)
          WEAPON.GIVE_WEAPON_TO_PED(guard_2, bGuardData.weaponHash.main, 9999, false, true)
          WEAPON.SET_PED_INFINITE_AMMO(guard_2, true, bGuardData.weaponHash.main)
          if bGuardData.weaponHash.sec ~= 0 then
            WEAPON.GIVE_WEAPON_TO_PED(guard_2, bGuardData.weaponHash.sec, 9999, false, true)
            WEAPON.SET_PED_INFINITE_AMMO(guard_2, true, bGuardData.weaponHash.sec)
          end
          table.insert(spawned_bodyguards, guard_2)
          pedConfig(guard_2)
          guard_2Blip = HUD.ADD_BLIP_FOR_ENTITY(guard_2)
          HUD.SET_BLIP_AS_FRIENDLY(guard_2Blip, true)
          HUD.SET_BLIP_SCALE(guard_2Blip, 0.8)
          HUD.SHOW_HEADING_INDICATOR_ON_BLIP(guard_2Blip, true)
          table.insert(guardBlips, guard_2Blip)
          while not STREAMING.HAS_MODEL_LOADED(bGuardData.modelHash.c) do
            STREAMING.REQUEST_MODEL(bGuardData.modelHash.c)
            coroutine.yield()
          end
          guard_3 = PED.CREATE_PED(bGuardData.pedType, bGuardData.modelHash.c, 0.0, 0.0, 0.0, 0.0, true, false)
          ENTITY.SET_ENTITY_COORDS_NO_OFFSET(guard_3, myPos.x + forwardX * distMpl, myPos.y + forwardY * distMpl, myPos.z, true, false, false)
          ENTITY.SET_ENTITY_HEADING(guard_3, myHeading - 180)
          ENTITY.SET_ENTITY_MAX_HEALTH(guard_3, 1000)
          ENTITY.SET_ENTITY_HEALTH(guard_3, 1000, 0, 0)
          PED.SET_PED_AS_GROUP_MEMBER(guard_3, myGroup)
          PED.SET_PED_NEVER_LEAVES_GROUP(guard_3, true)
          PED.SET_PED_ARMOUR(guard_3, 100)
          WEAPON.GIVE_WEAPON_TO_PED(guard_3, bGuardData.weaponHash.main, 9999, false, true)
          WEAPON.SET_PED_INFINITE_AMMO(guard_3, true, bGuardData.weaponHash.main)
          if bGuardData.weaponHash.sec ~= 0 then
            WEAPON.GIVE_WEAPON_TO_PED(guard_3, bGuardData.weaponHash.sec, 9999, false, true)
            WEAPON.SET_PED_INFINITE_AMMO(guard_3, true, bGuardData.weaponHash.sec)
          end
          table.insert(spawned_bodyguards, guard_3)
          pedConfig(guard_3)
          guard_3Blip = HUD.ADD_BLIP_FOR_ENTITY(guard_3)
          HUD.SET_BLIP_AS_FRIENDLY(guard_3Blip, true)
          HUD.SET_BLIP_SCALE(guard_3Blip, 0.8)
          HUD.SHOW_HEADING_INDICATOR_ON_BLIP(guard_3Blip, true)
          table.insert(guardBlips, guard_3Blip)
          dismissedGuards = false
          bg_unarmed      = false
        end)
      end
    else
      if ImGui.Button(" Dismiss Bodyguards  ") then
        if dismissedGuards then
          gui.show_error("Private Security", "Your private bodyguards have already been dismissed!")
          return
        end
        dismissedGuards = true
        plyrWindow      = false
        script.run_in_fiber(function(dismissGuards)
          if ENTITY.DOES_ENTITY_EXIST(guard_1) then
            if PED.IS_PED_SITTING_IN_ANY_VEHICLE(guard_1) then
              TASK.TASK_LEAVE_ANY_VEHICLE(guard_1, 100, 0)
            end
            TASK.TASK_WANDER_STANDARD(guard_1, 10.0, 10)
          end
          if ENTITY.DOES_ENTITY_EXIST(guard_2) then
            if PED.IS_PED_SITTING_IN_ANY_VEHICLE(guard_2) then
              TASK.TASK_LEAVE_ANY_VEHICLE(guard_2, 100, 0)
            end
            TASK.TASK_WANDER_STANDARD(guard_2, 10.0, 10)
          end
          if ENTITY.DOES_ENTITY_EXIST(guard_3) then
            if PED.IS_PED_SITTING_IN_ANY_VEHICLE(guard_3) then
              TASK.TASK_LEAVE_ANY_VEHICLE(guard_3, 100, 0)
            end
            TASK.TASK_WANDER_STANDARD(guard_3, 10.0, 10)
          end
          gui.show_message("Private Security", "Bodyguard service has been dismissed. Please wait for your bodyguards to leave.")
          dismissGuards:sleep(10000)
          PED.REMOVE_PED_FROM_GROUP(guard_1)
          PED.REMOVE_PED_FROM_GROUP(guard_2)
          PED.REMOVE_PED_FROM_GROUP(guard_3)
          PED.DELETE_PED(guard_1)
          PED.DELETE_PED(guard_2)
          PED.DELETE_PED(guard_3)
          spawned_bodyguards = {}
          dismissedGuards = false
        end)
      end
    end
    ImGui.SameLine()
    if spawned_escorts[1] == nil then
      if ImGui.Button("Spawn Escorts") then
        if flying then
          gui.show_error("Private Security", "Land your private jet first!")
          return
        end
        if INTERIOR.GET_INTERIOR_FROM_ENTITY(self.get_ped()) == 0 then
          script.run_in_fiber(function(escort)
            local pedPos      = ENTITY.GET_ENTITY_COORDS(self.get_ped(), true)
            local pedHeading  = ENTITY.GET_ENTITY_HEADING(self.get_ped())
            local pedForwardX = ENTITY.GET_ENTITY_FORWARD_X(self.get_ped())
            local pedForwardY = ENTITY.GET_ENTITY_FORWARD_Y(self.get_ped())
            local retry       = 0
            local myGroup     = PED.GET_PED_GROUP_INDEX(self.get_ped())
            if not PED.DOES_GROUP_EXIST(myGroup) then
              myGroup = PED.CREATE_GROUP(0)
            end
            PED.SET_PED_AS_GROUP_LEADER(self.get_ped(), myGroup)
            PED.SET_GROUP_SEPARATION_RANGE(myGroup, 16960)
            PED.SET_GROUP_FORMATION(myGroup, 2)
            PED.SET_GROUP_FORMATION_SPACING(myGroup, 3.0, 3.0, 1.0)
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
            table.insert(spawned_SUV, escortCar)
            escort:sleep(200)
            while not STREAMING.HAS_MODEL_LOADED(bGuardData.modelHash.a) do
              STREAMING.REQUEST_MODEL(bGuardData.modelHash.a)
              coroutine.yield()
            end
            escort_1 = PED.CREATE_PED_INSIDE_VEHICLE(escortCar, bGuardData.pedType, bGuardData.modelHash.a, -1, true, false)
            PED.SET_PED_AS_GROUP_MEMBER(escort_1, myGroup)
            PED.SET_PED_NEVER_LEAVES_GROUP(escort_1, true)
            PED.SET_PED_CAN_TELEPORT_TO_GROUP_LEADER(escort_1, myGroup, true)
            PED.SET_PED_CAN_EVASIVE_DIVE(escort_1, true)
            PED.SET_DRIVER_AGGRESSIVENESS(escort_1, 1.0)
            ENTITY.SET_ENTITY_MAX_HEALTH(escort_1, 1000)
            ENTITY.SET_ENTITY_HEALTH(escort_1, 1000, 0, 0)
            PED.SET_PED_ARMOUR(escort_1, 100)
            WEAPON.GIVE_WEAPON_TO_PED(escort_1, bGuardData.weaponHash.main, 9999, false, true)
            WEAPON.SET_PED_INFINITE_AMMO(escort_1, true, bGuardData.weaponHash.main)
            if bGuardData.weaponHash.sec ~= 0 then
              WEAPON.GIVE_WEAPON_TO_PED(escort_1, bGuardData.weaponHash.sec, 9999, false, true)
              WEAPON.SET_PED_INFINITE_AMMO(escort_1, true, bGuardData.weaponHash.sec)
            end
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
            while not STREAMING.HAS_MODEL_LOADED(bGuardData.modelHash.b) do
              STREAMING.REQUEST_MODEL(bGuardData.modelHash.b)
              coroutine.yield()
            end
            escort_2 = PED.CREATE_PED_INSIDE_VEHICLE(escortCar, bGuardData.pedType, bGuardData.modelHash.b, 0, true, false)
            PED.SET_PED_AS_GROUP_MEMBER(escort_2, myGroup)
            PED.SET_PED_NEVER_LEAVES_GROUP(escort_2, true)
            PED.SET_PED_ARMOUR(escort_2, 100)
            ENTITY.SET_ENTITY_MAX_HEALTH(escort_2, 1000)
            ENTITY.SET_ENTITY_HEALTH(escort_2, 1000, 0, 0)
            WEAPON.GIVE_WEAPON_TO_PED(escort_2, bGuardData.weaponHash.main, 9999, false, true)
            WEAPON.SET_PED_INFINITE_AMMO(escort_2, true, bGuardData.weaponHash.main)
            if bGuardData.weaponHash.sec ~= 0 then
              WEAPON.GIVE_WEAPON_TO_PED(escort_2, bGuardData.weaponHash.sec, 9999, false, true)
              WEAPON.SET_PED_INFINITE_AMMO(escort_2, true, bGuardData.weaponHash.sec)
            end
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
            while not STREAMING.HAS_MODEL_LOADED(bGuardData.modelHash.c) do
              STREAMING.REQUEST_MODEL(bGuardData.modelHash.c)
              coroutine.yield()
            end
            escort_3 = PED.CREATE_PED_INSIDE_VEHICLE(escortCar, bGuardData.pedType, bGuardData.modelHash.c, 1, true, false)
            PED.SET_PED_AS_GROUP_MEMBER(escort_3, myGroup)
            PED.SET_PED_NEVER_LEAVES_GROUP(escort_3, true)
            PED.SET_PED_ARMOUR(escort_3, 100)
            ENTITY.SET_ENTITY_MAX_HEALTH(escort_1, 1000)
            ENTITY.SET_ENTITY_HEALTH(escort_1, 1000, 0, 0)
            WEAPON.GIVE_WEAPON_TO_PED(escort_3, bGuardData.weaponHash.main, 9999, false, true)
            WEAPON.SET_PED_INFINITE_AMMO(escort_3, true, bGuardData.weaponHash.main)
            if bGuardData.weaponHash.sec ~= 0 then
              WEAPON.GIVE_WEAPON_TO_PED(escort_3, bGuardData.weaponHash.sec, 9999, false, true)
              WEAPON.SET_PED_INFINITE_AMMO(escort_3, true, bGuardData.weaponHash.sec)
            end
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
            VEHICLE.SET_VEHICLE_ENGINE_ON(escortCar, true, false, false)
            gui.show_message("Private Security", "Your escort vehicle is waiting behind you.")
            escort:sleep(1000)
            AUDIO.SET_VEH_RADIO_STATION(escortCar, bGuardData.vehRadio)
            dismissed  = false
            es_unarmed = false
          end)
        else
          gui.show_error("Private Security", "You can not call escorts while staying indoors. Go outside and stand in an open area with enough room behind you then try again.")
        end
      end
    else
      if ImGui.Button("  Dismiss Escorts  ") then
        if dismissed then
          gui.show_error("Private Security", "Your private escort has already been dismissed. Please wait for everyone to leave!")
          return
        end
        dismissed  = true
        plyrWindow = false
        script.run_in_fiber(function(dismissEscorts)
          if ENTITY.DOES_ENTITY_EXIST(escortCar) then
            if ENTITY.DOES_ENTITY_EXIST(escort_1) and not ENTITY.IS_ENTITY_DEAD(escort_1) then
              if taskInProgress then
                TASK.CLEAR_PED_TASKS(escort_1)
                TASK.CLEAR_PED_SECONDARY_TASK(escort_1)
                TASK.CLEAR_PRIMARY_VEHICLE_TASK(escortCar)
                TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, 1, 2000)
                taskInProgress  = false
                startFollowTask = false
                followOnFoot    = false
                doingDriveBy    = false
                doDonuts        = false
                doingBurnout    = false
                driveStarted    = false
                driveToWp       = false
              end
            end
            if sittingInEscortCar then
              if not VEHICLE.IS_VEHICLE_STOPPED(escortCar) then
                repeat
                  dismissEscorts:sleep(500)
                until
                VEHICLE.IS_VEHICLE_STOPPED(escortCar) == true -- wait for the vehicle to come to a complete stop before exiting.
              end
              TASK.TASK_LEAVE_VEHICLE(self.get_ped(), escortCar, 0)
              dismissEscorts:sleep(2000) -- the exit animation takes approximately 2s so this wait time prevents escorts from driving off while you're still in the process of exiting the vehicle.
            end
            if escortLeftCar then
              if ENTITY.DOES_ENTITY_EXIST(escort_1) and not ENTITY.IS_ENTITY_DEAD(escort_1) then
                TASK.CLEAR_PED_SECONDARY_TASK(escort_1)
                PED.SET_PED_CONFIG_FLAG(escort_1, 402, true)
                TASK.TASK_ENTER_VEHICLE(escort_1, escortCar, 10000, -1, 2.0, 1, 0, 0)
                if ENTITY.DOES_ENTITY_EXIST(escort_3) and not ENTITY.IS_ENTITY_DEAD(escort_3) then
                  TASK.CLEAR_PED_SECONDARY_TASK(escort_3)
                  PED.SET_PED_CONFIG_FLAG(escort_3, 402, true)
                  PED.SET_PED_INTO_VEHICLE(escort_3, escortCar, 1)
                end
                if ENTITY.DOES_ENTITY_EXIST(escort_2) and not ENTITY.IS_ENTITY_DEAD(escort_2) then
                  TASK.CLEAR_PED_SECONDARY_TASK(escort_2)
                  PED.SET_PED_CONFIG_FLAG(escort_2, 402, true)
                  TASK.TASK_ENTER_VEHICLE(escort_2, escortCar, 10000, 0, 2.0, 1, 0, 0)
                  if not PED.IS_PED_SITTING_IN_VEHICLE(escort_2, escortCar) then
                    repeat
                      dismissEscorts:sleep(500)
                    until
                    PED.IS_PED_SITTING_IN_VEHICLE(escort_2, escortCar) == true
                  end
                end
                escortLeftCar = false
              end
            end
            if ENTITY.DOES_ENTITY_EXIST(escort_1) and not ENTITY.IS_ENTITY_DEAD(escort_1) then
              TASK.TASK_VEHICLE_DRIVE_WANDER(escort_1, escortCar, 25, 2883621)
              dismissEscorts:sleep(10000)
              TASK.CLEAR_PRIMARY_VEHICLE_TASK(escortCar)
            end
            PED.REMOVE_PED_FROM_GROUP(escort_1)
            PED.REMOVE_PED_FROM_GROUP(escort_2)
            PED.REMOVE_PED_FROM_GROUP(escort_3)
            PED.DELETE_PED(escort_1)
            PED.DELETE_PED(escort_2)
            PED.DELETE_PED(escort_3)
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(escortCar, true, true)
            dismissEscorts:sleep(200)
            VEHICLE.DELETE_VEHICLE(escortCar)
            spawned_escorts = {}
            dismissed = false
          else
            TASK.TASK_WANDER_STANDARD(escort_1, 10.0, 10)
            TASK.TASK_WANDER_STANDARD(escort_2, 10.0, 10)
            TASK.TASK_WANDER_STANDARD(escort_3, 10.0, 10)
            dismissEscorts:sleep(10000)
            PED.REMOVE_PED_FROM_GROUP(escort_1)
            PED.REMOVE_PED_FROM_GROUP(escort_2)
            PED.REMOVE_PED_FROM_GROUP(escort_3)
            PED.DELETE_PED(escort_1)
            PED.DELETE_PED(escort_2)
            PED.DELETE_PED(escort_3)
            spawned_escorts = {}
            dismissed       = false
            escortLeftCar   = false
            askedToLeave    = false
          end
        end)
        gui.show_message("Private Security", "Security escort service has been dismissed. Please wait for your escorts to leave.")
      end
    end
    if spawned_bodyguards[1] ~= nil or spawned_escorts[1] ~= nil then
      invincile, used = ImGui.Checkbox("God Mode", invincile, true)
      widgetToolTip(false, "Turn God Mode on/off for bodyguards and escorts. When God Mode is on, ragdoll will be disabled for them.")
      if spawned_bodyguards[1] ~= nil then
        for _, g in ipairs(spawned_bodyguards) do
          script.run_in_fiber(function()
            if invincile then
              ENTITY.SET_ENTITY_INVINCIBLE(g, true)
              PED.SET_PED_CAN_RAGDOLL(g, false)
            else
              ENTITY.SET_ENTITY_INVINCIBLE(g, false)
              PED.SET_PED_CAN_RAGDOLL(g, true)
            end
          end)
        end
      end
      if spawned_escorts[1] ~= nil then
        for _, e in ipairs(spawned_escorts) do
          script.run_in_fiber(function()
            if invincile then
              ENTITY.SET_ENTITY_INVINCIBLE(e, true)
              PED.SET_PED_CAN_RAGDOLL(e, false)
            else
              ENTITY.SET_ENTITY_INVINCIBLE(e, false)
              PED.SET_PED_CAN_RAGDOLL(e, true)
            end
          end)
        end
      end
      ImGui.SameLine()
      allowInside, used = ImGui.Checkbox("Allow Teleport Inside", allowInside, true)
      widgetToolTip(false, "If you travel too far from your bodyguards or escorts, they will automatically teleport to your location but only if you're outside. This option allows them to teleport inside too.")
    end
    if spawned_escorts[1] ~= nil or spawned_bodyguards[1] ~= nil then
      if not wpnWindow then
        if ImGui.Button("SecuroManager") then
          if plyrWindow then
            plyrWindow = false
          end
          wpnWindow = true
        end
        widgetToolTip(false, "Here you can check and instantly refill your bodyguards and escorts health as well as add/remove their weapons.")
      end
      if wpnWindow and not plyrWindow then
        ImGui.SetNextWindowPos(860, 140)
        ImGui.SetNextWindowSizeConstraints(100, 100, 600, 800)
        ImGui.Begin("SecuroManager", ImGuiWindowFlags.AlwaysAutoResize)
        if ImGui.Button("Close") then
          wpnWindow = false
        end
        ImGui.Spacing()
        ImGui.BeginTabBar("SecuroManager")
        if ImGui.BeginTabItem("Health & Armour") then
          if ENTITY.DOES_ENTITY_EXIST(guard_1) then
            g1MaxHp = ENTITY.GET_ENTITY_MAX_HEALTH(guard_1)
            g1Hp    = ENTITY.GET_ENTITY_HEALTH(guard_1)
            g1MaxAr = 100
            g1Ar    = PED.GET_PED_ARMOUR(guard_1)
          end
          if ENTITY.DOES_ENTITY_EXIST(guard_2) then
            g2MaxHp = ENTITY.GET_ENTITY_MAX_HEALTH(guard_2)
            g2Hp    = ENTITY.GET_ENTITY_HEALTH(guard_2)
            g2MaxAr = 100
            g2Ar    = PED.GET_PED_ARMOUR(guard_2)
          end
          if ENTITY.DOES_ENTITY_EXIST(guard_3) then
            g3MaxHp = ENTITY.GET_ENTITY_MAX_HEALTH(guard_3)
            g3Hp    = ENTITY.GET_ENTITY_HEALTH(guard_3)
            g3MaxAr = 100
            g3Ar    = PED.GET_PED_ARMOUR(guard_3)
          end
          if ENTITY.DOES_ENTITY_EXIST(escort_1) then
            e1MaxHp = ENTITY.GET_ENTITY_MAX_HEALTH(escort_1)
            e1Hp    = ENTITY.GET_ENTITY_HEALTH(escort_1)
            e1MaxAr = 100
            e1Ar    = PED.GET_PED_ARMOUR(escort_1)
          end
          if ENTITY.DOES_ENTITY_EXIST(escort_2) then
            e2MaxHp = ENTITY.GET_ENTITY_MAX_HEALTH(escort_2)
            e2Hp    = ENTITY.GET_ENTITY_HEALTH(escort_2)
            e2MaxAr = 100
            e2Ar    = PED.GET_PED_ARMOUR(escort_2)
          end
          if ENTITY.DOES_ENTITY_EXIST(escort_3) then
            e3MaxHp = ENTITY.GET_ENTITY_MAX_HEALTH(escort_3)
            e3Hp    = ENTITY.GET_ENTITY_HEALTH(escort_3)
            e3MaxAr = 100
            e3Ar    = PED.GET_PED_ARMOUR(escort_3)
          end
          if ENTITY.DOES_ENTITY_EXIST(guard_1) then
            ImGui.Text("Bodyguard 1:")
            ImGui.BulletText("Health:  ");ImGui.SameLine();ImGui.Dummy(20, 1);ImGui.SameLine();ImGui.ProgressBar((g1Hp/1000), 100, 20)
            if math.ceil(g1Hp) < g1MaxHp then
              if not ENTITY.IS_ENTITY_DEAD(guard_1) then
                ImGui.SameLine()
                if ImGui.SmallButton("Refill") then
                  script.run_in_fiber(function()
                    ENTITY.SET_ENTITY_HEALTH(guard_1, g1MaxHp, 0, 0)
                  end)
                end
              end
            end
            ImGui.BulletText("Armour:");ImGui.SameLine();ImGui.Dummy(20, 1);ImGui.SameLine();ImGui.ProgressBar((g1Ar/100), 100, 20)
            if math.ceil(g1Ar) < g1MaxAr then
              if not ENTITY.IS_ENTITY_DEAD(guard_1) then
                ImGui.SameLine()
                if ImGui.SmallButton("Refill") then
                  script.run_in_fiber(function()
                    PED.SET_PED_ARMOUR(guard_1, g1MaxAr)
                  end)
                end
              end
            end
          end
          if ENTITY.DOES_ENTITY_EXIST(guard_2) then
            ImGui.Text("Bodyguard 2:")
            ImGui.BulletText("Health:  ");ImGui.SameLine();ImGui.Dummy(20, 1);ImGui.SameLine();ImGui.ProgressBar((g2Hp/1000), 100, 20)
            if math.ceil(g2Hp) < g2MaxHp then
              if not ENTITY.IS_ENTITY_DEAD(guard_2) then
                ImGui.SameLine()
                if ImGui.SmallButton("Refill") then
                  script.run_in_fiber(function()
                    ENTITY.SET_ENTITY_HEALTH(guard_2, g2MaxHp, 0, 0)
                  end)
                end
              end
            end
            ImGui.BulletText("Armour:");ImGui.SameLine();ImGui.Dummy(20, 1);ImGui.SameLine();ImGui.ProgressBar((g2Ar/100), 100, 20)
            if math.ceil(g2Ar) < g2MaxAr then
              if not ENTITY.IS_ENTITY_DEAD(guard_2) then
                ImGui.SameLine()
                if ImGui.SmallButton("Refill") then
                  script.run_in_fiber(function()
                    PED.SET_PED_ARMOUR(guard_2, g1MaxAr)
                  end)
                end
              end
            end
          end
          if ENTITY.DOES_ENTITY_EXIST(guard_3) then
            ImGui.Text("Bodyguard 3:")
            ImGui.BulletText("Health:  ");ImGui.SameLine();ImGui.Dummy(20, 1);ImGui.SameLine();ImGui.ProgressBar((g3Hp/1000), 100, 20)
            if math.ceil(g3Hp) < g3MaxHp then
              if not ENTITY.IS_ENTITY_DEAD(guard_3) then
                ImGui.SameLine()
                if ImGui.SmallButton("Refill") then
                  script.run_in_fiber(function()
                    ENTITY.SET_ENTITY_HEALTH(guard_3, g3MaxHp, 0, 0)
                  end)
                end
              end
            end
            ImGui.BulletText("Armour:");ImGui.SameLine();ImGui.Dummy(20, 1);ImGui.SameLine();ImGui.ProgressBar((g3Ar/100), 100, 20)
            if math.ceil(g3Ar) < g3MaxAr then
              if not ENTITY.IS_ENTITY_DEAD(guard_3) then
                ImGui.SameLine()
                if ImGui.SmallButton("Refill") then
                  script.run_in_fiber(function()
                    PED.SET_PED_ARMOUR(guard_3, g3MaxAr)
                  end)
                end
              end
            end
          end
          if ENTITY.DOES_ENTITY_EXIST(escort_1) then
            ImGui.Text("Escort 1 (driver):")
            ImGui.BulletText("Health:  ");ImGui.SameLine();ImGui.Dummy(20, 1);ImGui.SameLine();ImGui.ProgressBar((e1Hp/1000), 100, 20)
            if math.ceil(e1Hp) < e1MaxHp then
              if not ENTITY.IS_ENTITY_DEAD(escort_1) then
                ImGui.SameLine()
                if ImGui.SmallButton("Refill") then
                  script.run_in_fiber(function()
                    ENTITY.SET_ENTITY_HEALTH(escort_1, e1MaxHp, 0, 0)
                  end)
                end
              end
            end
            ImGui.BulletText("Armour:");ImGui.SameLine();ImGui.Dummy(20, 1);ImGui.SameLine();ImGui.ProgressBar((e1Ar/100), 100, 20)
            if math.ceil(e1Ar) < e1MaxAr then
              if not ENTITY.IS_ENTITY_DEAD(escort_1) then
                ImGui.SameLine()
                if ImGui.SmallButton("Refill") then
                  script.run_in_fiber(function()
                    PED.SET_PED_ARMOUR(escort_1, e1MaxAr)
                  end)
                end
              end
            end
          end
          if ENTITY.DOES_ENTITY_EXIST(escort_2) then
            ImGui.Text("Escort 2:")
            ImGui.BulletText("Health:  ");ImGui.SameLine();ImGui.Dummy(20, 1);ImGui.SameLine();ImGui.ProgressBar((e2Hp/1000), 100, 20)
            if math.ceil(e2Hp) < e2MaxHp then
              if not ENTITY.IS_ENTITY_DEAD(escort_2) then
                ImGui.SameLine()
                if ImGui.SmallButton("Refill") then
                  script.run_in_fiber(function()
                    ENTITY.SET_ENTITY_HEALTH(escort_2, e2MaxHp, 0, 0)
                  end)
                end
              end
            end
            ImGui.BulletText("Armour:");ImGui.SameLine();ImGui.Dummy(20, 1);ImGui.SameLine();ImGui.ProgressBar((e2Ar/100), 100, 20)
            if math.ceil(e2Ar) < e2MaxAr then
              if not ENTITY.IS_ENTITY_DEAD(escort_2) then
                ImGui.SameLine()
                if ImGui.SmallButton("Refill") then
                  script.run_in_fiber(function()
                    PED.SET_PED_ARMOUR(escort_2, e2MaxAr)
                  end)
                end
              end
            end
          end
          if ENTITY.DOES_ENTITY_EXIST(escort_3) then
            ImGui.Text("Escort 3:")
            ImGui.BulletText("Health:  ");ImGui.SameLine();ImGui.Dummy(20, 1);ImGui.SameLine();ImGui.ProgressBar((e3Hp/1000), 100, 20)
            if math.ceil(e3Hp) < e3MaxHp then
              if not ENTITY.IS_ENTITY_DEAD(escort_3) then
                ImGui.SameLine()
                if ImGui.SmallButton("Refill") then
                  script.run_in_fiber(function()
                    ENTITY.SET_ENTITY_HEALTH(escort_3, e3MaxHp, 0, 0)
                  end)
                end
              end
            end
            ImGui.BulletText("Armour:");ImGui.SameLine();ImGui.Dummy(20, 1);ImGui.SameLine();ImGui.ProgressBar((e3Ar/100), 100, 20)
            if math.ceil(e3Ar) < e3MaxAr then
              if not ENTITY.IS_ENTITY_DEAD(escort_3) then
                ImGui.SameLine()
                if ImGui.SmallButton("Refill") then
                  script.run_in_fiber(function()
                    PED.SET_PED_ARMOUR(escort_3, e3MaxAr)
                  end)
                end
              end
            end
          end
          ImGui.EndTabItem()
        end
        if ImGui.BeginTabItem("Weapons") then
          if ImGui.CollapsingHeader("Melee") then
            ImGui.PushItemWidth(250)
            displayMelee()
            ImGui.PopItemWidth()
            local selectedWpn = melee_weapons[meleeIdx + 1]
            local weaponName  = weapons.get_weapon_display_name(selectedWpn)
            if spawned_bodyguards[1] ~= nil then
              if ImGui.Button("Give To Bodyguards") then
                giveWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
                bg_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
              end
            end
            if spawned_escorts[1] ~= nil then
              if ImGui.Button("Give To Escorts") then
                giveWeapon(escort_1, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_2, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_3, selectedWpn, weaponName, "escorts")
                es_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(escort_1, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_2, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_3, selectedWpn, weaponName, "escorts")
              end
            end
          end
          if ImGui.CollapsingHeader("Pistols") then
            ImGui.PushItemWidth(250)
            displayHandguns()
            ImGui.PopItemWidth()
            local selectedWpn = handguns[pistolIdx + 1]
            local weaponName  = weapons.get_weapon_display_name(selectedWpn)
            if spawned_bodyguards[1] ~= nil then
              if ImGui.Button("Give To Bodyguards") then
                giveWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
                bg_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
              end
            end
            if spawned_escorts[1] ~= nil then
              if ImGui.Button("Give To Escorts") then
                giveWeapon(escort_1, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_2, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_3, selectedWpn, weaponName, "escorts")
                es_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(escort_1, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_2, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_3, selectedWpn, weaponName, "escorts")
              end
            end

          end
          if ImGui.CollapsingHeader("SMG") then
            ImGui.PushItemWidth(250)
            displaySmg()
            ImGui.PopItemWidth()
            local selectedWpn = smg[smgIdx + 1]
            local weaponName  = weapons.get_weapon_display_name(selectedWpn)
            if spawned_bodyguards[1] ~= nil then
              if ImGui.Button("Give To Bodyguards") then
                giveWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
                bg_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
              end
            end
            if spawned_escorts[1] ~= nil then
              if ImGui.Button("Give To Escorts") then
                giveWeapon(escort_1, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_2, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_3, selectedWpn, weaponName, "escorts")
                es_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(escort_1, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_2, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_3, selectedWpn, weaponName, "escorts")
              end
            end
          end
          if ImGui.CollapsingHeader("Shotguns") then
            ImGui.PushItemWidth(250)
            displayShotguns()
            ImGui.PopItemWidth()
            local selectedWpn = shotguns[sgIdx + 1]
            local weaponName  = weapons.get_weapon_display_name(selectedWpn)
            if spawned_bodyguards[1] ~= nil then
              if ImGui.Button("Give To Bodyguards") then
                giveWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
                bg_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
              end
            end
            if spawned_escorts[1] ~= nil then
              if ImGui.Button("Give To Escorts") then
                giveWeapon(escort_1, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_2, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_3, selectedWpn, weaponName, "escorts")
                es_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(escort_1, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_2, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_3, selectedWpn, weaponName, "escorts")
              end
            end
          end
          if ImGui.CollapsingHeader("Assault Rifles") then
            ImGui.PushItemWidth(250)
            displayARs()
            ImGui.PopItemWidth()
            local selectedWpn = assault_rifles[arIdx + 1]
            local weaponName  = weapons.get_weapon_display_name(selectedWpn)
            if spawned_bodyguards[1] ~= nil then
              if ImGui.Button("Give To Bodyguards") then
                giveWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
                bg_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
              end
            end
            if spawned_escorts[1] ~= nil then
              if ImGui.Button("Give To Escorts") then
                giveWeapon(escort_1, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_2, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_3, selectedWpn, weaponName, "escorts")
                es_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(escort_1, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_2, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_3, selectedWpn, weaponName, "escorts")
              end
            end
          end
          if ImGui.CollapsingHeader("Machine Guns") then
            ImGui.PushItemWidth(250)
            displayMGs()
            ImGui.PopItemWidth()
            local selectedWpn = machine_guns[mgIdx + 1]
            local weaponName  = weapons.get_weapon_display_name(selectedWpn)
            if spawned_bodyguards[1] ~= nil then
              if ImGui.Button("Give To Bodyguards") then
                giveWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
                bg_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
              end
            end
            if spawned_escorts[1] ~= nil then
              if ImGui.Button("Give To Escorts") then
                giveWeapon(escort_1, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_2, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_3, selectedWpn, weaponName, "escorts")
                es_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(escort_1, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_2, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_3, selectedWpn, weaponName, "escorts")
              end
            end
          end
          if ImGui.CollapsingHeader("Sniper Rifles") then
            ImGui.PushItemWidth(250)
            displaySRs()
            ImGui.PopItemWidth()
            local selectedWpn = sniper_rifles[srIdx + 1]
            local weaponName  = weapons.get_weapon_display_name(selectedWpn)
            if spawned_bodyguards[1] ~= nil then
              if ImGui.Button("Give To Bodyguards") then
                giveWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
                bg_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
              end
            end
            if spawned_escorts[1] ~= nil then
              if ImGui.Button("Give To Escorts") then
                giveWeapon(escort_1, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_2, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_3, selectedWpn, weaponName, "escorts")
                es_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(escort_1, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_2, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_3, selectedWpn, weaponName, "escorts")
              end
            end
          end
          if ImGui.CollapsingHeader("Heavy Weapons") then
            ImGui.PushItemWidth(250)
            displayHvys()
            ImGui.PopItemWidth()
            local selectedWpn = heavy_weapons[hvyIdx + 1]
            local weaponName  = weapons.get_weapon_display_name(selectedWpn)
            if spawned_bodyguards[1] ~= nil then
              if ImGui.Button("Give To Bodyguards") then
                giveWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
                bg_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
              end
            end
            if spawned_escorts[1] ~= nil then
              if ImGui.Button("Give To Escorts") then
                giveWeapon(escort_1, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_2, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_3, selectedWpn, weaponName, "escorts")
                es_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(escort_1, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_2, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_3, selectedWpn, weaponName, "escorts")
              end
            end
          end
          if ImGui.CollapsingHeader("Throwables") then
            ImGui.PushItemWidth(250)
            displayGrs()
            ImGui.PopItemWidth()
            local selectedWpn = throwables[grIdx + 1]
            local weaponName  = weapons.get_weapon_display_name(selectedWpn)
            if spawned_bodyguards[1] ~= nil then
              if ImGui.Button("Give To Bodyguards") then
                giveWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                giveWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
                bg_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
                removeWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
              end
            end
            if spawned_escorts[1] ~= nil then
              if ImGui.Button("Give To Escorts") then
                giveWeapon(escort_1, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_2, selectedWpn, weaponName, "escorts")
                giveWeapon(escort_3, selectedWpn, weaponName, "escorts")
                es_unarmed = false
              end
              ImGui.SameLine()
              if ImGui.Button(" Remove ") then
                removeWeapon(escort_1, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_2, selectedWpn, weaponName, "escorts")
                removeWeapon(escort_3, selectedWpn, weaponName, "escorts")
              end
            end
          end
          -- if ImGui.CollapsingHeader("MISC") then
          --   ImGui.PushItemWidth(250)
          --   displayMiscW()
          --   ImGui.PopItemWidth()
          --   local selectedWpn = misc_weapons[miscIdx + 1]
          --   local weaponName  = weapons.get_weapon_display_name(selectedWpn)
          --   if spawned_bodyguards[1] ~= nil then
          --     if ImGui.Button("Give To Bodyguards") then
          --       giveWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
          --       giveWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
          --       giveWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
          --     end
          --     ImGui.SameLine()
          --     if ImGui.Button(" Remove ") then
          --       removeWeapon(guard_1, selectedWpn, weaponName, "bodyguards")
          --       removeWeapon(guard_2, selectedWpn, weaponName, "bodyguards")
          --       removeWeapon(guard_3, selectedWpn, weaponName, "bodyguards")
          --     end
          --   end
          --   if spawned_escorts[1] ~= nil then
          --     if ImGui.Button("Give To Escorts") then
          --       giveWeapon(escort_1, selectedWpn, weaponName, "escorts")
          --       giveWeapon(escort_2, selectedWpn, weaponName, "escorts")
          --       giveWeapon(escort_3, selectedWpn, weaponName, "escorts")
          --     end
          --     ImGui.SameLine()
          --     if ImGui.Button(" Remove ") then
          --       removeWeapon(escort_1, selectedWpn, weaponName, "escorts")
          --       removeWeapon(escort_2, selectedWpn, weaponName, "escorts")
          --       removeWeapon(escort_3, selectedWpn, weaponName, "escorts")
          --     end
          --   end
          -- end
          ImGui.Spacing();ImGui.Spacing()
          if spawned_bodyguards[1] ~= nil then
            if ImGui.Button("Remove All Bodyguard Weapons") then
              script.run_in_fiber(function()
                if not bg_unarmed then
                  for _, g in ipairs(spawned_bodyguards) do
                    WEAPON.REMOVE_ALL_PED_WEAPONS(g, true)
                    bg_unarmed = true
                  end
                  gui.show_message("Private Security", "Removed all weapons from your bodyguards.")
                else
                  gui.show_error("Private Security", "Your bodyguards do not have any weapons!")
                end
              end)
            end
          end
          if spawned_escorts[1] ~= nil then
            if ImGui.Button("Remove All Escort Weapons") then
              script.run_in_fiber(function()
                  -- es_unarmed = checkForWeapons(e)
                if not es_unarmed then
                  for _, e in ipairs(spawned_escorts) do
                    WEAPON.REMOVE_ALL_PED_WEAPONS(e, true)
                    es_unarmed = true
                  end
                  gui.show_message("Private Security", "Removed all weapons from your escorts.")
                else
                  gui.show_error("Private Security", "Your escorts do not have any weapons!")
                end
              end)
            end
          end
          ImGui.EndTabItem()
        end
        ImGui.End()
      end
      if NETWORK.NETWORK_IS_SESSION_ACTIVE() then
        if not wpnWindow then
          ImGui.SameLine()
        end
        if ImGui.Button("Attack a Player") then
          if wpnWindow then
            wpnWindow = false
          end
          plyrWindow = true
        end
        widgetToolTip(false, "[Work In Progress] May cause issues or not perform as intended.")
        if plyrWindow and not wpnWindow then
          ImGui.SetNextWindowPos(920, 280)
          ImGui.Begin("Attack a Player", ImGuiWindowFlags.NoTitleBar | ImGuiWindowFlags.AlwaysAutoResize)
          if ImGui.Button(" Close ") then
            plyrWindow = false
          end
          ImGui.Text("Choose a Player To Attack:")
          ImGui.PushItemWidth(250)
          displayPlayerList()
          ImGui.PopItemWidth()
          selectedPlayer = filteredPlayers[playerIndex + 1]
          if spawned_bodyguards[1] ~= nil then
            if ImGui.Button("Bodyguards, Fuck'Em Up!") then
              if selectedPlayer == self.get_ped() then
                gui.show_warning("Private Security", "You are their boss! They will not attack you.")
              else
                script.run_in_fiber(function()
                  for _, g in ipairs(spawned_bodyguards) do
                    if PED.IS_PED_SITTING_IN_ANY_VEHICLE(g) then
                      PED.SET_PED_CONFIG_FLAG(g, 167, true)
                      TASK.TASK_LEAVE_ANY_VEHICLE(g, 100, 0)
                    end
                  end
                  targetPlayer    = selectedPlayer
                  bg_attack       = true
                  bgAutoTp        = false
                  plyrWindow      = false
                end)
              end
            end
            if bg_attack then
              ImGui.SameLine()
              if ImGui.Button("Call Back Bodyguards") then
                script.run_in_fiber(function()
                  bg_attack = false
                  TASK.CLEAR_PED_TASKS(guard_1)
                  TASK.CLEAR_PED_TASKS(guard_2)
                  TASK.CLEAR_PED_TASKS(guard_3)
                  PED.SET_PED_CONFIG_FLAG(guard_1, 167, false)
                  PED.SET_PED_CONFIG_FLAG(guard_2, 167, false)
                  PED.SET_PED_CONFIG_FLAG(guard_3, 167, false)
                  bgAutoTp = true
                  gui.show_message("Private Security", "Operation Fuck'Em Up has been canceled. Bodyguards are falling back.")
                end)
              end
            end
          end
          if spawned_escorts[1] ~= nil then
            if ImGui.Button("Escorts, Fuck'Em Up!") then
              if selectedPlayer == self.get_ped() then
                gui.show_warning("Private Security", "You are their boss! They will not attack you.")
              else
                targetPlayer    = selectedPlayer
                es_attack       = true
                esAutoTp        = false
              end
            end
            if es_attack then
              ImGui.SameLine()
              if ImGui.Button("Call Back Escorts") then
                script.run_in_fiber(function()
                  es_attack = false
                  TASK.CLEAR_PED_TASKS(escort_1)
                  TASK.CLEAR_PED_TASKS(escort_2)
                  TASK.CLEAR_PED_TASKS(escort_3)
                  TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, 1, 2000)
                  esAutoTp = true
                  gui.show_message("Private Security", "Operation Fuck'Em Up has been canceled. Escorts are falling back.")
                end)
              end
            end
          end
          ImGui.End()
        end
      else
        if not wpnWindow then
          ImGui.SameLine()
        end
        if ImGui.Button("Attack a Player") then
          gui.show_error("Private Security", "You can not use this feature in Single Player.")
        end
        widgetToolTip(false, "[Work In Progress] May cause issues or not perform as intended.")
      end
    end
    if spawned_escorts[1] ~= nil then
      if not dismissed then
        ImGui.Text("Private Escort Options:")
        ImGui.Separator()
        if ENTITY.DOES_ENTITY_EXIST(escortCar) then
          ImGui.Dummy(90, 1);ImGui.SameLine()
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
                  askedToLeave  = true
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
                askedToLeave  = false
              end)
            end
          end
          ImGui.Dummy(110, 1);ImGui.SameLine()
          if ImGui.Button(" Repair Vehicle ") then
            script.run_in_fiber(function()
            VEHICLE.SET_VEHICLE_FIXED(escortCar)
            VEHICLE.SET_VEHICLE_DEFORMATION_FIXED(escortCar)
            end)
          end
          if onFoot and escortCarAway then
            ImGui.Dummy(120 , 1);ImGui.SameLine()
            if ImGui.Button("Bring Vehicle") then
              script.run_in_fiber(function(bringVeh)
                if INTERIOR.GET_INTERIOR_FROM_ENTITY(self.get_ped()) == 0 then
                  local mPos  = ENTITY.GET_ENTITY_COORDS(self.get_ped(), true)
                  local mHdng = ENTITY.GET_ENTITY_HEADING(self.get_ped())
                  local fwdX  = ENTITY.GET_ENTITY_FORWARD_X(self.get_ped())
                  local fwdY  = ENTITY.GET_ENTITY_FORWARD_Y(self.get_ped())
                  if escortLeftCar then
                    if ENTITY.DOES_ENTITY_EXIST(escort_1) and not ENTITY.IS_ENTITY_DEAD(escort_1) then
                      TASK.CLEAR_PED_TASKS(escort_1)
                      PED.SET_PED_CONFIG_FLAG(escort_1, 402, true)
                      PED.SET_PED_INTO_VEHICLE(escort_1, escortCar, -1)
                    end
                    if ENTITY.DOES_ENTITY_EXIST(escort_2) and not ENTITY.IS_ENTITY_DEAD(escort_2) then
                      TASK.CLEAR_PED_TASKS(escort_2)
                      PED.SET_PED_CONFIG_FLAG(escort_2, 402, true)
                      PED.SET_PED_INTO_VEHICLE(escort_2, escortCar, 0)
                    end
                    if ENTITY.DOES_ENTITY_EXIST(escort_3) and not ENTITY.IS_ENTITY_DEAD(escort_3) then
                      TASK.CLEAR_PED_TASKS(escort_3)
                      PED.SET_PED_CONFIG_FLAG(escort_3, 402, true)
                      PED.SET_PED_INTO_VEHICLE(escort_3, escortCar, 1)
                    end
                    escortLeftCar = false
                    askedToLeave  = false
                    bringVeh:sleep(500)
                  end
                  ENTITY.SET_ENTITY_COORDS_NO_OFFSET(escortCar, mPos.x - (fwdX * 12), mPos.y - (fwdY * 12), mPos.z, true, false, false)
                  ENTITY.SET_ENTITY_HEADING(escortCar, mHdng)
                else
                  gui.show_warning("Private Escort", "You cannot bring the escort vehicle inside.")
                  bringVeh:sleep(1000)
                  return
                end
              end)
            end
          end
          if onFoot and not escortLeftCar then
            if not followOnFoot then
              ImGui.Dummy(130, 1);ImGui.SameLine()
              if ImGui.Button("Follow Me") then
                followOnFoot = true
              end
            else
              ImGui.Dummy(110, 1);ImGui.SameLine()
              if ImGui.Button(" Stop Following ") then
                followOnFoot = false
              end
            end
          end
          ImGui.Text("More Options:")
          ImGui.Separator()
          ImGui.Spacing()
          if sittingInEscortCar then
            ImGui.Dummy(140, 1);ImGui.SameLine();ImGui.Text("Radio")
            if AUDIO.IS_VEHICLE_RADIO_ON(escortCar) then
              ImGui.Dummy(125, 1);ImGui.SameLine()
              if ImGui.Button("Turn Off") then
                AUDIO.SET_VEH_RADIO_STATION(escortCar, "OFF")
              end
              ImGui.Dummy(5, 1);ImGui.SameLine()
              if ImGui.Button("< Previous Station") then
                AUDIO.SET_RADIO_RETUNE_DOWN()
              end
              ImGui.SameLine();ImGui.Spacing();ImGui.SameLine()
              if ImGui.Button("Next Station >") then
                AUDIO.SET_RADIO_RETUNE_UP()
              end
              local stationName = AUDIO.GET_PLAYER_RADIO_STATION_NAME()
              local displayName = HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(stationName)
              ImGui.Text("Now Playing: "..displayName)
              ImGui.Separator()
            else
              ImGui.Dummy(125, 1);ImGui.SameLine()
              if ImGui.Button("Turn On") then
                AUDIO.SET_VEH_RADIO_STATION(escortCar, bGuardData.vehRadio)
              end
            end
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
                TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(escort_1, escortCar, destination.x, destination.y, destination.z, 40, 1074528293, 20.0) --old=2883621
                driveToWp       = true
                driveStarted    = false
                doingBurnout    = false
                doingDriveBy    = false
                doDonuts        = false
                taskInProgress  = true
                currentTask     = "driving to waypoint"
              end)
            end
            ImGui.SameLine();
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
            ImGui.Text("Start Doing a Burnout")
            if ImGui.Button("Do a Burnout") then
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
            ImGui.Text("Start Doing Donuts")
            helpmarker(false, "You can use the \"Change Direction\" button to turn donuts into MAAD drifts.")
            if ImGui.Button("Do Some Donuts") then
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
        else
          escortLeftCar = false
          askedToLeave  = false
          ImGui.TextWrapped("Escort vehicle not found!\n\nEscorts are useless without their vehicle. It is recommended that you dismiss them then spawn them again.")
        end
      end
    end
    ImGui.EndTabItem()
  end
  --------------------debug section------------------------------------------------------------------------------
  ImGui.Spacing();ImGui.Dummy(270, 1);ImGui.SameLine()
  ImGui.TextDisabled("v0.4.3")
  if ImGui.IsItemHovered() and ImGui.IsItemClicked(0) then
    dbgclc = dbgclc + 1
  end
  if dbgclc == 5 then
    dbgWindow = true
  elseif dbgclc > 5 then
    dbgWindow = false
    dbgclc  = 0
  end
  if dbgWindow then
    ImGui.SetNextWindowSizeConstraints(450, 100, 600, 800)
    ImGui.Begin("##bsDebug", ImGuiWindowFlags.AlwaysAutoResize | ImGuiWindowFlags.NoTitleBar)
    ImGui.Text("Billionaire Services Debug");ImGui.SameLine(380)
    if ImGui.Button("Close") then
      dbgWindow = false
      dbgclc    = 0
    end
    ImGui.Spacing()
    script.run_in_fiber(function()
      dbgPos               = ENTITY.GET_ENTITY_COORDS(self.get_ped(), false)
      dbgHeading           = ENTITY.GET_ENTITY_HEADING(self.get_ped())
      local streetHash     = PATHFIND.GET_STREET_NAME_AT_COORD(dbgPos.x, dbgPos.y, dbgPos.z)
      dbgstreetName        = HUD.GET_STREET_NAME_FROM_HASH_KEY(streetHash)
      -- if string.find(string.lower(streetName), "panorama") then retVal = true end
      if PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) then
        dbgVeh          = PED.GET_VEHICLE_PED_IS_IN(self.get_ped())
        dbgRadio        = HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(AUDIO.GET_PLAYER_RADIO_STATION_NAME())
        dbgTrack        = AUDIO.GET_CURRENT_TRACK_SOUND_NAME(AUDIO.GET_PLAYER_RADIO_STATION_NAME())
        dbgtrackName    = HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(dbgTrack)
        dbgSeats        = VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(dbgVeh)
        dbgMaxSeats     = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(dbgVeh))
        for i = -1, dbgMaxSeats do
          local pedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(dbgVeh, i, false)
          if pedInSeat == self.get_ped() then
            dbgPlyrSeat = i
          end
        end
      end
      if ENTITY.DOES_ENTITY_EXIST(guard_1) then
        dbg1Hp = ENTITY.GET_ENTITY_HEALTH(guard_1)
      end
      if ENTITY.DOES_ENTITY_EXIST(guard_2) then
        dbg2Hp = ENTITY.GET_ENTITY_HEALTH(guard_2)
      end
      if ENTITY.DOES_ENTITY_EXIST(guard_3) then
        dbg3Hp = ENTITY.GET_ENTITY_HEALTH(guard_3)
      end
      if ENTITY.DOES_ENTITY_EXIST(escort_1) then
        dbg4Hp = ENTITY.GET_ENTITY_HEALTH(escort_1)
      end
      if ENTITY.DOES_ENTITY_EXIST(escort_2) then
        dbg5Hp = ENTITY.GET_ENTITY_HEALTH(escort_2)
      end
      if ENTITY.DOES_ENTITY_EXIST(escort_3) then
        dbg6Hp = ENTITY.GET_ENTITY_HEALTH(escort_3)
      end
    end)
    ImGui.Text("Player:")
    ImGui.BulletText("Player Position:");ImGui.SameLine();ImGui.Dummy(20, 1);ImGui.SameLine();ImGui.Text(tostring(dbgPos))
    if ImGui.IsItemHovered() and ImGui.IsItemClicked(0) then
      log.debug(tostring(dbgPos))
    end
    ImGui.BulletText("Heading:");ImGui.SameLine();ImGui.Dummy(70, 1);ImGui.SameLine();ImGui.Text(tostring(dbgHeading))
    if ImGui.IsItemHovered() and ImGui.IsItemClicked(0) then
      log.debug(tostring(dbgHeading))
    end
    ImGui.BulletText("Street Name:");ImGui.SameLine();ImGui.Dummy(40, 1);ImGui.SameLine();ImGui.Text(tostring(dbgstreetName))
    if PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) then
      ImGui.Spacing();ImGui.Text("Vehicle:")
      ImGui.BulletText("Radio Station:");ImGui.SameLine();ImGui.Dummy(35, 1);ImGui.SameLine();ImGui.Text(tostring(dbgRadio))
      ImGui.BulletText("Song Name:");ImGui.SameLine();ImGui.Dummy(45, 1);ImGui.SameLine();ImGui.Text(tostring(dbgtrackName))
      ImGui.BulletText("Max Passengers:");ImGui.SameLine();ImGui.Dummy(10, 1);ImGui.SameLine();ImGui.Text(tostring(dbgSeats))
      ImGui.BulletText("Player Seat: ");ImGui.SameLine();ImGui.Dummy(40, 1);ImGui.SameLine();ImGui.Text(tostring(dbgPlyrSeat))
    end
    if spawned_bodyguards[1] ~= nil then
      ImGui.Spacing();ImGui.Text("Bodyguards/Escorts:")
      if ENTITY.DOES_ENTITY_EXIST(guard_1) then
        ImGui.BulletText("BG1 Health:");ImGui.SameLine();ImGui.Dummy(65, 1);ImGui.SameLine();ImGui.Text(tostring(dbg1Hp))
      end
      if ENTITY.DOES_ENTITY_EXIST(guard_2) then
        ImGui.BulletText("BG2 Health:");ImGui.SameLine();ImGui.Dummy(60, 1);ImGui.SameLine();ImGui.Text(tostring(dbg2Hp))
      end
      if ENTITY.DOES_ENTITY_EXIST(guard_3) then
        ImGui.BulletText("BG3 Health:");ImGui.SameLine();ImGui.Dummy(60, 1);ImGui.SameLine();ImGui.Text(tostring(dbg3Hp))
      end
    end
    if spawned_escorts[1] ~= nil then
      if ENTITY.DOES_ENTITY_EXIST(escort_1) then
        ImGui.BulletText("ES1 Health:");ImGui.SameLine();ImGui.Dummy(65, 1);ImGui.SameLine();ImGui.Text(tostring(dbg4Hp))
      end
      if ENTITY.DOES_ENTITY_EXIST(escort_2) then
        ImGui.BulletText("ES2 Health:");ImGui.SameLine();ImGui.Dummy(60, 1);ImGui.SameLine();ImGui.Text(tostring(dbg5Hp))
      end
      if ENTITY.DOES_ENTITY_EXIST(escort_3) then
        ImGui.BulletText("ES3 Health:");ImGui.SameLine();ImGui.Dummy(60, 1);ImGui.SameLine();ImGui.Text(tostring(dbg6Hp))
      end
    end
    if PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) then
      ImGui.Spacing();ImGui.Separator();ImGui.TextWrapped("Make your vehicle's radio sound louder from the outside.")
      widgetToolTip(false, "Sit inside your vehicle, turn on the radio, press the on button below then exit your vehicle. If the engine gets turned off after you exit, turn it back on from the interaction menu.")
      if ImGui.Button("Loud Radio On") then
        script.run_in_fiber(function()
          AUDIO.SET_VEHICLE_RADIO_LOUD(PED.GET_VEHICLE_PED_IS_USING(self.get_ped()), true)
        end)
      end
      ImGui.SameLine()
      if ImGui.Button("Loud Radio Off") then
        script.run_in_fiber(function()
          AUDIO.SET_VEHICLE_RADIO_LOUD(PED.GET_VEHICLE_PED_IS_USING(self.get_ped()), false)
        end)
      end
    end
    ImGui.End()
  end
  -------------------------------------------------------------------------------------------------------------
end)
script.register_looped("blipManager", function()
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
    if HUD.DOES_BLIP_EXIST(guard_1Blip) then
      if PED.IS_PED_SITTING_IN_ANY_VEHICLE(guard_1) then
        HUD.SET_BLIP_ALPHA(guard_1Blip, 0.0)
      else
        HUD.SET_BLIP_ALPHA(guard_1Blip, 1000.0)
      end
      if PED.IS_PED_SITTING_IN_ANY_VEHICLE(guard_2) then
        HUD.SET_BLIP_ALPHA(guard_2Blip, 0.0)
      else
        HUD.SET_BLIP_ALPHA(guard_2Blip, 1000.0)
      end
      if PED.IS_PED_SITTING_IN_ANY_VEHICLE(guard_3) then
        HUD.SET_BLIP_ALPHA(guard_3Blip, 0.0)
      else
        HUD.SET_BLIP_ALPHA(guard_3Blip, 1000.0)
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
    if ENTITY.DOES_ENTITY_EXIST(guard_1) and ENTITY.IS_ENTITY_DEAD(guard_1) then
      services:sleep(3000)
      PED.REMOVE_PED_FROM_GROUP(guard_1)
      PED.DELETE_PED(guard_1)
    end
    if ENTITY.DOES_ENTITY_EXIST(guard_2) and ENTITY.IS_ENTITY_DEAD(guard_2) then
      services:sleep(3000)
      PED.REMOVE_PED_FROM_GROUP(guard_2)
      PED.DELETE_PED(guard_2)
    end
    if ENTITY.DOES_ENTITY_EXIST(guard_3) and ENTITY.IS_ENTITY_DEAD(guard_3) then
      services:sleep(3000)
      PED.REMOVE_PED_FROM_GROUP(guard_3)
      PED.DELETE_PED(guard_3)
    end
    if not ENTITY.DOES_ENTITY_EXIST(guard_1) and not ENTITY.DOES_ENTITY_EXIST(guard_2) and not ENTITY.DOES_ENTITY_EXIST(guard_3) then
      spawned_bodyguards = {}
      dismissedGuards    = true
    end
    if sittingInLimo then
      if not dismissed then
        if PED.IS_PED_TRYING_TO_ENTER_A_LOCKED_VEHICLE(guard_1) then
          for i = 2, 4 do
            if VEHICLE.IS_VEHICLE_SEAT_FREE(limo, i, true) then
              PED.SET_PED_INTO_VEHICLE(guard_1, limo, i)
            end
          end
        end
        if PED.IS_PED_TRYING_TO_ENTER_A_LOCKED_VEHICLE(guard_2) then
          for i = 2, 4 do
            if VEHICLE.IS_VEHICLE_SEAT_FREE(limo, i, true) then
              PED.SET_PED_INTO_VEHICLE(guard_2, limo, i)
            end
          end
        end
        if PED.IS_PED_TRYING_TO_ENTER_A_LOCKED_VEHICLE(guard_3) then
          for i = 2, 4 do
            if VEHICLE.IS_VEHICLE_SEAT_FREE(limo, i, true) then
              PED.SET_PED_INTO_VEHICLE(guard_3, limo, i)
            end
          end
        end
      end
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
            local vehCoords  = ENTITY.GET_ENTITY_COORDS(escortCar, false)
            local wpCoords   = HUD.GET_BLIP_COORDS(wp)
            local dist       = SYSTEM.VDIST(vehCoords.x, vehCoords.y, vehCoords.z, wpCoords.x, wpCoords.y, wpCoords.z)
            if dist <= 50.0 then
              gui.show_message("Private Security", "You have reached your destination.")
              services:sleep(2000)
              TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, 1, 2000)
              driveToWp      = false
              driveStarted   = false
              taskInProgress = false
              currentTask    = "None."
            end
          else
            gui.show_message("Private Security", "Waypoint was removed. Canceling trip...")
            TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, 1, 2000)
            driveToWp      = false
            driveStarted   = false
            taskInProgress = false
            currentTask    = "None."
          end
        else
          driveToWp      = false
          driveStarted   = false
          taskInProgress = false
          currentTask    = "None."
        end
    end
    if dismissed then
      if ENTITY.DOES_ENTITY_EXIST(escortCar) then
        if HUD.DOES_BLIP_EXIST(carBlip) then
          HUD.SET_BLIP_ALPHA(carBlip, 100.0)
        end
      else
        if HUD.DOES_BLIP_EXIST(escort_1Blip) then
          HUD.SET_BLIP_ALPHA(escort_1Blip, 100.0)
        end
        if HUD.DOES_BLIP_EXIST(escort_2Blip) then
          HUD.SET_BLIP_ALPHA(escort_2Blip, 100.0)
        end
        if HUD.DOES_BLIP_EXIST(escort_3Blip) then
          HUD.SET_BLIP_ALPHA(escort_3Blip, 100.0)
        end
      end
    end
    if ENTITY.DOES_ENTITY_EXIST(escortCar) then
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
  end
  if spawned_limo[1] ~= nil then
    if PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), limo) then
      sittingInLimo = true
    else
      sittingInLimo = false
    end
    if limoWp then
      if ENTITY.DOES_ENTITY_EXIST(limo) then
        if not sittingInLimo then
          TASK.CLEAR_PED_TASKS(limoDriver)
          TASK.CLEAR_PED_SECONDARY_TASK(limoDriver)
          TASK.CLEAR_PRIMARY_VEHICLE_TASK(limo)
          TASK.TASK_VEHICLE_TEMP_ACTION(limoDriver, limo, 1, 2000)
          limoWp = false
        end
        local wp = HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID())
        if HUD.DOES_BLIP_EXIST(wp) then
          local limoCoods  = ENTITY.GET_ENTITY_COORDS(limo, false)
          local wpCoords   = HUD.GET_BLIP_COORDS(wp)
          local dist       = SYSTEM.VDIST(limoCoods.x, limoCoods.y, limoCoods.z, wpCoords.x, wpCoords.y, wpCoords.z)
          if dist <= 50.0 then
            gui.show_message("Private Limo", "You have reached your destination.")
            services:sleep(2000)
            TASK.TASK_VEHICLE_TEMP_ACTION(limoDriver, limo, 1, 2000)
            limoWp = false
          end
        else
          gui.show_message("Private Limo", "Waypoint was removed. Canceling trip...")
          TASK.TASK_VEHICLE_TEMP_ACTION(limoDriver, limo, 1, 2000)
          limoWp = false
        end
      else
        limoWp = false
      end
    end
    if limoCr then
      if ENTITY.DOES_ENTITY_EXIST(limo) then
        if not sittingInLimo then
          TASK.CLEAR_PED_TASKS(limoDriver)
          TASK.CLEAR_PED_SECONDARY_TASK(limoDriver)
          TASK.CLEAR_PRIMARY_VEHICLE_TASK(limo)
          TASK.TASK_VEHICLE_TEMP_ACTION(limoDriver, limo, 1, 2000)
          limoCr = false
        end
      else
        limoCr = false
      end
    end
    if flying then
      if ENTITY.DOES_ENTITY_EXIST(limo) then
        showLimoMsg = true
        services:sleep(7000)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(limo, true, true)
        services:sleep(200)
        VEHICLE.DELETE_VEHICLE(limo)
        if ENTITY.DOES_ENTITY_EXIST(limoDriver) then
          PED.DELETE_PED(limoDriver)
        end
        if showLimoMsg then
          gui.show_message("Private Limo", "Your private limo has been dismissed. Enjoy your flight!")
          showLimoMsg = false
        end
        spawned_limo = {}
        limoDismissed = true
      end
    end
  end
end)
script.register_looped("Plane Landing", function(planeland)
  if startLandingProcess then
    local airportData = filteredAirports[airport_index + 1]
    local jetPos      = ENTITY.GET_ENTITY_COORDS(pJet, false)
    local airportDist = SYSTEM.VDIST(jetPos.x, jetPos.y, jetPos.z, airportData.checkPos.x, airportData.checkPos.y, airportData.checkPos.z)
    if airportDist > 200 and airportDist <= 1000 then
      TASK.TASK_PLANE_LAND(pilot, pJet, airportData.runwayStart.x, airportData.runwayStart.y, airportData.runwayStart.z, airportData.runwayEnd.x, airportData.runwayEnd.y, airportData.runwayEnd.z)
      planeland:sleep(1000)
      startLandingProcess = false
      started_landing     = true
      setHeading          = airportData.heading
      hangarPos           = airportData.hangar
      planeland:sleep(10000) -- sleep for 10 seconds then show an optional skip button in case the pilot was struggling to land.
      showLandingSkip = true
      showSkipNotif   = true
    elseif airportDist > 1000 then
      TASK.TASK_PLANE_MISSION(pilot, pJet, 0, 0, airportData.checkPos.x, airportData.checkPos.y, airportData.checkPos.z, 4, 100.0, 0, airportData.checkPosHdng, 0, 0, 200)
    end
  end
end)
script.register_looped("Jet Manager", function(jetMgr)
  if spawned_jet[1] ~= nil then
    local myPos  = ENTITY.GET_ENTITY_COORDS(self.get_ped(), true)
    local jetPos = ENTITY.GET_ENTITY_COORDS(pJet, false)
    local jetDist = SYSTEM.VDIST(myPos.x, myPos.y, myPos.z, jetPos.x, jetPos.y, jetPos.z)
    if jetDist > 1000 then
      jetTpBtn = true
    else
      jetTpBtn = false
    end
    if nineEleven then
      ENTITY.SET_ENTITY_INVINCIBLE(pJet, false)
      ENTITY.SET_ENTITY_INVINCIBLE(pilot, false)
      ENTITY.SET_ENTITY_INVINCIBLE(copilot, false)
      ENTITY.SET_ENTITY_HEALTH(pJet, 150, 0, 0)
      local attackDist = SYSTEM.VDIST(jetPos.x, jetPos.y, jetPos.z, -77.7393, -802.863, 207.17)
      if attackDist <= 420 then
        VEHICLE.SET_ALLOW_VEHICLE_EXPLODES_ON_CONTACT(pJet, true)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(pilot)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(pilot, -216.967, -847.54, 31.9004, true, false, false)
        ENTITY.SET_ENTITY_HEALTH(pilot, 0, 0, 0)
      end
      if ENTITY.IS_ENTITY_DEAD(pilot) then
        jetMgr:sleep(5000)
        PED.REMOVE_PED_FROM_GROUP(copilot)
        PED.DELETE_PED(pilot)
        PED.DELETE_PED(copilot)
        spawned_pilot = {}
        if not ENTITY.DOES_ENTITY_EXIST(pilot) then
          if VEHICLE.GET_VEHICLE_BODY_HEALTH(pJet) <= 100 then
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(pJet, true, true)
            jetMgr:sleep(2000)
            VEHICLE.DELETE_VEHICLE(pJet)
            spawned_jet = {}
            nineEleven  = false
          end
        end
        jetDismissed    = true
        flying          = false
        initialFlight   = true
        newFlight       = false
        disableArprtLst = false
        arprtLstTop     = true
        btnPress        = 0
      end
    end
    if PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), pJet) then
      local jetPos = ENTITY.GET_ENTITY_COORDS(pJet, false)
      local jetAltitude = jetPos.z
      local airportData = filteredAirports[airport_index + 1]
      local runwayEndDist = SYSTEM.VDIST(jetPos.x, jetPos.y, jetPos.z, airportData.runwayEnd.x, airportData.runwayEnd.y, airportData.runwayEnd.z)
      if jetAltitude >= 150 then
        if not nineEleven then
          can_land = true
        else
          can_land = false
        end
      else
        can_land = false
      end
      if started_landing and not skippedLandingProcess then
        -- if runwayEndDist <= 200 then
          -- TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(pilot, pJet, airportData.runwayEnd.x, airportData.runwayEnd.y, airportData.runwayEnd.z, 5.0, 786603, 80.0)
          if (ENTITY.GET_ENTITY_SPEED(pJet) * 3.6) <= 10.0 then
            CAM.DO_SCREEN_FADE_OUT(1000)
            jetMgr:sleep(500)
            TASK.CLEAR_PED_TASKS(pilot)
            TASK.CLEAR_PED_SECONDARY_TASK(pilot)
            TASK.CLEAR_PRIMARY_VEHICLE_TASK(pJet)
            VEHICLE.BRING_VEHICLE_TO_HALT(pJet, 5.0, 2000, true)
            showLandingSkip = false
            jetMgr:sleep(500)
            MISC.CLEAR_AREA_OF_VEHICLES(hangarPos.x, hangarPos.y, hangarPos.z, 5.0, false, false, false, false, false, false, 0)
            ENTITY.SET_ENTITY_COORDS(pJet, hangarPos.x, hangarPos.y, hangarPos.z, true, true, true, true)
            ENTITY.SET_ENTITY_HEADING(pJet, setHeading)
            VEHICLE.SET_VEHICLE_ENGINE_ON(pJet, false, true, false)
            VEHICLE.SET_VEHICLE_DOOR_OPEN(pJet, 0, false, false)
            CAM.DO_SCREEN_FADE_IN(1000)
            started_landing = false
            initialFlight   = true
            newFlight       = false
            flying          = false
          end
        -- end
      end
    end
    if startLandingProcess or started_landing then
      disableArprtLst = true
    else
      disableArprtLst = false
    end
    if flying and not PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), pJet) then
      showBailMsg = true
      if ENTITY.DOES_ENTITY_EXIST(pilot) or ENTITY.DOES_ENTITY_EXIST(copilot) then
        jetMgr:sleep(10000)
        PED.DELETE_PED(pilot)
        PED.DELETE_PED(copilot)
        if ENTITY.DOES_ENTITY_EXIST(pJet) then
          ENTITY.SET_ENTITY_AS_MISSION_ENTITY(pJet, true, true)
          jetMgr:sleep(200)
          VEHICLE.DELETE_VEHICLE(pJet)
        end
        startLandingProcess = false
        started_landing     = false
        showLandingSkip     = false
        initialFlight       = true
        jetDismissed        = true
        arprtLstTop         = true
        newFlight           = false
        can_land            = false
        flying              = false
        disableArprtLst     = false
        spawned_jet         = {}
        spawned_pilot       = {}
        if showBailMsg then
          gui.show_message("Private Jet", "Since you've decided to go for a skydive, your private jet has been dismissed.")
          showBailMsg = false
        end
      end
    end
    if showLandingSkip then
      if showSkipNotif then
        gui.show_message("Private Jet", "You can now skip the landing process if you would like to.")
        showSkipNotif = false
      end
    end
  end
end)

script.register_looped("Escort In/Out", function()
  if PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) then
    if PAD.IS_CONTROL_PRESSED(0, 23) and not dismissed then
      local myPos = ENTITY.GET_ENTITY_COORDS(self.get_ped(), true)
      local ecPos = ENTITY.GET_ENTITY_COORDS(escortCar, false)
      local dist = SYSTEM.VDIST(myPos.x, myPos.y, myPos.z, ecPos.x, ecPos.y, ecPos.z)
      if dist > 150 then
        return
      end
      startFollowTask = false
      PED.SET_PED_CONFIG_FLAG(escort_1, 402, false)
      PED.SET_PED_CONFIG_FLAG(escort_2, 402, false)
      PED.SET_PED_CONFIG_FLAG(escort_3, 402, false)
      TASK.TASK_LEAVE_VEHICLE(escort_1, escortCar, 1)
      TASK.TASK_LEAVE_VEHICLE(escort_2, escortCar, 1)
      TASK.TASK_LEAVE_VEHICLE(escort_3, escortCar, 1)
      escortLeftCar = true
    end
  end
end)

script.register_looped("misc", function(misc)
  misc:yield()
  if PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) and not sittingInEscortCar and not sittingInLimo then
    local myVeh      = PED.GET_VEHICLE_PED_IS_USING(self.get_ped())
    local myVehModel = ENTITY.GET_ENTITY_MODEL(myVeh)
    if VEHICLE.IS_THIS_MODEL_A_CAR(myVehModel) or VEHICLE.IS_THIS_MODEL_A_BIKE(myVehModel) or VEHICLE.IS_THIS_MODEL_A_QUADBIKE(myVehModel) or VEHICLE.IS_THIS_MODEL_A_BICYCLE(myVehModel) then
      if not sittingInEscortCar then
        validModel = true
        if not es_attack then
          startFollowTask = true
        else
          startFollowTask = false
        end
      end
    else
      validModel      = false
      startFollowTask = false
    end
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
    end
    misc:sleep(500)
    if not dismissed and not es_attack then
      if startFollowTask then
        if not PED.IS_PED_SITTING_IN_VEHICLE(escort_1, escortCar) then
          TASK.TASK_ENTER_VEHICLE(escort_1, escortCar, 10000, -1, 2.0, 1, 0, 0)
          repeat
          misc:sleep(1000)
          until
          PED.IS_PED_SITTING_IN_VEHICLE(escort_1, escortCar) == true
        end
        TASK.TASK_VEHICLE_ESCORT(escort_1, escortCar, myVeh, -1, mySpeed + 6.0, 24904187, 3.0, 3.0, 3.0) -- old=1074528293
      end
    end
  end
  if sittingInLimo then
    if not es_attack then
      startFollowTask = true
    end
    if not dismissed then
      local limoSpeed = ENTITY.GET_ENTITY_SPEED(limo)
      if escortLeftCar then
        TASK.CLEAR_PED_SECONDARY_TASK(escort_2)
        TASK.CLEAR_PED_SECONDARY_TASK(escort_3)
        PED.SET_PED_CONFIG_FLAG(escort_1, 402, true)
        PED.SET_PED_CONFIG_FLAG(escort_2, 402, true)
        PED.SET_PED_CONFIG_FLAG(escort_3, 402, true)
        TASK.TASK_ENTER_VEHICLE(escort_2, escortCar, 10000, 0, 2.0, 1, 0, 0)
        PED.SET_PED_INTO_VEHICLE(escort_3, escortCar, 1)
        escortLeftCar = false
      end
      TASK.TASK_VEHICLE_ESCORT(escort_1, escortCar, limo, -1, limoSpeed + 2.0, 24904187, 3.0, 3.0, 3.0)
      if limoDismissed then
        TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, 1, 2000)
        startFollowTask = false
      end
    end
  end
  if doDonuts then
    VEHICLE.SET_DRIFT_TYRES(escortCar, true)
    VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(escortCar, 20)
    TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, donutDirection, 100000)
  else
    VEHICLE.SET_DRIFT_TYRES(escortCar, false)
    VEHICLE.SET_VEHICLE_CHEAT_POWER_INCREASE(escortCar, 1.0)
  end
  if doingDriveBy then
    local victim = nearestPed(escortCar)
    if victim ~= 0 then
      -- TASK.TASK_VEHICLE_MISSION_PED_TARGET(escort_1, escortCar, victim, 6, 45, 1074528293, 5.0, 0.1, true) -- very aggressive! makes the driver chase the random victim which may result in the driver getting the car stuck or crashing it.
      TASK.TASK_VEHICLE_DRIVE_WANDER(escort_1, escortCar, 40, 1074528293) -- not aggressive. driver doesn't chase victim but drives randomly instead.
      TASK.TASK_DRIVE_BY(escort_2, victim, 0, 0.0, 0.0, 0.0, 100, 100, false, -957453492) -- old firing pattern: joaat("firing_pattern_burst_fire_driveby") = -753768974 || new firing pattern: joaat("firing_pattern_full_auto") = -957453492
      TASK.TASK_DRIVE_BY(escort_3, victim, 0, 0.0, 0.0, 0.0, 100, 100, false, -957453492)
    else
      gui.show_error("Parivate Security", "Could not find a victim nearby! Try moving closer to a populated area.")
      doingDriveBy = false
    end
  end
  if not dismissed then
    if not sittingInEscortCar then
      local myPos = ENTITY.GET_ENTITY_COORDS(self.get_ped(), true)
      if PED.IS_PED_SHOOTING_IN_AREA(self.get_ped(), myPos.x - 100, myPos.y - 100, myPos.z -100, myPos.x + 100, myPos.y + 100, myPos.z + 100, false, true) and not escortLeftCar then
        if not PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) then
          startFollowTask = false
          followOnFoot    = false
          PED.SET_PED_CONFIG_FLAG(escort_1, 402, false)
          PED.SET_PED_CONFIG_FLAG(escort_2, 402, false)
          PED.SET_PED_CONFIG_FLAG(escort_3, 402, false)
          TASK.TASK_LEAVE_VEHICLE(escort_1, escortCar, 256)
          TASK.TASK_LEAVE_VEHICLE(escort_2, escortCar, 256)
          TASK.TASK_LEAVE_VEHICLE(escort_3, escortCar, 256)
          escortLeftCar = true
        end
      end
    end
  end
  if not PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) then
    onFoot = true
  else
    onFoot       = false
    followOnFoot = false
    PED.SET_PED_CONFIG_FLAG(self.get_ped(), 398, true)
  end
  if spawned_bodyguards[1] ~= nil then
    if not dismissedGuards then
      local myGroup = PED.GET_PED_GROUP_INDEX(self.get_ped())
      if not PED.DOES_GROUP_EXIST(myGroup) then
        myGroup = PED.CREATE_GROUP(0)
      end
      PED.SET_PED_AS_GROUP_LEADER(self.get_ped(), myGroup)
      ---------auto-TP bodyguards-------------------------------
      if bgAutoTp then
        if PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) then
          distMult = 10
        else
          distMult = 2
          if not validModel then
            return
          end
        end
        if not flying then
          for _, g in ipairs(spawned_bodyguards) do
            local mPos = ENTITY.GET_ENTITY_COORDS(self.get_ped(), true)
            local fwdX = ENTITY.GET_ENTITY_FORWARD_X(self.get_ped())
            local fwdY = ENTITY.GET_ENTITY_FORWARD_Y(self.get_ped())
            local gPos = ENTITY.GET_ENTITY_COORDS(g, true)
            local dist = SYSTEM.VDIST(mPos.x, mPos.y, mPos.z, gPos.x, gPos.y, gPos.z)
            if dist > 100 then
              if allowInside then
                misc:sleep(1000)
                if not CAM.IS_SCREEN_FADED_IN() then
                  return
                end
                TASK.CLEAR_PED_TASKS(g)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(g, mPos.x + (fwdX * distMult), mPos.y + (fwdY * distMult), mPos.z, true, false, false)
              else
                misc:sleep(1000)
                if INTERIOR.GET_INTERIOR_FROM_ENTITY(self.get_ped()) == 0 then
                  TASK.CLEAR_PED_TASKS(g)
                  ENTITY.SET_ENTITY_COORDS_NO_OFFSET(g, mPos.x + (fwdX * distMult), mPos.y + (fwdY * distMult), mPos.z, true, false, false)
                else
                  return
                end
              end
            end
          end
        end
      end
      ------------prevent bodyguards from leaving group if the player dies-----------------
      if not PED.IS_PED_GROUP_MEMBER(guard_1, myGroup) then
        PED.SET_PED_AS_GROUP_MEMBER(guard_1, myGroup)
      end
      if not PED.IS_PED_GROUP_MEMBER(guard_2, myGroup) then
        PED.SET_PED_AS_GROUP_MEMBER(guard_2, myGroup)
      end
      if not PED.IS_PED_GROUP_MEMBER(guard_3, myGroup) then
        PED.SET_PED_AS_GROUP_MEMBER(guard_3, myGroup)
      end
      ----------------------------------------------------------------------------------------
      if bg_attack then
        if not flying then
          if NETWORK.NETWORK_IS_PLAYER_ACTIVE(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(targetPlayer)) then
            player_name = PLAYER.GET_PLAYER_NAME(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(targetPlayer))
            if not PLAYER.IS_PLAYER_PLAYING(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(targetPlayer)) then
              misc:sleep(3000)
              return
            end
            if INTERIOR.GET_INTERIOR_FROM_ENTITY(targetPlayer) == 0 then
              bgAutoTp = false
              local deadBgMsg   = true
              local playerPos   = ENTITY.GET_ENTITY_COORDS(targetPlayer, true)
              local playerFwdX  = ENTITY.GET_ENTITY_FORWARD_X(targetPlayer)
              local playerFwdY  = ENTITY.GET_ENTITY_FORWARD_Y(targetPlayer)
              local playerHdng  = ENTITY.GET_ENTITY_HEADING(targetPlayer)
              if ENTITY.DOES_ENTITY_EXIST(guard_1) then
                local g1Pos = ENTITY.GET_ENTITY_COORDS(guard_1, true)
                local dist1  = SYSTEM.VDIST(g1Pos.x, g1Pos.y, g1Pos.z, playerPos.z, playerPos.y, playerPos.z)
                -- TASK.TASK_GO_TO_COORD_WHILE_AIMING_AT_ENTITY(guard_1, playerPos.x, playerPos.y, playerPos.z, targetPlayer, 2.0, true, 0.5, 4.5, false, 1, false, -957453492, 60000) -- -957453492 = full auto firing pattern
                  TASK.TASK_GO_STRAIGHT_TO_COORD(guard_1, playerPos.x - (playerFwdX * 2), playerPos.y - (playerFwdY * 2), playerPos.z, 3.0, 10000, playerHdng, 0.0)
                if dist1 <= 20.0 then
                  TASK.TASK_COMBAT_PED(guard_1, targetPlayer, 0, 16)
                end
              end
              if ENTITY.DOES_ENTITY_EXIST(guard_2) then
                local g2Pos = ENTITY.GET_ENTITY_COORDS(guard_2, true)
                local dist2  = SYSTEM.VDIST(g2Pos.x, g2Pos.y, g2Pos.z, playerPos.z, playerPos.y, playerPos.z)
                -- TASK.TASK_GO_TO_COORD_WHILE_AIMING_AT_ENTITY(guard_2, playerPos.x, playerPos.y, playerPos.z, targetPlayer, 2.0, true, 0.5, 4.5, false, 1, false, -957453492, 60000)
                TASK.TASK_GO_STRAIGHT_TO_COORD(guard_2, playerPos.x, playerPos.y, playerPos.z, 3.0, 10000, playerHdng, 0.0)
                if dist2 <= 20.0 then
                  TASK.TASK_COMBAT_PED(guard_2, targetPlayer, 0, 16)
                end
              end
              if ENTITY.DOES_ENTITY_EXIST(guard_3) then
                local g3Pos = ENTITY.GET_ENTITY_COORDS(guard_3, true)
                local dist3  = SYSTEM.VDIST(g3Pos.x, g3Pos.y, g3Pos.z, playerPos.z, playerPos.y, playerPos.z)
                -- TASK.TASK_GO_TO_COORD_WHILE_AIMING_AT_ENTITY(guard_3, playerPos.x, playerPos.y, playerPos.z, targetPlayer, 2.0, true, 0.5, 4.5, false, 1, false, -957453492, 60000)
                TASK.TASK_GO_STRAIGHT_TO_COORD(guard_3, playerPos.x, playerPos.y, playerPos.z, 3.0, 10000, playerHdng, 0.0)
                if dist3 <= 20.0 then
                  TASK.TASK_COMBAT_PED(guard_3, targetPlayer, 0, 16)
                end
              end
              if ENTITY.IS_ENTITY_DEAD(guard_1) and ENTITY.IS_ENTITY_DEAD(guard_2) and ENTITY.IS_ENTITY_DEAD(guard_3) then
                if deadBgMsg then
                  gui.show_message("Private Security", "Operation Fuck'Em Up was a failure. Your bodyguards died!")
                  deadBgMsg = false
                  bg_attack = false
                  bgAutoTp  = true
                end
              end
            else
              gui.show_message("Private Security",""..player_name.." is not outside. Falling back...")
              bg_attack = false
              bgAutoTp  = true
              TASK.CLEAR_PED_TASKS(guard_1)
              TASK.CLEAR_PED_TASKS(guard_2)
              TASK.CLEAR_PED_TASKS(guard_3)
              PED.SET_PED_CONFIG_FLAG(guard_1, 167, false)
              PED.SET_PED_CONFIG_FLAG(guard_2, 167, false)
              PED.SET_PED_CONFIG_FLAG(guard_3, 167, false)
            end
          else
            gui.show_message("Private Security", "Player not found! Did they leave the session? Falling back...")
            bg_attack = false
            bgAutoTp  = true
            TASK.CLEAR_PED_TASKS(guard_1)
            TASK.CLEAR_PED_TASKS(guard_2)
            TASK.CLEAR_PED_TASKS(guard_3)
            PED.SET_PED_CONFIG_FLAG(guard_1, 167, false)
            PED.SET_PED_CONFIG_FLAG(guard_2, 167, false)
            PED.SET_PED_CONFIG_FLAG(guard_3, 167, false)
          end
        end
      end
    end
  end
  if spawned_escorts[1] ~= nil then
    if not dismissed and not flying then
      local myGroup = PED.GET_PED_GROUP_INDEX(self.get_ped())
      if not PED.DOES_GROUP_EXIST(myGroup) then
        myGroup = PED.CREATE_GROUP(0)
      end
      PED.SET_PED_AS_GROUP_LEADER(self.get_ped(), myGroup)
      PED.SET_GROUP_SEPARATION_RANGE(myGroup, 16960)
      PED.SET_GROUP_FORMATION(myGroup, 2)
      PED.SET_GROUP_FORMATION_SPACING(myGroup, 3.0, 3.0, 1.0)
      if not PED.IS_PED_SITTING_IN_VEHICLE(escort_1, escortCar) and not PED.IS_PED_SITTING_IN_VEHICLE(escort_2, escortCar) and not PED.IS_PED_SITTING_IN_VEHICLE(escort_3, escortCar) then
        escortLeftCar = true
      else
        escortLeftCar = false
      end
      -----------------------auto TP escorts----------------------------
      if esAutoTp then
        if PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) then
          if not validModel and not sittingInEscortCar then
            if not PED.IS_PED_SITTING_IN_VEHICLE(escort_1, escortCar) then
              TASK.CLEAR_PED_TASKS(escort_1)
              TASK.CLEAR_PED_SECONDARY_TASK(escort_1)
              PED.SET_PED_CONFIG_FLAG(escort_1, 402, true)
              TASK.TASK_ENTER_VEHICLE(escort_1, escortCar, 10000, -1, 2.0, 1, 0, 0)
            end
            return
          end
        end
        if escortLeftCar then
          for _, e in ipairs(spawned_escorts) do
            local mPos = ENTITY.GET_ENTITY_COORDS(self.get_ped(), true)
            local fwdX = ENTITY.GET_ENTITY_FORWARD_X(self.get_ped())
            local fwdY = ENTITY.GET_ENTITY_FORWARD_Y(self.get_ped())
            local ePos = ENTITY.GET_ENTITY_COORDS(e, true)
            local dist = SYSTEM.VDIST(mPos.x, mPos.y, mPos.z, ePos.x, ePos.y, ePos.z)
            if dist > 100 then
              if allowInside then
                misc:sleep(1000)
                if not CAM.IS_SCREEN_FADED_IN() then
                  return
                end
                TASK.CLEAR_PED_TASKS(e)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(e, mPos.x - (fwdX * 2), mPos.y - (fwdY * 2), mPos.z, true, false, false)
              else
                if INTERIOR.GET_INTERIOR_FROM_ENTITY(self.get_ped()) == 0 then
                  misc:sleep(2000)
                  TASK.CLEAR_PED_TASKS(e)
                  ENTITY.SET_ENTITY_COORDS_NO_OFFSET(e, mPos.x - (fwdX * 2), mPos.y - (fwdY * 2), mPos.z, true, false, false)
                else
                  return
                end
              end
            end
          end
        else
          local mPos  = ENTITY.GET_ENTITY_COORDS(self.get_ped(), true)
          local mHdng = ENTITY.GET_ENTITY_HEADING(self.get_ped())
          local fwdX  = ENTITY.GET_ENTITY_FORWARD_X(self.get_ped())
          local fwdY  = ENTITY.GET_ENTITY_FORWARD_Y(self.get_ped())
          local cPos  = ENTITY.GET_ENTITY_COORDS(escortCar, false)
          local dist  = SYSTEM.VDIST(mPos.x, mPos.y, mPos.z, cPos.x, cPos.y, cPos.z)
          if dist > 100 then
            if INTERIOR.GET_INTERIOR_FROM_ENTITY(self.get_ped()) == 0 then
              if PED.IS_PED_SITTING_IN_ANY_VEHICLE(self.get_ped()) and not sittingInEscortCar then
                if validModel then
                  misc:sleep(1000)
                  ENTITY.SET_ENTITY_COORDS_NO_OFFSET(escortCar, mPos.x - (fwdX * 12), mPos.y - (fwdY * 12), mPos.z, true, false, false)
                  ENTITY.SET_ENTITY_HEADING(escortCar, mHdng)
                  if startFollowTask then
                    local escortSpd = ENTITY.GET_ENTITY_SPEED(escortCar)
                    local mySpd     = ENTITY.GET_ENTITY_SPEED(PED.GET_VEHICLE_PED_IS_USING(self.get_ped()))
                    if mySpd > escortSpd then
                      VEHICLE.SET_VEHICLE_FORWARD_SPEED(escortCar, mySpd)
                      misc:sleep(2000)
                    end
                    if not sittingInEscortCar then
                      misc:sleep(10000) -- same time as the timeout for ENTER_VEHICLE task.
                      PED.SET_PED_INTO_VEHICLE(escort_1, escortCar, -1) -- if the driver fails to enter the vehicle after it teleports, force them into it.
                    end
                  end
                end
              end
            end
          end
        end
      end
      --------------------keep track of the escort vehicle---------------------------
      if ENTITY.DOES_ENTITY_EXIST(escortCar) then
        local mPos  = ENTITY.GET_ENTITY_COORDS(self.get_ped(), true)
        local cPos  = ENTITY.GET_ENTITY_COORDS(escortCar, false)
        local dist  = SYSTEM.VDIST(mPos.x, mPos.y, mPos.z, cPos.x, cPos.y, cPos.z)
        if dist > 100 then
          escortCarAway = true
        else
          escortCarAway = false
        end
      end
      ------------prevent escorts from leaving group if the player dies---------------------
      if not dismissed then
        if not PED.IS_PED_GROUP_MEMBER(escort_1, myGroup) then
          PED.SET_PED_AS_GROUP_MEMBER(escort_1, myGroup)
        end
        if not PED.IS_PED_GROUP_MEMBER(escort_2, myGroup) then
          PED.SET_PED_AS_GROUP_MEMBER(escort_2, myGroup)
        end
        if not PED.IS_PED_GROUP_MEMBER(escort_3, myGroup) then
          PED.SET_PED_AS_GROUP_MEMBER(escort_3, myGroup)
        end
      end
      -----------------------------------------------------------------------------------------
      if ENTITY.DOES_ENTITY_EXIST(escort_1) and ENTITY.IS_ENTITY_DEAD(escort_1) then
        misc:sleep(5000)
        PED.REMOVE_PED_FROM_GROUP(escort_1)
        PED.DELETE_PED(escort_1)
      end
      if ENTITY.DOES_ENTITY_EXIST(escort_2) and ENTITY.IS_ENTITY_DEAD(escort_2) then
        misc:sleep(5000)
        PED.REMOVE_PED_FROM_GROUP(escort_2)
        PED.DELETE_PED(escort_2)
      end
      if ENTITY.DOES_ENTITY_EXIST(escort_3) and ENTITY.IS_ENTITY_DEAD(escort_3) then
        misc:sleep(5000)
        PED.REMOVE_PED_FROM_GROUP(escort_3)
        PED.DELETE_PED(escort_3)
      end
      -------------------------------revive downed escorts----------------------------------
      -- if PED.IS_PED_FATALLY_INJURED(escort_1) and not ENTITY.IS_ENTITY_DEAD(escort_1) then
      --   PED.SET_PED_DIES_WHEN_INJURED(escort_1, false)
      --   PED.SET_PED_CAN_BE_TARGETED_WHEN_INJURED(escort_1, false)
      --   if not revivedEs1 then
      --    ENTITY.SET_ENTITY_HEALTH(escort_1, 20, 0, 0)
      --   end
      --   es_reviveMsg1        = true
      --   es_startReviveTimer1 = true
      --   local es1Dist = SYSTEM.VDIST(ENTITY.GET_ENTITY_COORDS(self.get_ped(), true), ENTITY.GET_ENTITY_COORDS(escort1, false))
      --   if es1Dist <= 5 then
      --     HUD.BEGIN_TEXT_COMMAND_DISPLAY_HELP("STRING")
	    --     HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("Press ~INPUT_VEH_HEADLIGHT~ to revive.")
      --     HUD.END_TEXT_COMMAND_DISPLAY_HELP(0, false, true, -1)
      --     if PAD.IS_CONTROL_PRESSED(0, 74) then
      --       PED.REVIVE_INJURED_PED(escort_1)
      --       revivedEs1 = true
      --     end
      --   end
      -- end
      -- if PED.IS_PED_FATALLY_INJURED(escort_2) and not ENTITY.IS_ENTITY_DEAD(escort_1) then
      --   PED.SET_PED_DIES_WHEN_INJURED(escort_2, false)
      --   PED.SET_PED_CAN_BE_TARGETED_WHEN_INJURED(escort_2, false)
      --   es_reviveMsg2        = true
      --   es_startReviveTimer2 = true
      --   local es2Dist = SYSTEM.VDIST(ENTITY.GET_ENTITY_COORDS(self.get_ped(), true), ENTITY.GET_ENTITY_COORDS(escort2, false))
      --   if es2Dist <= 5 then
      --     HUD.BEGIN_TEXT_COMMAND_DISPLAY_HELP("STRING")
	    --     HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("Press ~INPUT_VEH_HEADLIGHT~ to revive.")
      --     HUD.END_TEXT_COMMAND_DISPLAY_HELP(0, false, true, -1)
      --     if PAD.IS_CONTROL_PRESSED(0, 74) then
      --       PED.REVIVE_INJURED_PED(escort_2)
      --       -- revivedEs2 = true
      --     end
      --   end
      -- end
      -- if PED.IS_PED_FATALLY_INJURED(escort_3) and not ENTITY.IS_ENTITY_DEAD(escort_1) then
      --   PED.SET_PED_DIES_WHEN_INJURED(escort_3, false)
      --   PED.SET_PED_CAN_BE_TARGETED_WHEN_INJURED(escort_3, false)
      --   es_reviveMsg3        = true
      --   es_startReviveTimer3 = true
      --   local es3Dist = SYSTEM.VDIST(ENTITY.GET_ENTITY_COORDS(self.get_ped(), true), ENTITY.GET_ENTITY_COORDS(escort3, false))
      --   if es3Dist <= 2 then
      --     HUD.BEGIN_TEXT_COMMAND_DISPLAY_HELP("STRING")
	    --     HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("Press ~INPUT_VEH_HEADLIGHT~ to revive.")
      --     HUD.END_TEXT_COMMAND_DISPLAY_HELP(0, false, true, -1)
      --     if PAD.IS_CONTROL_PRESSED(0, 74) then
      --       PED.REVIVE_INJURED_PED(escort_3)
      --       -- revivedEs3 = true
      --     end
      --   end
      -- end
      -- if es_reviveMsg1 then
      --   gui.show_message("Private Security", "Your driver escort is down. You have 15 sesonds to revive them before they die.\nGet close to them and press [H] to revive.")
      --   es_reviveMsg1 = false
      -- end
      -- if es_reviveMsg2 then
      --   gui.show_message("Private Security", "Your front passenger escort is down. You have 15 sesonds to revive them before they die.\nGet close to them and press [H] to revive.")
      --   es_reviveMsg2 = false
      -- end
      -- if es_reviveMsg3 then
      --   gui.show_message("Private Security", "Your rear passenger escort is down. You have 15 sesonds to revive them before they die.\nGet close to them and press [H] to revive.")
      --   es_reviveMsg3 = false
      -- end

      -- if es_startReviveTimer1 then
      --   misc:sleep(15000)
      --   if not revivedEs1 then
      --     ENTITY.SET_ENTITY_HEALTH(escort_1, 0, 0, 0)
      --   else
      --     es_startReviveTimer1 = false
      --   end
      -- end
      -- if es_startReviveTimer2 then
      --   misc:sleep(15000)
      --   if not revivedEs2 then
      --     ENTITY.SET_ENTITY_HEALTH(escort_2, 0, 0, 0)
      --   else
      --     es_startReviveTimer2 = false
      --   end
      -- end
      -- if es_startReviveTimer3 then
      --   misc:sleep(15000)
      --   if not revivedEs3 then
      --     ENTITY.SET_ENTITY_HEALTH(escort_3, 0, 0, 0)
      --   else
      --     es_startReviveTimer3 = false
      --   end
      -- end
      ----------------------reset everything if everyone is dead-----------------------------
      if not ENTITY.DOES_ENTITY_EXIST(escort_1) and not ENTITY.DOES_ENTITY_EXIST(escort_2) and not ENTITY.DOES_ENTITY_EXIST(escort_3) then
        escortLeftCar   = false
        askedToLeave    = false
        taskInProgress  = false
        doDonuts        = false
        doingDriveBy    = false
        doingBurnout    = false
        driveStarted    = false
        driveToWp       = false
        fuckEmUp        = false
        currentTask     = "None."
        spawned_escorts = {}
        dismissed       = true
      end
      if not ENTITY.DOES_ENTITY_EXIST(escort_1) then
        if ENTITY.DOES_ENTITY_EXIST(escortCar) then
          VEHICLE.SET_VEHICLE_DOORS_SHUT(escortCar, false)
          VEHICLE.SET_VEHICLE_DOORS_LOCKED(escortCar, 2)
          ENTITY.SET_ENTITY_AS_MISSION_ENTITY(escortCar, true, true)
          misc:sleep(5000)
          VEHICLE.DELETE_VEHICLE(escortCar) -- no driver, no car.
        end
      end
      if es_attack then
        startFollowTask = false
        esAutoTp        = false
        followOnFoot    = false
        if NETWORK.NETWORK_IS_PLAYER_ACTIVE(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(targetPlayer)) then
          player_name = PLAYER.GET_PLAYER_NAME(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(targetPlayer))
          if not PLAYER.IS_PLAYER_PLAYING(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(targetPlayer)) then
            misc:sleep(3000)
            return
          end
          if INTERIOR.GET_INTERIOR_FROM_ENTITY(targetPlayer) == 0 then
            if escortLeftCar then
              if ENTITY.DOES_ENTITY_EXIST(escort_1) and not ENTITY.IS_ENTITY_DEAD(escort_1) then
                PED.SET_PED_CONFIG_FLAG(escort_1, 402, true)
                TASK.TASK_ENTER_VEHICLE(escort_1, escortCar, 10000, -1, 2.0, 1, 0, 0)
                if ENTITY.DOES_ENTITY_EXIST(escort_2) and not ENTITY.IS_ENTITY_DEAD(escort_2) then
                  PED.SET_PED_CONFIG_FLAG(escort_2, 402, true)
                  TASK.TASK_ENTER_VEHICLE(escort_2, escortCar, 10000, 0, 2.0, 1, 0, 0)
                end
                if ENTITY.DOES_ENTITY_EXIST(escort_3) and not ENTITY.IS_ENTITY_DEAD(escort_3) then
                  PED.SET_PED_CONFIG_FLAG(escort_3, 402, true)
                  TASK.CLEAR_PED_TASKS_IMMEDIATELY(escort_3)
                  PED.SET_PED_INTO_VEHICLE(escort_3, escortCar, 1)
                end
                escortLeftCar = false
                askedToLeave  = false
              end
            end
            local deadEsMsg = true
            -- local playerPos = ENTITY.GET_ENTITY_COORDS(targetPlayer, true)
            -- TASK.TASK_VEHICLE_CHASE(escort_1, targetPlayer)
            -- TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(escort_1, escortCar, playerPos.x, playerPos.y, playerPos.z, 40, 1074528293, 50.0)
            TASK.TASK_VEHICLE_MISSION_PED_TARGET(escort_1, escortCar, targetPlayer, 6, 50, 24904187, 1.0, 0.1, true)
            TASK.TASK_DRIVE_BY(escort_2, targetPlayer, 0, 0.0, 0.0, 0.0, 100, 100, false, -957453492) --doDriveBy
            TASK.TASK_DRIVE_BY(escort_3, targetPlayer, 0, 0.0, 0.0, 0.0, 100, 100, false, -957453492) --//
            if ENTITY.IS_ENTITY_DEAD(escort_1) and ENTITY.IS_ENTITY_DEAD(escort_2) and ENTITY.IS_ENTITY_DEAD(escort_3) then
              if deadEsMsg then
                gui.show_message("Private Security", "Operation Fuck'Em Up was a failure. Your escorts died!")
                deadEsMsg       = false
                es_attack       = false
                esAutoTp        = true
              end
            end
          else
            gui.show_message("Private Security",""..player_name.." is not outside. Falling back...")
            es_attack = false
            TASK.CLEAR_PED_TASKS(escort_1)
            TASK.CLEAR_PED_TASKS(escort_2)
            TASK.CLEAR_PED_TASKS(escort_3)
            TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, 1, 2000)
            esAutoTp = true
          end
        else
          gui.show_message("Private Security", "Player Not Found! Falling back...")
          es_attack = false
          TASK.CLEAR_PED_TASKS(escort_1)
          TASK.CLEAR_PED_TASKS(escort_2)
          TASK.CLEAR_PED_TASKS(escort_3)
          TASK.TASK_VEHICLE_TEMP_ACTION(escort_1, escortCar, 1, 2000)
          esAutoTp = true
        end
      end
      if followOnFoot then
        if not dismissed then
          if INTERIOR.GET_INTERIOR_FROM_ENTITY(self.get_ped()) == 0 then
            TASK.TASK_VEHICLE_MISSION_PED_TARGET(escort_1, escortCar, self.get_ped(), 7, 10, 24904187, 0.1, 0.1, true)
          end
        end
      end
      if ENTITY.DOES_ENTITY_EXIST(escortCar) then
        if ENTITY.IS_ENTITY_IN_WATER(escortCar) then
          PED.SET_PED_DIES_INSTANTLY_IN_WATER(escort_1, true)
          misc:sleep(5000)
          ENTITY.SET_ENTITY_AS_MISSION_ENTITY(escortCar)
          misc:sleep(200)
          VEHICLE.DELETE_VEHICLE(escortCar)
        end
      end
    end
  end
  if sittingInEscortCar then
    startFollowTask = false
    if escortLeftCar then
      if not askedToLeave then
        TASK.CLEAR_PED_TASKS(escort_1)
        TASK.CLEAR_PED_TASKS(escort_2)
        TASK.CLEAR_PED_TASKS(escort_3)
        PED.SET_PED_CONFIG_FLAG(escort_1, 402, true)
        PED.SET_PED_CONFIG_FLAG(escort_2, 402, true)
        PED.SET_PED_CONFIG_FLAG(escort_3, 402, true)
        TASK.TASK_ENTER_VEHICLE(escort_1, escortCar, 10000, -1, 2.0, 1, 0, 0)
        TASK.TASK_ENTER_VEHICLE(escort_2, escortCar, 10000, 0, 2.0, 1, 0, 0)
        PED.SET_PED_INTO_VEHICLE(escort_3, escortCar, 1)
        misc:sleep(3000)
        escortLeftCar = false
      end
    end
  end
end)
script.register_looped("Auto-heal", function(autoHeal)
  if spawned_bodyguards[1] ~= nil then
    if not dismissedGuards then
      local bg1MaxHp  = 1000
      local bg2MaxHp  = 1000
      local bg3MaxHp  = 1000
      local bg1CurrHp = ENTITY.GET_ENTITY_HEALTH(guard_1)
      local bg2CurrHp = ENTITY.GET_ENTITY_HEALTH(guard_2)
      local bg3CurrHp = ENTITY.GET_ENTITY_HEALTH(guard_3)
      if bg1CurrHp < bg1MaxHp then
        if not ENTITY.IS_ENTITY_DEAD(guard_1) then
          if PED.IS_PED_IN_COVER(guard_1, false) then
            bg1SleepTimer = 50
          else
            bg1SleepTimer = 100
          end
          ENTITY.SET_ENTITY_HEALTH(guard_1, math.floor(bg1CurrHp) + 1, 0, 0)
          autoHeal:sleep(bg1SleepTimer)
        end
      end
      if bg2CurrHp < bg2MaxHp then
        if not ENTITY.IS_ENTITY_DEAD(guard_2) then
          if PED.IS_PED_IN_COVER(guard_2, false) then
            bg2SleepTimer = 50
          else
            bg2SleepTimer = 100
          end
          ENTITY.SET_ENTITY_HEALTH(guard_2, math.floor(bg2CurrHp) + 1, 0, 0)
          autoHeal:sleep(bg2SleepTimer)
        end
      end
      if bg3CurrHp < bg3MaxHp then
        if not ENTITY.IS_ENTITY_DEAD(guard_3) then
          if PED.IS_PED_IN_COVER(guard_3, false) then
            bg3SleepTimer = 50
          else
            bg3SleepTimer = 100
          end
          ENTITY.SET_ENTITY_HEALTH(guard_3, math.floor(bg3CurrHp) + 1, 0, 0)
          autoHeal:sleep(bg3SleepTimer)
        end
      end
      autoHeal:yield()
    end
  end
  if spawned_escorts[1] ~= nil then
    if not dismissed then
      local e1MaxHp  = 1000
      local e2MaxHp  = 1000
      local e3MaxHp  = 1000
      local e1CurrHp = ENTITY.GET_ENTITY_HEALTH(escort_1)
      local e2CurrHp = ENTITY.GET_ENTITY_HEALTH(escort_2)
      local e3CurrHp = ENTITY.GET_ENTITY_HEALTH(escort_3)
      if e1CurrHp < e1MaxHp then
        if not ENTITY.IS_ENTITY_DEAD(escort_1) then
          if PED.IS_PED_IN_COVER(escort_1, false) then
            e1SleepTimer = 50
          else
            e1SleepTimer = 100
          end
          ENTITY.SET_ENTITY_HEALTH(escort_1, math.floor(e1CurrHp) + 10, 0, 0)
          autoHeal:sleep(e1SleepTimer)
        end
      end
      if e2CurrHp < e2MaxHp then
        if not ENTITY.IS_ENTITY_DEAD(escort_2) then
          if PED.IS_PED_IN_COVER(escort_2, false) then
            e2SleepTimer = 50
          else
            e2SleepTimer = 100
          end
          ENTITY.SET_ENTITY_HEALTH(escort_2, math.floor(e2CurrHp) + 10, 0, 0)
          autoHeal:sleep(e2SleepTimer)
        end
      end
      if e3CurrHp < e3MaxHp then
        if not ENTITY.IS_ENTITY_DEAD(escort_3) then
          if PED.IS_PED_IN_COVER(escort_3, false) then
            e3SleepTimer = 50
          else
            e3SleepTimer = 100
          end
          ENTITY.SET_ENTITY_HEALTH(escort_3, math.floor(e3CurrHp) + 10, 0, 0)
          autoHeal:sleep(e3SleepTimer)
        end
      end
      autoHeal:yield()
    end
  end
end)
script.register_looped("Revive", function()
  if PED.IS_PED_FATALLY_INJURED(guard_1) and not ENTITY.IS_ENTITY_DEAD(guard_1) then
    PED.SET_PED_DIES_WHEN_INJURED(guard_1, false)
    PED.SET_PED_CAN_BE_TARGETED_WHEN_INJURED(guard_1, false)
    if ENTITY.GET_ENTITY_HEALTH(guard_1) >= 10 then
      PED.REVIVE_INJURED_PED(guard_1)
    end
  end
  if PED.IS_PED_FATALLY_INJURED(guard_2) and not ENTITY.IS_ENTITY_DEAD(guard_2) then
    PED.SET_PED_DIES_WHEN_INJURED(guard_2, false)
    PED.SET_PED_CAN_BE_TARGETED_WHEN_INJURED(guard_2, false)
    if ENTITY.GET_ENTITY_HEALTH(guard_2) >= 10 then
      PED.REVIVE_INJURED_PED(guard_2)
    end
  end
  if PED.IS_PED_FATALLY_INJURED(guard_3) and not ENTITY.IS_ENTITY_DEAD(guard_3) then
    PED.SET_PED_DIES_WHEN_INJURED(guard_3, false)
    PED.SET_PED_CAN_BE_TARGETED_WHEN_INJURED(guard_3, false)
    if ENTITY.GET_ENTITY_HEALTH(guard_3) >= 10 then
      PED.REVIVE_INJURED_PED(guard_3)
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