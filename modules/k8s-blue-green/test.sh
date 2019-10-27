kubectl run ubuntu --image=alpine -ti --restart=Never  --rm=true -- sh -c 'while :;do wget -T1 -q -O- fussy|grep Version ;sleep 0.5;done'
