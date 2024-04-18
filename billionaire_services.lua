---@diagnostic disable: undefined-global, lowercase-global
local billionaire_services = gui.get_tab("Billionaire Services")
spawned_jet = {}
spawned_pilot = {}
local airports = {
  {name = "Los Santos International Airport", hangar = vec3:new(-979.294, -2993.9, 13.9451), runwayStart = vec3:new(-1305.79, -2148.72, 13.9446), runwayEnd = vec3:new(-1663.04, -2775.99, 13.9447), taxiPos = vec3:new(-1046.74, -2971.01, 13.9487), cutPos = vec3:new(-2204.82, -2554.53, 678.723)},
  {name = "Fort Zancudo", hangar = 0, runwayStart = 0, runwayEnd = 0, taxiPos = 0, cutPos = 0},
  {name = "Sandy Shores Airfield", hangar = 0, runwayStart = 0, runwayEnd = 0, taxiPos = 0, cutPos = 0},
}
local airport_index = 0
local function requestModel(modelHash)
  script.run_in_fiber(function()
    while not STREAMING.HAS_MODEL_LOADED(modelHash) do
      STREAMING.REQUEST_MODEL(modelHash)
      coroutine.yield()
    end
  end)
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
  airport_index, used = ImGui.Combo("##airportList", airport_index, airportNames, #filteredAirports)
end
billionaire_services:add_imgui(function()
  ImGui.BeginTabBar("Billionaire Services", ImGuiTabBarFlags.None)
    if ImGui.BeginTabItem("Private Jet") then
      ImGui.Text("Choose an Airport:")
      ImGui.PushItemWidth(280)
      displayAirports()
      ImGui.PopItemWidth()
      local airportData = filteredAirports[airport_index + 1]
      local jetModel = 0xB79F589E
      local myPos = ENTITY.GET_ENTITY_COORDS(self.get_ped(), false)
      if ImGui.Button("Spawn Private Jet") then
        if spawned_jet[1] == nil then
          requestModel(jetModel)
          script.run_in_fiber(function(privateJet)
              pJet = VEHICLE.CREATE_VEHICLE(jetModel, 0.0, 0.0, 0.0, 0.0, true, false, false)
              privateJet:sleep(100)
              ENTITY.SET_ENTITY_COORDS(pJet, airportData.hangar.x, airportData.hangar.y, airportData.hangar.z, true, true, true, true)
              ENTITY.SET_ENTITY_HEADING(pJet, 50)
              ENTITY.SET_ENTITY_INVINCIBLE(pJet, true)
              VEHICLE.SET_VEHICLE_DOOR_OPEN(pJet, 0, false, false)
              jetBlip = HUD.ADD_BLIP_FOR_ENTITY(pJet)
              HUD.SET_BLIP_SPRITE(jetBlip, 423)
              HUD.SET_BLIP_SCALE(jetBlip, 1.2)
              table.insert(spawned_jet, pJet)
          end)
          requestModel(0xE75B4B1C)
          script.run_in_fiber(function(privatePilot)
              myGroup = PLAYER.GET_PLAYER_GROUP(self.get_ped())
              privatePilot:sleep(100)
              pilot = PED.CREATE_PED_INSIDE_VEHICLE(pJet, "PED_TYPE_CIVMALE", 0xE75B4B1C, -1, true, false)
              ENTITY.SET_ENTITY_INVINCIBLE(pilot, true)
              table.insert(spawned_pilot, pilot)
              privatePilot:sleep(100)
              copilot = PED.CREATE_PED_INSIDE_VEHICLE(pJet, "PED_TYPE_CIVMALE", 0xE75B4B1C, 0, true, false)
              ENTITY.SET_ENTITY_INVINCIBLE(copilot, true)
              table.insert(spawned_pilot, copilot)
              PED.SET_PED_AS_GROUP_MEMBER(pilot, myGroup)
              PED.SET_PED_AS_GROUP_MEMBER(copilot, myGroup)
              PED.SET_PED_NEVER_LEAVES_GROUP(pilot, myGroup)
              PED.SET_PED_NEVER_LEAVES_GROUP(copilot, myGroup)
              PED.SET_PED_VEHICLE_FORCED_SEAT_USAGE(self.get_ped(), pJet, 2, 0, 1)
              PED.SET_PED_VEHICLE_FORCED_SEAT_USAGE(copilot, pJet, 0, 0, 1)
              PED.SET_PED_VEHICLE_FORCED_SEAT_USAGE(pilot, pJet, -1, 0, 1)
              PED.SET_PED_CONFIG_FLAG(pilot, 251, true)
              PED.SET_PED_CONFIG_FLAG(pilot, 255, true)
              PED.SET_PED_CONFIG_FLAG(copilot, 251, true)
              PED.SET_PED_CONFIG_FLAG(copilot, 255, true)
              PED.SET_PED_CONFIG_FLAG(pilot, 402, true)
              PED.SET_PED_CONFIG_FLAG(copilot, 402, true)
              PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilot, true)
              PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(copilot, true)
          end)
        else
          gui.show_message("Billionaire Services", "You have already spawned a private jet.")
        end
      end
      ImGui.SameLine()
      if ImGui.Button("Dissmiss") then
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
            TASK.TASK_VEHICLE_DRIVE_TO_COORD(pilot, pJet, airportData.taxiPos.x, airportData.taxiPos.y, airportData.taxiPos.z, 5.0, 0, 0xB79F589E, 786603, -1.0, -1.0)
            flyTo:sleep(6000)
            CAM.DO_SCREEN_FADE_OUT(1000)
            flyTo:sleep(1000)
            CAM.DO_SCREEN_FADE_IN(500)
            ENTITY.SET_ENTITY_COORDS(pJet, airportData.cutPos.x, airportData.cutPos.y, airportData.cutPos.z, true, true, true, true)
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(pJet, 100.0)
            VEHICLE.CONTROL_LANDING_GEAR(pJet, 1)
            TASK.TASK_PLANE_MISSION(pilot, pJet, 0, 0, destination.x, destination.y, destination.z + 600, 4, 100.0, 0, 90, 0, 0, 200)
            flyTo:sleep(500)
          else
            gui.show_message("Private Jet", "Get in your private jet to fly around")
          end
        end)
      end
      if ImGui.Button("Land At LSIA") then
        local jetPos = ENTITY.GET_ENTITY_COORDS(pJet, false)
        local lsiaDist = SYSTEM.VDIST(jetPos.x, jetPos.y, jetPos.z, -860.534, -1476.28, 286.833)
        local hangarDist = SYSTEM.VDIST(jetPos.x, jetPos.y, jetPos.z, -979.294, -2993.9, 13.9451)
        script.run_in_fiber(function(lsia)
          if hangarDist <= 100 then
            gui.show_message("Private Jet", "Your private jet is already at LSIA!")
            return
          end
          if lsiaDist <= 2000 then
            TASK.TASK_PLANE_LAND(pilot, pJet, airportData.runwayStart.x, airportData.runwayStart.y, airportData.runwayStart.z, airportData.runwayEnd.x, airportData.runwayEnd.y, airportData.runwayEnd.z)
            if hangarDist > 100 and (ENTITY.GET_ENTITY_SPEED(pJet) * 3.6) <= 10.0 then
              TASK.CLEAR_PED_TASKS_IMMEDIATELY(pilot)
              TASK.CLEAR_PED_TASKS_IMMEDIATELY(copilot)
              ENTITY.SET_ENTITY_COORDS(pJet, -979.294, -2993.9, 13.9451, true, true, true, true)
            else
              lsia:sleep(200)
              return
            end
          elseif lsiaDist > 2000 then
            TASK.TASK_PLANE_MISSION(pilot, pJet, 0, 0, -860.534, -1476.28, 286.833, 4, 100.0, 0, 90, 0, 0, 200)
          else
            gui.show_message("Private Jet", "Too close to airport!")
            return
          end
        end)
      end
      -----------debug section-------------
      if ImGui.Button("Debug Stuff") then
        script.run_in_fiber(function()
          local jetSpeed = (ENTITY.GET_ENTITY_SPEED(pJet) * 3.6)
          -- local myGroup = PLAYER.GET_PLAYER_GROUP(self.get_ped())
          local jetPos = ENTITY.GET_ENTITY_COORDS(pJet, false)
          local vDist = SYSTEM.VDIST(jetPos.x, jetPos.y, jetPos.z, -1643.2, -2773.15, 13.9447)
          log.debug("My Position: "..tostring(myPos))
          log.debug("Distance: "..tostring(vDist))
          log.debug("Jet Speed: "..tostring(jetSpeed))
        end)
      end
      -------------------------------------
      ImGui.EndTabItem()
    end
    if ImGui.BeginTabItem("Private Limo") then
      ImGui.Text("Dummy Text")
      ImGui.Button("Dummy Button")
      ImGui.EndTabItem()
    end
    if ImGui.BeginTabItem("Private SUV") then
      ImGui.Text("Dummy Text")
      ImGui.Button("Dummy Button")
      ImGui.EndTabItem()
    end
end)
script.register_looped("blipManager", function()
  if HUD.DOES_BLIP_EXIST(jetBlip) then
    if PED.IS_PED_SITTING_IN_VEHICLE(self.get_ped(), pJet) then
        HUD.SET_BLIP_ALPHA(jetBlip, 0.0)
    else
      HUD.SET_BLIP_ALPHA(jetBlip, 1000.0)
    end
  end
end)