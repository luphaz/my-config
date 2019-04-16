#!/bin/sh -eu
# Allow to detach a PVC from previously attached node
# Require to have govc/vmdk installed and credentials setup

APP_NAME=$1
FILTER=$2

for vmdk in $(kubectl get pv | awk -v app=${APP_NAME} '$0 ~ app; /$app/ { print $1 }');
do
  for vm in $(govc ls $FILTER);
  do
    echo ${vm}
    govc device.info -vm=${vm} \
    | awk '/Name/ { name=$NF }; /Summary/ { summary=$(NF-1) $NF }; /File/ { print name, summary,  $NF } ';
  done \
  | awk -v vmdk=${vmdk} '/k8s/ && !/KB/ { node=$1 }; $0 ~ vmdk { print node, $1 }' \
  | xargs -tn2 govc device.remove -keep -vm
done