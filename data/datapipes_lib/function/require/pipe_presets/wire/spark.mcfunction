execute positioned ^ ^ ^.5 align xyz run damage @p[dx=0,dy=0,dz=0] 10 terf:high_voltage

execute rotated ~90 0 run particle electric_spark ^ ^ ^.125 0 0 0 1 10
execute rotated ~-90 0 run particle electric_spark ^ ^ ^.125 0 0 0 1 10
execute rotated ~90 0 run particle firework ^ ^ ^.125 0 0 0 0.1 5
execute rotated ~-90 0 run particle firework ^ ^ ^.125 0 0 0 0.1 5

function terf:require/play_with_random_pitch {s:'terf:welding master @a[distance=0..] ~ ~ ~ 1',min:10000,max:20000}
