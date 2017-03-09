#!/bin/bash

INSTANCENAME=${INSTANCENAME:-"myinst"}

MACHINETYPE=${MACHINETYPE:-"n1-standard-1"}
IMAGEPROJECT=ubuntu-os-cloud
IMAGEFAMILY=ubuntu-1604-lts
INSTANCEZONE=us-central1-a

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

. ${DIR}/util.sh

echo "Creating instance ${INSTANCENAME}"

if ! gcloud compute instances create ${INSTANCENAME} \
   --machine-type=${MACHINETYPE} \
   --image-project=${IMAGEPROJECT} \
   --image-family=${IMAGEFAMILY} \
   --zone=${INSTANCEZONE} ; then

  fatal "Failed to create instance ${INSTANCENAME}"

fi

while ! gcloud compute ssh ${INSTANCENAME} \
       --zone=${INSTANCEZONE} \
       "exit 0" ; do
  echo "Waiting..."
done

if ! gcloud compute copy-files \
	${DIR}/y.sh ${DIR}/util.sh ${INSTANCENAME}: \
       --zone=${INSTANCEZONE} ; then

  fatal "Failed to copy files to instance ${INSTANCENAME}"
   
fi

if ! gcloud compute ssh ${INSTANCENAME} \
       --zone=${INSTANCEZONE} \
       "./y.sh" ; then
	
  echo "Failed to configure instance ${INSTANCENAME}"
  exit 1
   
fi


