USAGE="usage: $0 [-k sshkey] [-u username] -h hostname [-c command]"
while getopts u:h:k:c: flag; do
  case "${flag}" in
  u) user=${OPTARG} ;;
  h) host=${OPTARG} ;;
  k) key=${OPTARG} ;;
  c) cmd=${OPTARG} ;;
  *) echo "${USAGE}" ;;
  esac
done
if [ -z "${host}" ]; then
  echo "${USAGE}"
  exit 1
fi
if [ -z "${key}" ]; then
  key="$HOME/.ssh/id_rsa"
else
  [ -f "${key}" ] || key="$HOME/.ssh/${key}"
fi
if [ -z "${user}" ]; then
  user="$USER"
fi
if [ -z "${cmd}" ]; then
  cmd="
  echo 'entering ${host}'; \
  ls -al ;\
   echo 'exiting from ${host}'
   "
fi
#echo "${cmd}"
ssh -i "${key}" "${user}"@"${host}" -T <<EOSSH
sh -c "${cmd}"
EOSSH
