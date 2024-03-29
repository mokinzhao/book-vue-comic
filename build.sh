function readJson {  
  UNAMESTR=`uname`
  if [[ "$UNAMESTR" == 'Linux' ]]; then
    SED_EXTENDED='-r'
  elif [[ "$UNAMESTR" == 'Darwin' ]]; then
    SED_EXTENDED='-E'
  fi; 

  VALUE=`grep -m 1 "\"${2}\"" ${1} | sed ${SED_EXTENDED} 's/^ *//;s/.*: *"//;s/",?//'`

  if [ ! "$VALUE" ]; then
    echo "Error: Cannot find \"${2}\" in ${1}" >&2;
    exit 1;
  else
    echo $VALUE ;
  fi; 
}
VERSION=`readJson package.json version` || exit 1
NAME=`readJson package.json name` || exit 1
DESC=`readJson package.json description` || exit 1


git pull origin release/prod 
git tag $VERSION
if [ $? -eq 0 ]; then
    echo "tag成功";
else
    echo "打tag失败。";
    exit 1
fi; 

git push origin $VERSION
git add -A
git commit -m $DESC
git push origin release/prod

npm run build

docker build -t registry.cn-hangzhou.aliyuncs.com/uki-web/${NAME}:v${VERSION} .
docker push registry.cn-hangzhou.aliyuncs.com/uki-web/${NAME}:v${VERSION}

