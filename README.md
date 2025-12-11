# Bike Theft Simulator #

## Summary ##

**Hi! You are now the freshest of freshman at the esteemed UC Davis, city of bikes! Unfortunately no one told you this and you have arrived without a bike. Luckily, you live in a top down rougelite where everyone has a bike but you. Don’t tell anyone I told you but I’ve heard these bikes turn a hefty profit! Every morning you will get a chance to explore the campus but don’t get caught. Walk up to a shiny bike and take out your lock cutters to chop away. Make sure to escape without getting caught or you could lose everything. Once you leave, give me a call and I’ll get you that paycheck lickity split! I have a couple of other items for sale if you’re ever interested let me know. Now go out there and STE… take a gander at those two wheeled bags of money eh?**

## Project Resources

[Web-playable version of your game.](https://nithinsenthil.itch.io/ucdbts)  
[Trailor](https://youtu.be/CkUu2t9rGNo?si=DesG2ggaXmzihLZI)  
[Press Kit](https://naomitzhao.github.io/ecs179-presskit/)  
[Proposal](https://docs.google.com/document/d/1agMdte-UFuqNjl4PmqS8Yylk5YmJ1tczksgChWspm8o/edit?usp=sharing)  

## Gameplay Explanation ##

- Click start to begin day/level 1 of the game.
- Use `wasd` for standard movement controls and `f` to interact with bikes.
- Stand next to a bike and hold down the interact button until the loading bar completes to steal a bike.
- Nearby NPC's will get suspicious if they see you actively stealing a bike. First they will get question marks, indicating that they will begin investigating. During this phase they will wander towards you. If you continue to engage in suspicious activity the NPC will get an exclamation mark. Further suspicious activity will result in game over.
- You can hold up to 5 bikes at a time, the value of your pocket is displayed in the HUD
- Bikes have different values which effect the time to steal, shiny and rust effects indicate which bikes are higher and lower quality
- The map exit is in the top right and will take you to the shop
- There are 2 randomly selected items presented everyday with descriptions and price amounts
- Sell the stolen bikes from that day and purchase items, but keep in mind you can only hold one item at a time (except for kelvin which applies a passive effect for the next day), tip: don't buy multiple physical items because the second will override the first, got to be careful!
- Return to the next day, rinse, repeat, and try out different play styles to see how long you can last 


# External Code, Ideas, and Structure #

If your project contains code that: 1) your team did not write, and 2) does not fit cleanly into a role, please document it in this section. Please include the author of the code, where to find the code, and note which scripts, folders, or other files that comprise the external contribution. Additionally, include the license for the external code that permits you to use it. You do not need to include the license for code provided by the instruction team.

If you used tutorials or other intellectual guidance to create aspects of your project, include reference to that information as well.

Starter code for NPC navigation was taken from: https://docs.godotengine.org/en/stable/tutorials/navigation/navigation_introduction_2d.html
Scene Manager from tutorial: https://www.youtube.com/watch?v=2uYaoQj_6o0

# Team Member Contributions

## Ria ##

### Main Role: UI and Input ###

*Start Menu* - The game's start menu at the beginning is the first scene that the user sees. It consists of three buttons, [start game](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scripts/start_game_button.gd#L1), [credits](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scripts/credits_button.gd), and [exit](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scripts/exit_button.gd). The buttons utilize the scene manager to change scenes. 

*Credit Scene* - The credit scene showcases each of our team member's roles and subroles. It includes an audio manager to play music. It also includes a shader to automatically scroll the text up, as well as an exit button to return to the starting screen. [This is the script controlling the scene](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scripts/credits.gd). [This is the scene](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scenes/credits.tscn).

*Bike and money display* - This is the display at the bottom of the screen that accumulates how many bikes are in the user's pocket. [This is an example of the script attached to the texture rect displaying the bike](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scripts/bike_1.gd#L1). It also recognizes how many bikes are in the user's pocket and displays that many bikes in the 5 boxes shown to the user. It also displays how much money the user has in their pocket. [The money class also keeps track of how the player accumulates and spends money.](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scripts/money.gd#L1)

*Input keys* - The [wasd](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/project.godot#L42) controls the movement of the player in the world. Holding down the f key allows a user to "steal" a bike. Pressing the R key allows the user to see or hide the control menu. 

### Sub-Role: Player Onboarding and Tutorial Design ###

*Control Menu* - [The control menu shows up after the player presses start game button](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scripts/control_menu_group.gd#L1). It describes how to move around in the world and play the game. It is toggled using the r key which is added to the project settings input map.


## Wesley Clark ##

### Main Role: Movement and Physics ###
Although Movement/Physics was originally intended as my main role, it ended up mostly as a sub-role for me. I made contributions under this role in the early stages of the project, and then moved on to mostly implementing game logic (this is detailed in the "other contributions" section).

*Player movement and direction facing logic* - Implemented basic player movement. Also implemented the logic that determines which direction characters are facing, which is used for animations. This ties into our lectures on game feel and movement. [Player Physics](https://github.com/nithinsenthil/UCDBTS/blob/9f2b249c9c11136444000cdc91a57ddc835de651/ucdbts/Scripts/Player/player.gd#L27) and [Character Class](https://github.com/nithinsenthil/UCDBTS/blob/9f2b249c9c11136444000cdc91a57ddc835de651/ucdbts/Scripts/Player/character.gd#L6)

### Sub-Role: Game feel ###

*Camera* - Created a target lock camera that can be moved with the mouse cursor and has zoom functionality. When camera controls are enabled (by player input), the camera follows the cursor at a fixed, relatively high velocity as to feel responsive. This ties into the lecture we had on cameras and their feel. [Camera class](https://github.com/nithinsenthil/UCDBTS/blob/9f2b249c9c11136444000cdc91a57ddc835de651/ucdbts/Scripts/Cameras/camera_one.gd#L1)

*Balancing adjustments* - Changed various values in game based on feedback. Some of the items were too good, and the bikes were too easy to steal. This ties into what we discussed in class about making a game not too easy and not too hard, so that it is neither boring nor anxiety inducing. [Here is the patch commit](https://github.com/nithinsenthil/UCDBTS/commit/3d5c43df4ac917f282f597ee9f0ed67d3e47e3f0)

*NPC movement adjustments* - Worked with Jacob to refine the movement of the NPCs. Decided the behavior for collisions between the player and NPCs. Made adjustments to collision hitboxes and tilemap to prevent NPCs from getting stuck. This generally ties into our discussions about game feel. [Here are some specific adjustments](https://github.com/nithinsenthil/UCDBTS/commit/7915bf12d27149e5a0c05ac2a947e780e4086f98)

*Bike stealing progress bar* - Worked with Naomi to implement a progress bar above bikes that indicates stealing progress. Makes stealing the bikes a bit more satisfying. This generally ties into our discussions about game feel. [Implementation in bike script in _process() and interact()](https://github.com/nithinsenthil/UCDBTS/blob/9f2b249c9c11136444000cdc91a57ddc835de651/ucdbts/Scripts/bike.gd#L61), [Animation script](https://github.com/nithinsenthil/UCDBTS/blob/9f2b249c9c11136444000cdc91a57ddc835de651/ucdbts/Scripts/bike_progress.gd#L1)

### Other contributions ###

*Created debug environment* - Created a debugging environment to test bikes, collision, interactions, and inventory/money systems. Used a tilemap for the world and for collisions. Placed bikes around the map for the player to steal. Created a bike dropoff that allows the player to sell their stolen bikes. This environment ties into the systems/mechanics lecture, as I created an environment where all of our systems/mechanics could interact and be developed. [Commit](https://github.com/nithinsenthil/UCDBTS/commit/dfbb90aab52c513f6b1f1537257d253cbacbe3db)

*Created bikes and bike stealing system* - Created the bike scene and associated scripts. Bikes have a tier, a value, and a stealing time that can all be manually adjusted. Supports the random generation of bikes (which we didn't end up implementing). Created the logic for bike stealing. The player can walk up to a bike and hold F to steal it. The player can hold up to 5 bikes in their inventory. Bikes disappear from the world when they are stolen. This ties into systems/mechanics design that we discussed in class, although I mostly worked on the implementation rather than the design. [Initial implementation](https://github.com/nithinsenthil/UCDBTS/commit/dfbb90aab52c513f6b1f1537257d253cbacbe3db), [final bike script](https://github.com/nithinsenthil/UCDBTS/blob/9f2b249c9c11136444000cdc91a57ddc835de651/ucdbts/Scripts/bike.gd#L1) and [bike scene](https://github.com/nithinsenthil/UCDBTS/blob/9f2b249c9c11136444000cdc91a57ddc835de651/ucdbts/Scenes/bike.tscn#L1)

*Created interaction system* - Created the system that allows the player to interact with objects. In the final game, the only objects that a player can interact with are bikes, but the interaction manager supports interactions with other objects. The interactable objects must have an interaction zone, which sets up the interaction within the manager when the player enters it. When F is pressed, interact() is called on the object that corresponds to the interaction zone that the player is in. This ties into our discussions about design patterns. [Interaction manager](https://github.com/nithinsenthil/UCDBTS/blob/9f2b249c9c11136444000cdc91a57ddc835de651/ucdbts/Scripts/interaction_manager.gd#L1) and [bike interaction logic](https://github.com/nithinsenthil/UCDBTS/blob/9f2b249c9c11136444000cdc91a57ddc835de651/ucdbts/Scripts/bike.gd#L87)

*Created the shop* - Created all of the logic in the shop (other than the audio). Created the buttons that the player uses to sell bikes, buy items, and leave the shop. Added logic for randomly selecting and displaying two items. The shop ties into design patterns (with the items and their generation) and systems/mechanics (the shop ties all of the mechanics together). [Shop script](https://github.com/nithinsenthil/UCDBTS/blob/9f2b249c9c11136444000cdc91a57ddc835de651/ucdbts/Scripts/shop.gd#L1), [major shop contributions](https://github.com/nithinsenthil/UCDBTS/commit/67a1a41096551c486bb05a26b96646e2e3608cef)

*Implemented all items* - Implemented all 6 of the items that are currently in the game. Each item extends an abstract item class and implements the required methods. Each item has a stat increase, a name, a description, and a path to its texture. Added code and variables in the resource manager in order to support items. Also added methods in the player and camera scripts to ingest stat increases from the items. One item is temporary (Kelvin) and one item has a chance to break when used (Lockpick). The others are basic stat increases. The item implementation follows our studies about design patterns. [Item class](https://github.com/nithinsenthil/UCDBTS/blob/9f2b249c9c11136444000cdc91a57ddc835de651/ucdbts/Scripts/item.gd#L1), [example item script](https://github.com/nithinsenthil/UCDBTS/blob/9f2b249c9c11136444000cdc91a57ddc835de651/ucdbts/Scripts/Items/chainsaw.gd#L1), [resource manager support (member variables, and some code in buy_item())](https://github.com/nithinsenthil/UCDBTS/blob/9f2b249c9c11136444000cdc91a57ddc835de651/ucdbts/Scripts/Managers/resource_manager.gd#L11), and [commit adding items](https://github.com/nithinsenthil/UCDBTS/commit/67a1a41096551c486bb05a26b96646e2e3608cef)


## Shriya Rudrashetty ##

### Main Role: Level and World Design ###

*TileMap* - The world map itself is based off of the UC Davis quad area.The most recognizable buildings were prioritized to be included within the map. This resulted in 10 buildings total. The tile map itself was created in three separate layers. The first layer contained the base overlay of the world and included the skeleton of the buildings, bike paths, Quad/East Field, and the base layer of green. The second layer included all of the detailing on the bike roundabouts and Quad/East field. The second layer also added the first round of detailing on the buildings. This included items like doors, windows, staircases, and roof detailing. Lastly, the final layer added all of the smaller details such as trees, flowers/plants, street lights, and lamp posts. This layer also included building awnings. Sources: https://kenney.nl/assets/rpg-urban-pack and https://starmixu.itch.io/little-dreamyland-asset-pack. [link to evidence in your repository](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scenes/level_1.tscn)

*Collision Zones* - The collision zones were only provided to the buildings and prevented the players and NPCs from walking over them. There was an existing TileMap that was created for debugging purposes that used a random image of campus as a repeated tile in order to roughly map out the buildings. This rough tile map was used to map out the areas of collision within the map by having a certain base tile be designated as the collision zone. Lastly, the layering order for all sprites and build elements had to be updated accordingly to avoid objects overlapping or moving behind each other. [link to evidence in your repository](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scenes/debug_scene.tscn)

### Sub-Role: Gameplay Testing ###

*Short Description* - A lot of players had requested more levels within the game and for the world design to be more closely aligned to the existing UC Davis campus. Specifically dealing with levels, I think our playtesters were unable to understand our ‘day-to-day’ setup, with each level being a new day.

Some testers requested the idea of power ups and other in-game options that were separate from the shop. Some ideas noted were coins or other items to collect throughout the world that you could use to cash in for separate enhancements. Surprisingly, testers also mentioned that they wanted the option to go faster in order to race up to bikes in areas without NPCs so that they could be stolen faster without detection. 

During in-game observations, a lot of testers were a little confused on how and where to start due to lack of in-game instructions. The concept of the store is also something that was requested to be included within the help menu. Feedback showed that the location of the shop and how to enter it needed to be clearer, since some players were wandering around the world looking for it.

Players reacted positively to the overall idea and premise of the game. They enjoyed the art style of both the players, NPC, and the overall shop/world design. We received mostly positive comments on the overall narrative setup as well, since it ties in nicely to UC Davis culture/lore and established a set target audience . [link to evidence in your repository](https://docs.google.com/document/d/1ouK1SFdsfr5DXsgLmMKrMUGJlwnMrGkYOkz9Yh-Q4s4/edit?usp=sharing)


## Nithin Senthil ##

### Main Role: Producer ###

I chose to emphasize the team logistics part of this role, helping to manage dependencies and keep the team working at their maximum capacity for the duration of the project. My goal was to provide the team with the tools they need to successfully collaborate and have the resources required to develop without needing to worry about the overarching plan of the project at every step. Most tools I provided were opt in so everyone is comfortable to work in a way that works for them.

*Discord Server* - I set up the “Team BTS” discord server as the primary point of contact within the team. My goal during this project was to make communication as easy as possible, so discord was an easy choice as a good server structure can make a big difference in simplifying that for the team. I used the server to send out announcements to the team regarding important tasks and deadlines as well as for async progress checks done periodically in threads.\
<img width="204" height="683" alt="server_setup" src="https://github.com/user-attachments/assets/1cec05a8-8f31-4b23-a6f8-04d705df6ec1" />

*BTS Docs* - A google doc focused on centralizing any major points of collaboration. The intention is to create a rich documentation source for defined interfaces and APIs to reduce delays and miscommunication over chats. For example the ResourceManager has a tentative API listed in a tab with descriptions on each field and intended usage guidelines. The graphics tab has general notes and status information on assets for anyone waiting on resources to reference.
[Docs](https://docs.google.com/document/d/1AptVHOdfMYQ3IvdoFBbqQu1X4ZvFoTG7l7vpEhdr7vU/edit?tab=t.cfuk6iyqyfm3)

*Trello* - I set up a trello board for the team to track dependencies early on. It quickly became an optional resource for team members to digitally track their schedules and passively share progress with the rest of the team. I realized the barrier of effort was too high to reliably get updates over this platform, so it retired to be a background tool that was not tracked by me or emphasized.\
<img width="1707" height="826" alt="trello_board" src="https://github.com/user-attachments/assets/734feb03-46b5-475c-9efc-bb521f2976ab" />

*Github* - At the beginning of the project I created the repository and set up the original project. More importantly I established the exact way we will be utilizing git as a team to build out the project. Main is set up with branch protections requiring at least 1 review before it can be merged. I chose not to involve issues in this project as it didn’t seem necessary and would only serve as more overhead for the development team as we moved through the small tasks relatively quickly. Every major feature or member was given an individual branch to work off of: core mechanics, npc’s, level design, and the scene manager. More were eventually introduced as required. The general idea was to silo off all modular components of the system to reduce dependencies on other members of the team and simplify any possible merge conflicts. The process for bringing functionality to other branches starts with the feature branch merging main into itself to handle any merge conflicts locally and simplify the review process. After merging, all other branches can pull in and continue work. All reviews I conducted involved a static code analysis as well as a thorough playtest ensuring regression cases were functional as well. I made an extra effort as the producer to be available for quick feedback and PR reviews.
[Project Init](https://github.com/nithinsenthil/UCDBTS/commit/7f4bcbbcffbb25d2e325a9c84955698be2506df8)

*Project Structure* - In order for the fragmented working structure to come together during the integration phase I drafted a tentative design and reviewed it with the team. This allowed us to  confidently move forward with a clear idea of how the project structure would end up, reducing miscommunicated assumptions and easing integration PR’s.\
<img width="1838" height="1262" alt="system_design" src="https://github.com/user-attachments/assets/702ecb07-0627-4dcc-99db-25ba0dd98d3f" />

*Team Meetings* - I organized and conducted weekly team meetings. Every meeting we discussed progress since our last meeting or async progress check. We also used this opportunity to provide feedback on each other's work and bring up any possible dependencies we have and tentative timelines on how we can proceed to resolve them. The meetings notes are provided [here](https://docs.google.com/document/d/1OKxfaDrT3Y7FH5cCgQ780cARi-au4jAqW5ouYMFdtjU/edit?usp=sharing)

*Itch* - I handled the setup and publishing of our game onto itch.
[Game](https://nithinsenthil.itch.io/ucdbts)

### Sub-Role: Audio ###

*Music Style* - My goal for the sound style of this game was to build on the cozy game nature of the visuals. I achieved this by creating my own bitcrushed soundtrack from scratch on garageband for the title screen, a very important step as it is the first impression the player has with your game. I made a very simple track with natural bird and wind sounds to set a relaxing tone as you navigate through to the main game. For the main gameplay loop I wanted to select something more refined as the player would spend a good chunk of game time in this scene, so I picked out a free use lofi track from a service called uppbeat. Keeping in theme of contrasting sight and sound with rather nefarious actions, I found a peppy menu screen track from the open game art asset library. 
[Main Gameplay](https://uppbeat.io/t/blue-wednesday/lefty), 
[Shop](https://opengameart.org/content/shop-theme-rpg)


*Effects* - For the other sound effects I primarily used open game art looking for a consistent feel across them. I made sure they didn’t conflict excessively with the backtrack, tuning them to be quiet enough not to interfere, but loud enough to give the satisfaction of having clicked a button or cut a lock.

[OGA Home](https://opengameart.org/)\
OGA - JC Sounds\
OGA - dawith\
OGA - Blender Foundation\
OGA - RussianGuitarGuy\
OGA - IgnasD\
OGA - isaiah658\
Sound Effect by Paweł Spychała from Pixabay

*Audio Manager* - The audio manager itself is a simple design I created to fit our basic audio needs on this project. It operates with a node structure similar to the laboratory exercise, using relative Node addressing to locate Audio stream players and starting the tracks. The audio manager can be interacted with from anywhere, triggered by signals for each effect. This makes it easy to drop in signal emitters anywhere a sound is required, and abstract away the implementation into the manager. I took the help of a godot tutorial site to create the audio fade in and out functionality using tweens for scene transitions and droning item effects like the chainsaw. The audio manager is not autoloaded as I needed it to have physical presence within the level to move with the player so I designed it to work as a singleton managed by the Scene Manager (more on that in my Other Contributions section), so its position could be relocated appropriately.
[Tutorial](https://www.gotut.net/basic-audio-manager-in-godot-4/)

### Other Contributions ###

*Scene Manager* - Wrote the scene manager that glues all the scenes together with a simple function that takes in a destination path and transition type to unload the current scene from the tree and insert the new one. Full disclaimer this implementation along with the loading screen is almost entirely copied from a youtube tutorial. I then made several modifications to fit it into our system. The primary modification was the handling of the audio manager. The scene manager creates the singleton audio manager when loaded and dynamically adds it to and removes it from the current scene tree every time the scene changes. The cameras are handled automatically because each scene must have its own camera inside, so the godot runtime automatically picks it up when loaded to the tree.
[Scene Manager](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scripts/Managers/scene_manager.gd), 
[Tutorial](https://www.youtube.com/watch?v=2uYaoQj_6o0)

*Resource Manager* - I wrote the resource manager to handle all persistent state within the game. It is autoloaded and exposes specific endpoints to meet access requirements. With the resource manager, the player can serve as a movement shell that can be safely scrapped and reconstructed each time the level scene is loaded by the scene manager while data on money, items held, and bikes held remain abstracted away.
[Resource Manager](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scripts/Managers/resource_manager.gd)

## Naomi Zhao ##

### Main Role: Animation and Visuals ###

Doing animations and visuals, I decided to prioritize what I thought would give the most "bike theft" character to the game-- the characters, bikes, and items. I designed and sprited characters, bikes, items, the title screen, and shop independently. Without much pixel art expertise, sometimes it took experimentation and several iterations to bring my vision to life, so there was definitely a lot of trial and error behind the scenes for any assets shown below or in the repo!

*Project Visual Configurations* - During my time implementing pixel visuals and animations in this project, I discovered that rendering pixel assets with scaling can often lead to unwanted effects: blurriness, changed line thicknesses, or disappearing pixels, for example. To prevent these effects, I added some key configurations to project settings, effectively maintaining and preserving the pixelated quality of our game. [Project settings](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/project.godot#L126)
1. The window size is set to 640x360, which, according to my research, is a standard resolution for pixel games. Compared to one of the standard resolutions 1920x1080, this effectively scales assets up by a factor of 3, creating a pixelated appearance.
2. To prevent any custom scaling during runtime, I ensured that the project viewport scales only by an integer multiplier. The initial viewport size is 1920x1080 which is an integer multiplier (x3) on the window size, and scaling is configured to "integer" so only whole number scales can be used, preventing weird rendering bugs and pixel artifacts in the viewport.
3. For assets that I created myself, I enforced a strict resolution requirement. Character sprites, item icons, and bike sprites are scaled up by a factor of 2, further emphasizing the pixelated nature of the assets. GUI, background elements, and item art assets were not scaled up, allowing for higher complexity and detail when needed.
4. To prevent pixel assets from rendering blurry, the default "Linear"" texture filter setting needed to be changed to "Nearest" to ensure pixel assets aren't smoothed out and therefore blurry when rendered in-game. [Setitings line](https://github.com/nithinsenthil/UCDBTS/blob/89a5e8fe445850f593f16b975c6916b390f93217/ucdbts/project.godot#L126)

*Character sprites* - Building upon ErisEsra's [character template asset pack](https://erisesra.itch.io/character-templates-pack), I created the player sprite using 16x32 spritesheets for idle and run animations. Keeping the narrative in mind, the player sprite wears a dark colored hoodie with the hood up to protect his own identity. The player is also intended to be generic enough for players to potentially be able to relate to its appearance as the protagonist. I also created 16x32 idle and walk spritesheets for 5 different NPCs based on various forms of inspiration-- for example, NPCs based on people I know or video game characters I like. For each character (including the player), idle and movement spritesheets were created, totalling to 12 spritesheets over all of the characters in the game. When NPCs spawn they are randomly assigned one of 5 characters which determines which spritesheets are used for animations. To avoid the messiness of creating individual animations for every animation on every sprite sheet because the NPC type is determined at runtime, I used AnimationPlayer to be able to change the spritesheet file dynamically. Bonus: I also created the question mark and exclamation point assets that display above characters' heads when they become suspicious at the player. I linked these sprites to a Sprite2D node `StatusSprite` for its visibility to be toggled on and off when the NPC is displaying or not displaying suspicion. [Character spritesheet commit](https://github.com/nithinsenthil/UCDBTS/commit/7923db0ccb927aace9ed84ce078b182c74487b85), [StatusSprite commit](https://github.com/nithinsenthil/UCDBTS/commit/fe852ff17b43c8b626d543e92bd0d63fb509c50e), [NPC sprite randomization](https://github.com/nithinsenthil/UCDBTS/commit/9bdc193a9ace26162da25a65f7dc793ca145ec0e), [NPC AnimationPlayer](https://github.com/nithinsenthil/UCDBTS/commit/3195c84f1e9661bd8da7d1036a86ea080fedcaf6)

<img width="64" height="96" alt="image" src="https://github.com/user-attachments/assets/9a0bc63b-0794-4870-a6cc-ddb9234d5656" />
<img width="96" height="96" alt="image" src="https://github.com/user-attachments/assets/0f86ccf2-12b4-4a7b-b905-a0120940f1d2" />
<img width="64" height="96" alt="image" src="https://github.com/user-attachments/assets/42e1554f-f478-438d-a099-838c742ff575" />
<img width="64" height="96" alt="image" src="https://github.com/user-attachments/assets/aed20b98-445b-439f-8715-24592f2f0b9e" />
<img width="64" height="96" alt="image" src="https://github.com/user-attachments/assets/cd250b4a-e72a-4f21-8425-c51f6926aa49" />
<img width="64" height="96" alt="image" src="https://github.com/user-attachments/assets/98945e22-366b-4e0c-8650-844592348959" />
<img width="64" height="96" alt="image" src="https://github.com/user-attachments/assets/0bfb079d-63f5-46b9-aa42-deada3c4fe3d" />
<img width="64" height="96" alt="image" src="https://github.com/user-attachments/assets/2291bf6f-31fb-4443-9000-1be27692239f" />
<img width="64" height="96" alt="image" src="https://github.com/user-attachments/assets/ee30ba72-18e9-43ab-906b-96af8a41791e" />
<img width="64" height="96" alt="image" src="https://github.com/user-attachments/assets/96c4ddf2-37a8-4561-91b4-7c87f90070e6" />
<img width="64" height="96" alt="image" src="https://github.com/user-attachments/assets/cf397d18-7463-4c12-ae64-33fc9f9322a0" />
<img width="64" height="96" alt="image" src="https://github.com/user-attachments/assets/0f4072d9-29a7-4f53-8660-35fe24007bab" />
<img width="16" height="16" alt="image" src="https://github.com/user-attachments/assets/647c2432-9b29-45b3-9c77-6495aadd4782" />
<img width="16" height="16" alt="image" src="https://github.com/user-attachments/assets/387f238e-6482-4f24-9f2a-2d938db20009" />

*Movement animations* - Both the player and NPCs should display different animated sprites when moving vs. not moving. In the player sprite's case, this meant using a sprite change signal linked to player inputs. On the other hand, NPC sprite handling calculated sprite choice dependent on the separate movement logic in [locomotion.gd](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scripts/NPC/locomotion.gd), calculating direction and magnitude of velocity to determine which sprite to use. A naming convention of \<action\>_\<direction\> was used for all animations uploaded to animated sprites allowing for dynamic calculation of animation name based on movement. [Player animation](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scripts/Player/character_facing.gd), Player sprite calculation handling: [1](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scripts/Player/character.gd), [2](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scripts/Player/player.gd), [NPC animation](https://github.com/nithinsenthil/UCDBTS/blob/main/ucdbts/Scripts/NPC/npc_sprite.gd), [NPC direction calculation](https://github.com/nithinsenthil/UCDBTS/blob/89a5e8fe445850f593f16b975c6916b390f93217/ucdbts/Scripts/NPC/locomotion.gd#L21).

*Bike assets* - I also created original bike spritesheets for all 5 bike types in the game. These designs were based on common bike archetypes I could think of from my experience being a UC Davis student and (previously) a Davis bike owner. These bike spritesheets, similarly to the character sheets, could also face in 4 different directions, thus, I had to create three sprites per spritesheet for each bike with a side, front, and back-facing bike. Since the bike sprites themselves are not animated, I did not need to use an AnimatedSprite2D or similar to implement setting directions-- instead, I used the region field of texture attributes for a Sprite2D node, and adjusted by an offset (height of one sprite) at runtime based on the bike's chosen direction. The hitbox and collision box of each bike also changes dynamically based on its direction. Bonus: I also added rust and sparkle effects that are overlaid on the bikes at runtime based on the "tier" chosen for a bike in the level scene. These effects are animated with three frames each. The sparkle was created with a single spritesheet, but in the case of the rust, I used three separate spritesheets corresponding with the three directional bike sprites to ensure the rust could sit correctly on the bike's frame in the game. Bonus: I also created a 16x16 bike icon to use for the bike inventory hotbar, indicating that one slot of the bike inventory has been filled. [Bike assets commit](https://github.com/nithinsenthil/UCDBTS/commit/4d3d60c37881f32581efcef3bdf931d45af131fb), Bike sprite selection commits: [1](https://github.com/nithinsenthil/UCDBTS/commit/e02f72aaf5d876e1c9b80589c88d45a3f7f27fee), [2](https://github.com/nithinsenthil/UCDBTS/commit/ca4569bda3ee665de529e66138df11174984b6c2), [Bike effects commit](https://github.com/nithinsenthil/UCDBTS/commit/ad30ac4fb10f362e2ba5fc55091d80568b87793c), [Bike icon commit](https://github.com/nithinsenthil/UCDBTS/commit/0c12ab8c33c26dcc8fffe1b5478cbd483db3d394), [Bike hitbox and collision box commit](https://github.com/nithinsenthil/UCDBTS/commit/3dd5f897c4efef5b0279dd268f5dd7e53fcd93f1)

<img width="40" height="60" alt="image" src="https://github.com/user-attachments/assets/9d518f7c-703f-4397-b2bb-24c2f626a1fd" />
<img width="40" height="60" alt="image" src="https://github.com/user-attachments/assets/cb0bc887-e6d7-4bdf-b233-178ad9a3af24" />
<img width="40" height="60" alt="image" src="https://github.com/user-attachments/assets/18a90607-d894-4830-b22b-70f2d0f958c8" />
<img width="40" height="60" alt="image" src="https://github.com/user-attachments/assets/4a733fa9-c0d6-40b7-abf1-1eba9bc95ef6" />
<img width="40" height="60" alt="image" src="https://github.com/user-attachments/assets/4d7eec15-495d-4972-95f9-02bccb51690e" />
<img width="40" height="60" alt="image" src="https://github.com/user-attachments/assets/0c0d8b64-d9f9-4448-bf59-a1e265438e27" />
<img width="40" height="60" alt="image" src="https://github.com/user-attachments/assets/eb78e235-ff4f-4785-bae9-88f71b219ec2" />
<img width="40" height="60" alt="image" src="https://github.com/user-attachments/assets/0a9d56ca-7f2f-4000-84c4-4fc27b15a51b" />
<img width="40" height="60" alt="image" src="https://github.com/user-attachments/assets/0adece26-b247-4747-be60-cd1b58fcdee4" />
<img width="40" height="60" alt="image" src="https://github.com/user-attachments/assets/7065072b-b0db-4312-865b-c5d131ffb867" />

*Hotbar and items* - There are 5 different items in the game, and I created unique original assets for each of them. Each item has a high resolution 158x129 art asset used in the shop and a 16x16 icon used in the HUD hotbar. I also created the HUD template and chose the positions of text and items within the HUD. When creating items and the HUD, I kept contrast and game feel especially in mind to ensure colors had enough contrast and didn't clash too much during gameplay. Item commits: [1](https://github.com/nithinsenthil/UCDBTS/commit/2a63879d2c81f0d851c7b44bf5d67b8c5758f532), [2](https://github.com/nithinsenthil/UCDBTS/commit/744ef96e07fb0b33d0213e4d150cb50fa1140d7b). [HUD revamp](https://github.com/nithinsenthil/UCDBTS/commit/73666e7d02dc425ba8144981f17dac3be645914c), [Item display in hotbar](https://github.com/nithinsenthil/UCDBTS/commit/aff73b7ea64ead8e0c2ae1ba608faf2398ba1fb4)

<img width="158" height="129" alt="image" src="https://github.com/user-attachments/assets/e89bd4e6-e825-403e-959e-2c9d4ba91758" />
<img width="158" height="129" alt="image" src="https://github.com/user-attachments/assets/b7569ee3-6df5-4f19-905b-439952b55c50" />
<img width="158" height="129" alt="image" src="https://github.com/user-attachments/assets/a8d2a66f-4775-489c-a9e9-405bf2ba998c" />
<img width="158" height="129" alt="image" src="https://github.com/user-attachments/assets/4411c0e1-ffa7-4c4b-98d2-87ddaef31047" />
<img width="158" height="129" alt="image" src="https://github.com/user-attachments/assets/38bd4714-2c5c-4848-b7a6-29049beea1bf" />
<img width="158" height="129" alt="image" src="https://github.com/user-attachments/assets/ba44bff6-5ae5-4389-8435-4a30b4bf3e38" />
<img width="16" height="16" alt="image" src="https://github.com/user-attachments/assets/713b382f-5db1-4e7c-ba44-09b7e6aacbcd" />
<img width="16" height="16" alt="image" src="https://github.com/user-attachments/assets/c28ec446-ca3e-4cb9-a09a-437132c7e67e" />
<img width="16" height="16" alt="image" src="https://github.com/user-attachments/assets/627911a5-faa6-4d0b-ae55-0f6c0d23c5c0" />
<img width="16" height="16" alt="image" src="https://github.com/user-attachments/assets/ab0526df-3d2e-4cbd-b290-706d2358c56b" />
<img width="16" height="16" alt="image" src="https://github.com/user-attachments/assets/591a0ac0-96cc-483f-9622-014414906480" />
<img width="16" height="16" alt="image" src="https://github.com/user-attachments/assets/d6755de1-b5f4-40df-a98b-19b20800ea20" />

*Title screen* - I designed and created the visuals for the title screen including separate assets for the background, buttons, and title text. The title text was later reused in the press kit. The exclamation point asset was also taken on as a micro-icon of sorts and used as the favicon in the press kit. The title text is also animated to float up and down on the title screen for an extra element of visual engagement. [Commit](https://github.com/nithinsenthil/UCDBTS/commit/24b8415f4567950cdb117339dab4bfa503072009)

<img width="640" height="360" alt="image" src="https://github.com/user-attachments/assets/5660de04-593b-4a33-915a-95b3d03c0a20" />

*Shop interface* - I designed and created the UI and assets for the shop. The shop assets consist of a background with space for info text and item images, and buttons. The background includes a mysterious shopkeeper NPC that plays into our game's narrative. Under the NPC, there is a textbox that displays a rotating arrangement of possible dialogue options. The dialogue for the first shop encounter is always the same, and is then randomized for subsequent days. Asset commits: [1](https://github.com/nithinsenthil/UCDBTS/commit/f67c61efa2b6176dbcf7a71186c0f467c8f90309), [2](https://github.com/nithinsenthil/UCDBTS/commit/0d222044fca12b718c1d23c2563a06fbe4d7f2f1). [Rotating dialogue](https://github.com/nithinsenthil/UCDBTS/commit/3dcd237d675d1650c5c8b31a9357c9b29ab2460a)

<img width="640" height="360" alt="image" src="https://github.com/user-attachments/assets/28029e54-4a4f-4bd8-9cb5-6c62d38cc118" />

*Font* - To ensure visual cohesion, I chose a pixel font ([FS Pixel Sans Unicode](https://www.1001fonts.com/fs-pixel-sans-unicode-regular-font.html)) to use throughout the project. To prevent rendering issues, I make sure that the font is used strictly at multiples of 16px only. [Commit](https://github.com/nithinsenthil/UCDBTS/commit/1f0d4f551868d09ba84131c6736406378fd41bcc)

### Sub-Role: Press Kit and Trailer ###

*Trailer* - I created a 1-minute trailer using gameplay footage. I took footage without audio so I could overlay a single audio track to play smoothly throughout after the initial intro section. [YouTube link](https://www.youtube.com/watch?v=CkUu2t9rGNo)

*Press kit* - I created a press kit website for the game and deployed it on my GitHub pages domain. It includes a call-to-action (CTA) that directs the user to our web release, an embedded version of the trailer, some basic information, and an image gallery. [GitHub pages link](https://naomitzhao.github.io/ecs179-presskit/)
