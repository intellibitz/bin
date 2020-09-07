while getopts n:p: flag; do
  case "${flag}" in
  n) name=${OPTARG} ;;
  p) project=${OPTARG} ;;
  *) echo "usage:$0 -n name -p project" ;;
  esac
done
if [ -z "${name}" ] || [ -z "${project}" ]; then
  echo "usage:$0 -n name -p project"
  exit 1
fi

gcloud iam service-accounts delete "${name}"
gcloud iam service-accounts create "${name}" \
  --project="${project}" \
  --description="${project} Project Service Account" \
  --display-name="${project} Project  Service Account"

gcloud projects add-iam-policy-binding "${project}" \
  --member=serviceAccount:"${name}"@"${project}".iam.gserviceaccount.com \
  --role=roles/compute.instanceAdmin.v1

gcloud projects add-iam-policy-binding "${project}" \
  --member=serviceAccount:"${name}"@"${project}".iam.gserviceaccount.com \
  --role=roles/iam.serviceAccountUser

gcloud iam service-accounts list
