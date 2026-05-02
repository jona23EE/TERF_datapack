playsound terf:switch master @a[distance=..128] ~ ~ ~ 8 1
playsound terf:switch master @a[distance=..128] ~ ~ ~ 8 0.8

execute positioned ^ ^.5 ^1.5 run particle minecraft:electric_spark ~ ~ ~ 0 0 0 0.2 5 force
execute positioned ^ ^1.5 ^1.5 run particle minecraft:electric_spark ~ ~ ~ 0 0 0 0.2 5 force
execute positioned ^ ^-.5 ^1.5 run particle minecraft:electric_spark ~ ~ ~ 0 0 0 0.2 5 force

execute positioned ^1.5 ^.5 ^3 run particle minecraft:electric_spark ~ ~ ~ 0 0 0 0.2 5 force
execute positioned ^1.5 ^1.5 ^3 run particle minecraft:electric_spark ~ ~ ~ 0 0 0 0.2 5 force
execute positioned ^1.5 ^-.5 ^3 run particle minecraft:electric_spark ~ ~ ~ 0 0 0 0.2 5 force
execute positioned ^1.5 ^.5 ^4 run particle minecraft:electric_spark ~ ~ ~ 0 0 0 0.2 5 force
execute positioned ^1.5 ^1.5 ^4 run particle minecraft:electric_spark ~ ~ ~ 0 0 0 0.2 5 force
execute positioned ^1.5 ^-.5 ^4 run particle minecraft:electric_spark ~ ~ ~ 0 0 0 0.2 5 force

execute positioned ^-1.5 ^.5 ^3 run particle minecraft:electric_spark ~ ~ ~ 0 0 0 0.2 5 force
execute positioned ^-1.5 ^1.5 ^3 run particle minecraft:electric_spark ~ ~ ~ 0 0 0 0.2 5 force
execute positioned ^-1.5 ^-.5 ^3 run particle minecraft:electric_spark ~ ~ ~ 0 0 0 0.2 5 force
execute positioned ^-1.5 ^.5 ^4 run particle minecraft:electric_spark ~ ~ ~ 0 0 0 0.2 5 force
execute positioned ^-1.5 ^1.5 ^4 run particle minecraft:electric_spark ~ ~ ~ 0 0 0 0.2 5 force
execute positioned ^-1.5 ^-.5 ^4 run particle minecraft:electric_spark ~ ~ ~ 0 0 0 0.2 5 force

tag @s add terf_breaker_activated
