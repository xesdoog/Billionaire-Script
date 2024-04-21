# Billionaire Services [WIP]
Lua script for YimMenu that provides billionaire services for GTA V players.

> [!WARNING]
> Work in progress.

## Features:
### Private Jet Service:

![billionaire_services](https://github.com/xesdoog/Billionaire-Script/assets/66764345/93dfa7b2-c52c-4130-9f71-7a57a40b7f95)

### Usage:
1. Choose an airport from the dropdown list. A [Luxor Deluxe](https://static.wikia.nocookie.net/gtawiki/images/1/1f/LuxorDeluxe-GTAV-front.png/revision/latest/scale-to-width-down/1000?cb=20150614102306) will spawn there.
2. Go to your private jet *(It will be marked with a plane blip ![radar_player_plane](https://github.com/xesdoog/Billionaire-Script/assets/66764345/2cd7a70c-77c9-4c24-806d-fe744e216009)
 on the map).*
   > I will probably add a teleport option in the future.
4. Enter the jet then choose one of the options that will appear.
- Available options:
  - **Fly Around Waypoint**:
    - Place a waypoint on the map then press this button. Your pilot will take off and fly towards the waypoint. Unfortunately, you can't land a private jet wherever you want so when you get to your destination, the pilot will keep circling around the area.
  - **Fly To New Waypoint**:
    - Place a **different** waypoint on the map then press this button. Your pilot will do the same thing above without the take-off part. You can use this button as much as you want to continuously fly wherever you want.
  - **Land at one of the three airports available**:
    - Decide where you want to land your jet by selecting an airport from the dropdown list at the top then press the landing button. Your pilot will then fly towards the airport and once he gets close, he will start landing the jet. At this phase, you can either wait for him to try and land it *(the success rate is much higher than it was before)* or check the script UI for a button that will appear after a few seconds and press it to skip the landing process.

      > *TIP: Your clue for when the button wil appear is a few seconds after you hear the jet engine slow down.*
      
      > **NOTE: The landing button will not appear until your jet is flying at a proper altitude.**
> [!NOTE]
> GTA V AI is a bit outdated. The pilot will sometimes struggle to find the correct runway approach and thus he will keep flying in circles while dangerously low until he either lands the jet or crashes it.

### Private Security Service:

![billionaire_services(1)](https://github.com/xesdoog/Billionaire-Script/assets/66764345/cbb7b98d-1e73-454c-946f-453950664407)

### Usage:
This feature has two main options:
1. **Spawn As Bodyguards**:
   - Select a group from the dropdown list then press **Spawn As Bodyguards**.
   - A group of 3 peds will spawn and follow you everywhere you go while also protecting you from the dangers that loom around Los Santos. Each group has a different type of weapon but they are all equally skilled at shooting people.

     > *Side Note: Unlike escorts, these bodyguards CAN get in your vehicle including your private jet.*

3. **Spawn As Escorts**:
   - Select a group from the dropdown list then press **Spawn As Escorts**. This group has their own vehicle which they can leave either by shooting a bullet near them *(they sometimes only react to the second or third shot)*, entering then exiting your own vehicle or using a button in the script to ask them to leave/re-enter. They can use their vehicle to follow you if you get in a car yourself and start driving.
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
- It's probably too early for listing issues at the moment.

## TO DO:
- [x] ~Improve the flight system~. ✅**Done.**
- [x] ~Fix the donuts option for the Personal Escort.~ ✅**Done.**
- [ ] Improve the general experience. *(in-progress)*
- [ ] Automatically teleport bodyguards and escorts to your location in case you get separated. *(needs some thought to not mistakenly break anything. Mainly a check for interiors but other stuff too.)*

## Credits:
[YimMenu](https://github.com/YimMenu/YimMenu) for being an awesome project.
