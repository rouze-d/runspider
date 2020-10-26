#!/bin/bash

YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
GGG=$(tput setaf 5)
CYN=$(tput setaf 7)
BOLD=$(tput bold)
STAND=$(tput sgr 0)
pwd=$(pwd)

host="$2"


if [ -z $host ]; then
    echo "
  ┳━┓  ┳ ┓  ┏┓┓  ┓━┓  ┳━┓  o  ┳━┓  ┳━┓  ┳━┓
  ┃┳┛  ┃ ┃  ┃┃┃  ┗━┓  ┃━┛  ┃  ┃ ┃  ┣━   ┃┳┛
  ┇┗┛  ┇━┛  ┇┗┛  ━━┛  ┇    ┇  ┇━┛  ┻━┛  ┇┗┛ betaVersion" | lolcat -p 0.7
    echo -e "                                by-$BOLD rouze_d$STAND"
    echo -e "$BLUE just a web crawler$STAND"
    echo " bash $0 --url https://www.target.com"
    exit
fi


echo "
  ┳━┓  ┳ ┓  ┏┓┓  ┓━┓  ┳━┓  o  ┳━┓  ┳━┓  ┳━┓
  ┃┳┛  ┃ ┃  ┃┃┃  ┗━┓  ┃━┛  ┃  ┃ ┃  ┣━   ┃┳┛
  ┇┗┛  ┇━┛  ┇┗┛  ━━┛  ┇    ┇  ┇━┛  ┻━┛  ┇┗┛ betaVersion" | lolcat -p 0.7
echo -e "                                by-$BOLD rouze_d$STAND"
echo -e "$BLUE just a web crawler$STAND"

echo ""


web=`echo $host| cut -d '.' -f 2,3,4,5,6`
web2=`echo $host | cut -d '/' -f 3,4,5,6`
rm -fr $web2
mkdir $web2

echo ""
curl -s -k --url $host --user-agent 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Brave Chrome/78.0.3904.108 Safari/537.36' --connect-timeout 45 -m 45   | tr ' ' '\n' | grep -E 'href='\|'src='\|'"/'\|'//' | cut -d '"' -f 2 | cut -d '"' -f 1 >> $web2/outfb.txt


cat $web2/outfb.txt | head -n2 | grep -E '[a-z]' > /dev/null
if [ "$?" != 0 ];then
    echo ""
    echo " Check Internet Connection"
    exit 1
fi



# grep one '/'
for x in {1..300};
do
cat $web2/outfb.txt | head -n $x | tail -n 1 | head -c 2 | grep -iE '/[a-z]'\|'/[0-9]' >> /dev/null
if [ "$?" != 1 ];then
    cat $web2/outfb.txt | head -n $x | tail -n 1  | sort | uniq >> $web2/ext01.txt
fi
done

# grep two '//'
for x in {1..300};
do
cat $web2/outfb.txt | head -n $x | tail -n 1 | head -c 3 | grep -iE '//[a-z]'\|'//[0-9]' >> /dev/null
if [ "$?" != 1 ];then
    cat $web2/outfb.txt | head -n $x | tail -n 1  | sort | uniq >> $web2/ext02.txt
fi
done

# grep 'http'
for x in {1..300};
do
cat $web2/outfb.txt | head -n $x | tail -n 1 | head -c 4 | grep 'http' >> /dev/null
if [ "$?" != 1 ];then
    cat $web2/outfb.txt | head -n $x | tail -n 1  | sort | uniq >> $web2/ext03.txt
fi
done



# for add 'https://$host' on URL
for x in `cat $web2/ext01.txt`
do
    echo -e $host$x >> $web2/ext011.txt
done

# for add 'https' on URL
for x in `cat $web2/ext02.txt`
do
    echo -e 'https:'$x >> $web2/ext011.txt
done


cat $web2/ext*.txt | grep $web | sort | uniq >> $web2/result1.lst
cat $web2/result1.lst




#================================== lolololololololololo ================
rm -f $web2/*.txt




echo ""
for x in `cat $web2/result1.lst`;
do
curl -s -k --url $x --user-agent 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Brave Chrome/78.0.3904.108 Safari/537.36' --connect-timeout 45 -m 45   | tr ' ' '\n' | grep -E 'href='\|'src='\|'"/'\|'//' | cut -d '"' -f 2 | cut -d '"' -f 1 >> $web2/outfb.txt
#--
# grep one '/'
    for x in {1..300};
    do
        cat $web2/outfb.txt | head -n $x | tail -n 1 | head -c 2 | grep -iE '/[a-z]'\|'/[0-9]' >> /dev/null
    if [ "$?" != 1 ];then
        cat $web2/outfb.txt | head -n $x | tail -n 1  | sort | uniq >> $web2/ext01.txt
    fi
    done

# grep two '//'
    for x in {1..300};
    do
        cat $web2/outfb.txt | head -n $x | tail -n 1 | head -c 3 | grep -iE '//[a-z]'\|'//[0-9]' >> /dev/null
    if [ "$?" != 1 ];then
        cat $web2/outfb.txt | head -n $x | tail -n 1  | sort | uniq >> $web2/ext02.txt
    fi
    done

# grep 'http'
    for x in {1..300};
    do
        cat $web2/outfb.txt | head -n $x | tail -n 1 | head -c 4 | grep 'http' >> /dev/null
    if [ "$?" != 1 ];then
        cat $web2/outfb.txt | head -n $x | tail -n 1  | sort | uniq >> $web2/ext03.txt
    fi
    done



# for add 'https://$host' on URL
    for x in `cat $web2/ext01.txt`
    do
        echo -e $host$x >> $web2/ext011.txt
    done

# for add 'https' on URL
    for x in `cat $web2/ext02.txt`
    do
        echo -e 'https:'$x >> $web2/ext011.txt
    done
#--
cat $web2/ext*.txt | grep $web | sort | uniq >> $web2/result2.lst
cat $web2/result2.lst  | sort | uniq
done

cat $web2/outfb.txt | head -n2 | grep -iE '[a-z]' > /dev/null
if [ "$?" != 0 ];then
    echo ""
    cat $web2/*.lst | sort | uniq >> $web2/$web.out
    echo "================"
    echo "*              *"
    echo "*     DONE     *"
    echo "*              *"
    echo "================"
    echo ""
    cat $web2/$web.out
    echo "================"
    echo ""
    exit 1
fi






cat $web2/ext*.txt | grep $web | sort | uniq >> $web2/result2.lst
cat $web2/result2.lst | sort | uniq >> $web2/result3.lst
cat $web2/result3.lst


#================================== lolololololololololo ================
rm -f $web2/*.txt



echo ""
for x in `cat $web2/result3.lst`;
do
curl -s -k --url $x --user-agent 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Brave Chrome/78.0.3904.108 Safari/537.36' --connect-timeout 45 -m 45   | tr ' ' '\n' | grep -E 'href='\|'src='\|'"/'\|'//' | cut -d '"' -f 2 | cut -d '"' -f 1 >> $web2/outfb.txt
#--
# grep one '/'
    for x in {1..300};
    do
        cat $web2/outfb.txt | head -n $x | tail -n 1 | head -c 2 | grep -iE '/[a-z]'\|'/[0-9]' >> /dev/null
    if [ "$?" != 1 ];then
        cat $web2/outfb.txt | head -n $x | tail -n 1  | sort | uniq >> $web2/ext01.txt
    fi
    done

# grep two '//'
    for x in {1..300};
    do
        cat $web2/outfb.txt | head -n $x | tail -n 1 | head -c 3 | grep -iE '//[a-z]'\|'//[0-9]' >> /dev/null
    if [ "$?" != 1 ];then
        cat $web2/outfb.txt | head -n $x | tail -n 1  | sort | uniq >> $web2/ext02.txt
    fi
    done

# grep 'http'
    for x in {1..300};
    do
        cat $web2/outfb.txt | head -n $x | tail -n 1 | head -c 4 | grep 'http' >> /dev/null
    if [ "$?" != 1 ];then
        cat $web2/outfb.txt | head -n $x | tail -n 1  | sort | uniq >> $web2/ext03.txt
    fi
    done



# for add 'https://$host' on URL
    for x in `cat $web2/ext01.txt`
    do
        echo -e $host$x >> $web2/ext011.txt
    done

# for add 'https' on URL
    for x in `cat $web2/ext02.txt`
    do
        echo -e 'https:'$x >> $web2/ext011.txt
    done
#--
cat $web2/ext*.txt | grep $web | sort | uniq >> $web2/result4.lst
cat $web2/result4.lst | sort | uniq
done

cat $web2/outfb.txt | head -n2 | grep -iE '[a-z]' > /dev/null
if [ "$?" != 0 ];then
    echo ""
    cat $web2/*.lst | sort | uniq >> $web2/$web.out
    echo "================"
    echo "*              *"
    echo "*     DONE     *"
    echo "*              *"
    echo "================"
    echo ""
    cat $web2/$web.out
    echo "================"
    echo ""
    exit 1
fi

cat $web2/ext*.txt | grep $web | sort | uniq >> $web2/result4.lst
cat $web2/result4.lst | sort | uniq >> $web2/result5.lst
cat $web2/result5.lst


#================================== lolololololololololo ================
rm -f $web2/*.txt



echo ""
for x in `cat $web2/result5.lst`;
do
curl -s -k --url $x --user-agent 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Brave Chrome/78.0.3904.108 Safari/537.36' --connect-timeout 45 -m 45   | tr ' ' '\n' | grep -E 'href='\|'src='\|'"/'\|'//' | cut -d '"' -f 2 | cut -d '"' -f 1 >> $web2/outfb.txt
#--
# grep one '/'
    for x in {1..300};
    do
        cat $web2/outfb.txt | head -n $x | tail -n 1 | head -c 2 | grep -iE '/[a-z]'\|'/[0-9]' >> /dev/null
    if [ "$?" != 1 ];then
        cat $web2/outfb.txt | head -n $x | tail -n 1  | sort | uniq >> $web2/ext01.txt
    fi
    done

# grep two '//'
    for x in {1..300};
    do
        cat $web2/outfb.txt | head -n $x | tail -n 1 | head -c 3 | grep -iE '//[a-z]'\|'//[0-9]' >> /dev/null
    if [ "$?" != 1 ];then
        cat $web2/outfb.txt | head -n $x | tail -n 1  | sort | uniq >> $web2/ext02.txt
    fi
    done

# grep 'http'
    for x in {1..300};
    do
        cat $web2/outfb.txt | head -n $x | tail -n 1 | head -c 4 | grep 'http' >> /dev/null
    if [ "$?" != 1 ];then
        cat $web2/outfb.txt | head -n $x | tail -n 1  | sort | uniq >> $web2/ext03.txt
    fi
    done



# for add 'https://$host' on URL
    for x in `cat $web2/ext01.txt`
    do
        echo -e $host$x >> $web2/ext011.txt
    done

# for add 'https' on URL
    for x in `cat $web2/ext02.txt`
    do
        echo -e 'https:'$x >> $web2/ext011.txt
    done
#--
cat $web2/ext*.txt | grep $web | sort | uniq >> $web2/result6.lst
cat $web2/result6.lst | sort | uniq
done

cat $web2/outfb.txt | head -n2 | grep -iE '[a-z]' > /dev/null
if [ "$?" != 0 ];then
    echo ""
    cat $web2/*.lst | sort | uniq >> $web2/$web.out
    echo "================"
    echo "*              *"
    echo "*     DONE     *"
    echo "*              *"
    echo "================"
    echo ""
    cat $web2/$web.out
    echo "================"
    echo ""
    exit 1
fi

cat $web2/ext*.txt | grep $web | sort | uniq >> $web2/result6.lst
cat $web2/result6.lst | sort | uniq >> $web2/result7.lst
cat $web2/result7.lst

#================================== lolololololololololo ================
rm -f $web2/*.txt






cat $web2/*.lst | sort | uniq >> $web2/$web.out

echo "================"
echo "*              *"
echo "*     DONE     *"
echo "*              *"
echo "================"
echo ""
cat $web2/$web.out
echo "================"
