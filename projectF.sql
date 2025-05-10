select boatname,cargoname ,datediff(day,datetimeentry,exits.datetimepass),count as 'זמן שהות באזור הנמל' from cargos join boats 
on boats.cargoId=cargos.cargoId
join entrys 
on boats.boatId=entrys.boatId
join exits 
on boats.boatId=exits.boatId
join(select cargoid,count(*) as 'count' from unLoadingTools group by cargoId)qq
on cargos.cargoId=qq.cargoId