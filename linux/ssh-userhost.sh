USAGE="usage:$0 [-k sshkey] [-u username] -h hostname"
while getopts u:h:k: flag; do
  case "${flag}" in
  u) user=${OPTARG} ;;
  h) host=${OPTARG} ;;
  k) key=${OPTARG} ;;
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
if [ -z "${user}" ]; then
  user="$USER"
fi
ssh -i "${key}" "${user}"@"${host}" || echo "${USAGE}"
