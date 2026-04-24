kill @e[tag=terf_fire,type=bat,distance=..1]
scoreboard players remove terminated terf_states 1
execute if score terminated terf_states matches 1.. if block ~ ~ ~ #terf:laser_can_go_through unless block ~ ~ ~ fire positioned ^ ^ ^1 run return run function terf:entity/player/tool/fire_extinguisher/raycast
execute unless block ~ ~ ~ fire run return fail
setblock ~ ~ ~ air
playsound minecraft:block.fire.extinguish master @a[distance=0..] ~ ~ ~ 1 2