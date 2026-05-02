scoreboard players set @s datapipes_lib_power_storage 0

execute if entity @s[tag=!terf_breaker_started] run return fail

scoreboard players set @s datapipes_lib_power_max 0
scoreboard players set @s terf_data_A 0

playsound terf:switch master @a[distance=..128] ~ ~ ~ 8 1
playsound terf:switch master @a[distance=..128] ~ ~ ~ 8 0.8

execute positioned ^ ^ ^2 run function terf:entity/machines/breakers/button_off
execute positioned ^ ^1 ^2 run function terf:entity/machines/breakers/button_off
execute positioned ^ ^-1 ^2 run function terf:entity/machines/breakers/button_off

execute positioned ^1 ^ ^3 run function terf:entity/machines/breakers/button_off
execute positioned ^1 ^1 ^3 run function terf:entity/machines/breakers/button_off
execute positioned ^1 ^-1 ^3 run function terf:entity/machines/breakers/button_off
execute positioned ^1 ^ ^4 run function terf:entity/machines/breakers/button_off
execute positioned ^1 ^1 ^4 run function terf:entity/machines/breakers/button_off
execute positioned ^1 ^-1 ^4 run function terf:entity/machines/breakers/button_off

execute positioned ^-1 ^ ^3 run function terf:entity/machines/breakers/button_off
execute positioned ^-1 ^1 ^3 run function terf:entity/machines/breakers/button_off
execute positioned ^-1 ^-1 ^3 run function terf:entity/machines/breakers/button_off
execute positioned ^-1 ^ ^4 run function terf:entity/machines/breakers/button_off
execute positioned ^-1 ^1 ^4 run function terf:entity/machines/breakers/button_off
execute positioned ^-1 ^-1 ^4 run function terf:entity/machines/breakers/button_off

tag @s remove terf_breaker_activated
tag @s remove terf_breaker_started