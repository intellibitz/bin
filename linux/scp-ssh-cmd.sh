USAGE="usage:$0 [-k sshkey]  -u username -h hostname -s source [-d destination] [-c command]"
while getopts u:h:s:k:c:d: flag; do
  case "${flag}" in
  k) key=${OPTARG} ;;
  u) user=${OPTARG} ;;
  h) host=${OPTARG} ;;
  s) src=${OPTARG} ;;
  d) dst=${OPTARG} ;;
  c) cmd=${OPTARG} ;;
  *) echo "${USAGE}" ;;
  esac
done
if [ -z "${user}" ] || [ -z "${host}" ] || [ -z "${src}" ]; then
  echo "${USAGE}"
  exit 1
fi
if [ -z "${key}" ]; then
  key="$HOME/.ssh/id_rsa"
fi
if [ -z "${dst}" ]; then
  dst="$HOME"
fi
if [ -z "${cmd}" ]; then
  cmd="$HOME/${src}"
fi

scp-Cprv.sh -u "${user}"  -k "${key}" -h "${host}" -f "${src}" -d "${dst}" &&
  ssh-cmd.sh -h "${host}" -k "${key}" -c "${cmd}"
