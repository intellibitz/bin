USAGE="usage: $0 [-k sshkey] -h hostname [-c command]"
while getopts h:k:c: flag; do
  case "${flag}" in
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
fi
if [ -z "${cmd}" ]; then
  cmd="ls"
fi
#echo "${cmd}"
ssh -i "${key}" "${host}" -T <<EOSSH
sh -c "${cmd}"
EOSSH
