# Billionaire Services
Lua script for YimMenu that provides billionaire services for GTA V players.

## Features:
### Private Jet Service:

![billionaire_services](https://github.com/xesdoog/Billionaire-Script/assets/66764345/d705d7cd-050d-4d20-bf35-0e304f22cec6)

### Usage:
1. Choose an airport from the dropdown list. A [Luxor Deluxe](https://static.wikia.nocookie.net/gtawiki/images/1/1f/LuxorDeluxe-GTAV-front.png/revision/latest/scale-to-width-down/1000?cb=20150614102306) will spawn there.
   > If your jet is **at least 1km away from you**, a new button will appear in the UI. Use it to instantly board your private jet.
3. Go to your private jet *(It will be marked with a plane blip ![radar_player_plane](https://github.com/xesdoog/Billionaire-Script/assets/66764345/2cd7a70c-77c9-4c24-806d-fe744e216009)
 on the map).*
4. Enter the jet then choose one of the options that will appear.
- Available options:
  - **Fly Around Waypoint**:
    - Place a waypoint on the map then press this button. Your pilot will take off and fly towards the waypoint. Unfortunately, you can't land a private jet wherever you want so when you get to your destination, the pilot will keep circling around the area.
  - **Fly To New Waypoint**:
    - While flying in your jet, open the map and place a **new** waypoint then press this button. Your pilot will do the same thing as the previous option but without the take-off part. You can use this button as much as you want to continuously fly wherever you want.
  - **Land at one of the three airports available**:
    - When you are flying at a reasonable altitude, the airports list will appear at the bottom under "Landing Options". Decide where you want to land your jet by selecting one of the airports then press the landing button. Your pilot will then fly towards the airport and once he gets close, he will start landing the jet. At this phase, you can either wait for him to try and land it *(the success rate is much higher than it was before)* or check the script UI for a button that will appear after a few seconds and press it to skip the landing process.

      > *TIP: Your clue for when the button wil appear is exactly 10 seconds after you hear the jet engine slow down.*
    
      > **NOTE: The landing button as well as the airport list will not appear until your jet is flying at a proper altitude.**

> [!NOTE]
> GTA V AI is a bit outdated. The pilot will sometimes struggle to find the correct runway approach and thus he will keep flying in circles while dangerously low until he either lands the jet or crashes it.

### Private Security Service:

![billionaire_services(escort)](https://github.com/xesdoog/Billionaire-Script/assets/66764345/a885f376-7fba-4322-a2a7-58c69a66d84f)

### Usage:
This feature has two main options:
1. **Spawn As Bodyguards**:
   - Select a group from the dropdown list then press **Spawn As Bodyguards**.
   - A group of 3 peds will spawn and follow you everywhere you go (even if you teleport) while also protecting you from the dangers that loom around Los Santos. Each group has a different type of weapon but they are all equally skilled at shooting people.

     > *Side Note: Unlike escorts, these bodyguards CAN get in any vehicle you get in including your private jet. You can take them with you for a flight around the city.*

3. **Spawn As Escorts**:
   - Select a group from the dropdown list then press **Spawn As Escorts**. This group has their own vehicle which they can leave either by shooting a bullet near them *(they sometimes only react to the second or third shot)*, entering then exiting your own vehicle or using a button in the script to ask them to leave/re-enter. They can use their vehicle to follow you if you get in a car yourself and start driving but keep in mind that they can only follow vehicles that drive on the ground so no planes, helis or boats. If you get in a bot or a plane and travel too far from your escorts then once you're on foot, a button will appear in the UI that you can use to instantly bring them to you.
   - You can get inside the escort vehicle to do some fun things. Escorts can drive you around town, chauffeur you to your waypoint, do a burnout or start a random driveby shooting on innocent civilians. There's also an option to start doing *MAAD* donuts and you can use the **Change Direction** button to turn *MAAD* donuts into *MAAD* drifts.

     > **NOTE: Escorts are NOT allowed to enter your vehicle. You can spawn bodyguards that can ride with you while also having escorts following you in their own vehicle.**

### Private Limo Service:

![billionaire_services(2)](https://github.com/xesdoog/Billionaire-Script/assets/66764345/07b1c8f3-6511-4dd6-9a4f-c7f86d84898d)

### Usage:
1. Press the button to call for a limo. A Patriot Stretch will spawn in front of you.
2. Approach one of the rear doors and press [F] to enter the vehicle.
 - Two options will aprear:
   - **Drive To Waypoint**:
      - Set a waypoint on the map then press this button to travel to it. The driver will obey traffic laws and get you there safely.
   - **Cruise Around**:
      - Simply does what it says. The driver will take you for a ride around town.
   - *more options will probably be added later (call some bitches? idk)*

## Known Issues:
- The jet landing process is a bit random. Sometimes the pilot will land without any issues, sometimes he will take forever and in some other occasions, he will crash the jet. It all depends on the initial angle your pilot approaches the runway from. This is not a *"literally unplayable"* type of issue since you have the option to skip the landing part.
- While having "Allow Teleport Inside" activated, if you get inside any interior, your bodyguards and escorts will follow without any issues but when you exit, one of them will always drop through the floor and start screaming for a few seconds before being automatically teleported to your location once again. This has to do with how GTA handles interiors. For example: if you have a Chop Shop located at Strawberry, when you go inside it the game teleports you to a completely different location under the map at El Burro Heights and when you go outside, the game teleports you back to Strawberry and places you in front of the door. Again, this is not a *"literally unplayable"* issue because the glitched bodyguard/escort will eventually teleport to you again.
- One of the bodyguards or escorts, the same one mentioned above ^, will always teleport inside interiors with you even when "Allow Teleport Inside" is disabled. This same little shit will then start screaming when you exit. I tried to fix it but it required basically rethinking the whole auto-teleport feature so I'm leaving it for now. It's also kinda funny how they scream at the top of their lungs then fall on their asses.

## TO DO:
- [x] ~Improve the flight system~. ✅**Done.**
- [x] ~Fix the donuts option for the Personal Escort.~ ✅**Done.**
- [x] ~Automatically teleport bodyguards and escorts to your location in case you get separated. *(needs some thought to not mistakenly break anything. Mainly a check for interiors but other stuff too.)*~ ✅**Done.**
- [ ] Add the ability to revive injured bodyguards and escorts.

## Credits:
[YimMenu](https://github.com/YimMenu/YimMenu) for being an awesome project.
