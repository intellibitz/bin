while getopts u:h:f:k: flag; do
  case "${flag}" in
  u) name=${OPTARG} ;;
  h) host=${OPTARG} ;;
  f) file=${OPTARG} ;;
  k) key=${OPTARG} ;;
  *) echo "usage: -u username -h hostname -f filename [-k sshkey]" ;;
  esac
done
if [ -z "${name}" ] || [ -z "${host}" ] || [ -z "${file}" ]; then
  echo "usage:$0 -u username -h hostname -f filename [-k sshkey]"
  exit 1
fi
if [ -z "${key}" ]; then
  key="$HOME/.ssh/google_compute_engine"
fi
scp -i "${key}" "${file}" "$name"@"$host":
