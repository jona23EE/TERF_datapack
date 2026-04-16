execute if score @s datapipes_lib_power_storage matches 15.. run scoreboard players remove @s datapipes_lib_power_storage 150
scoreboard players remove @s terf_data_A 1
execute if score @s terf_data_A matches ..0 run function terf:entity/machines/ionizer/complete with entity @s data.terf.stored_recipe
playsound terf:machine_hum master @a[distance=0..] ~ ~ ~ 0.3 2