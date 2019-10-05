FROM quay.io/vchintal/openshift-client:4.1.18
ADD ./startup.sh startup.sh
USER 1000
