#!/system/bin/sh
if [[ -z $1 ]]; then
  echo -e "Instagram Download Link Generator by RZ\n\nUsage:\n  generate link      `basename $0` [ URL ]\n  direct download    `basename $0` -d [ URL ]"
  exit 1
fi
link=$1
temp=instadl.tmp
case $1 in
  -d)
    link=$2
    wget `$0 $link`
  ;;
esac
curl -qo $temp $link 2> /dev/null
if [[ `grep -q '"og:video"' $temp; echo $?` -eq 0 ]]; then
  grep '"og:video"' $temp | grep -v '"og:image"' | awk '{print $3'} | sed -e 's/"//g' | sed -e 's/content=//g'
else
  grep '"og:image"' $temp | grep -v '"og:video"' | awk '{print $3'} | sed -e 's/"//g' | sed -e 's/content=//g'
fi
if [[ -f $temp ]]; then
  rm $temp
fi
