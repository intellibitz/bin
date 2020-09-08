USAGE="usage:$0 [-k sshkey] -u username -h hostname -s source [-d destination]"
while getopts u:h:s:d:k: flag; do
  case "${flag}" in
  k) key=${OPTARG} ;;
  u) user=${OPTARG} ;;
  h) host=${OPTARG} ;;
  s) src=${OPTARG} ;;
  d) dst=${OPTARG} ;;
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
scp -i "${key}" -Cprv "${src}" "$user"@"$host":"${dst}"
