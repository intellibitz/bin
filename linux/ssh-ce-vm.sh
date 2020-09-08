while getopts h:k: flag
	do
	    case "${flag}" in
	        h) host=${OPTARG};;
          k) key=${OPTARG} ;;
	        *) echo "usage: $0 -h hostname [-k sshkey]";;
	    esac
	done
if [ -z "${host}" ]; then
  echo "usage:$0 -h hostname [-k sshkey]"
  exit 1
fi
if [ -z "${key}" ]; then
  key="$HOME/.ssh/google_compute_engine"
fi
ssh -i "${key}" "${host}" || echo "usage: $0 -h hostname [-k sshkey]"
