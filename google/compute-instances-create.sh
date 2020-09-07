while getopts n:p:s: flag; do
  case "${flag}" in
  n) name=${OPTARG} ;;
  p) project=${OPTARG} ;;
  s) serviceaccount=${OPTARG} ;;
  *) echo "usage:$0 -n name -p project -s serviceaccount" ;;
  esac
done
if [ -z "${name}" ] || [ -z "${project}" ] || [ -z "${serviceaccount}" ]; then
  echo "usage:$0 -n name -p project -s serviceaccount"
  exit 1
fi
gcloud compute instances delete "${name}"
gcloud compute instances create "${name}" \
  --project="${project}" \
  --machine-type=e2-macro \
  --image-family=ubuntu-minimal-2004-lts \
  --image-project=ubuntu-os-cloud \
  --network=default \
  --zone=us-central1-a \
  --service-account="${serviceaccount}"@"${project}".iam.gserviceaccount.com \
  --scopes="https://www.googleapis.com/auth/cloud-platform"
gcloud compute instances list
