while getopts u:h:f:k:c: flag; do
  case "${flag}" in
  u) name=${OPTARG} ;;
  h) host=${OPTARG} ;;
  f) file=${OPTARG} ;;
  k) key=${OPTARG} ;;
  c) command=${OPTARG} ;;
  *) echo "usage: -u username -h hostname -f filename [-k sshkey] [-c command]" ;;
  esac
done
if [ -z "${name}" ] || [ -z "${host}" ] || [ -z "${file}" ]; then
  echo "usage:$0 -u username -h hostname -f filename [-k sshkey] [-c command]"
  exit 1
fi
if [ -z "${key}" ]; then
  key="$HOME/.ssh/google_compute_engine"
fi
if [ -z "${command}" ]; then
  command="$HOME/${file}"
fi

scp-ce-vm.sh -u "${name}" -h "${host}" -f "${file}" -k "${key}" &&
  ssh-cmd-ce-vm.sh -h "${host}" -k "${key}" -c "${command}"
