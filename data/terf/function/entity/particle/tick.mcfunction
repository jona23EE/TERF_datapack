#terf_data_A = time
#terf_data_B = max time

scoreboard players add @s terf_data_A 1
execute unless score @s terf_data_B matches 0.. store result score @s terf_data_B run data get entity @s view_range
function terf:entity/particle/move

execute unless loaded ~ ~ ~ run return run kill @s
execute if score @s terf_data_A >= @s terf_data_B run return run kill @s

execute if entity @s[tag=terf_humongous_smoke] run return run function terf:entity/particle/humongous_smoke/tick
execute if entity @s[tag=terf_humongous_fire] run return run function terf:entity/particle/humongous_fire/tick
execute if entity @s[tag=terf_large_flash] run return run function terf:entity/particle/large_flash/tick
execute if entity @s[tag=terf_small_flash] run return run function terf:entity/particle/small_flash/tick
execute if entity @s[tag=terf_humongous_flash] run return run function terf:entity/particle/homongous_flash/tick
execute if entity @s[tag=terf_gas_leak] run return run function terf:entity/particle/gas_leak/tick
execute if entity @s[tag=terf_light_beam] run function terf:entity/particle/light_beam/tick
