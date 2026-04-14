scoreboard players set @s terf_data_C 1
execute if entity @s[gamemode=!spectator,gamemode=!creative] run scoreboard players set @s terf_data_C 0
clear @s minecraft:carrot_on_a_stick[minecraft:custom_data={id:terf_placeholder}]