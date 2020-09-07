while getopts h:k:c: flag; do
  case "${flag}" in
  h) host=${OPTARG} ;;
  k) key=${OPTARG} ;;
  c) command=${OPTARG} ;;
  *) echo "usage: $0 -h hostname [-k sshkey] [-c command]" ;;
  esac
done
if [ -z "${host}" ]; then
  echo "usage:$0 -h hostname [-k sshkey] [-c command]"
  exit 1
fi
if [ -z "${key}" ]; then
  key="$HOME/.ssh/google_compute_engine"
fi
if [ -z "${command}" ]; then
  command="ls"
fi
#echo "${command}"
ssh -i "${key}" "${host}" -T << EOSSH
"${command}"
EOSSH
