# Auto-approve Openshift 4.x UPI CSRs

This repo is to be used with caution and mainly will help any UPI of Openshift 4.x where the [CSRs](https://docs.openshift.com/container-platform/4.1/installing/installing_bare_metal/installing-bare-metal.html#installation-approve-csrs_installing-bare-metal) need to be approved manually. When this is not in place you will see some odd behavior of Openshift and may not realize that the approvals of some CSRs is pending

>For the next steps below, checkout this repo and change-directory into it.

## (Optional) Create the container image that performs the auto-approval

```sh 
# Using the tag 4.1.18 because the base image uses oc client ver4.1.18
podman build . -t ocp4-auto-approve-csr:4.1.18

# Change the <quay-username> to your quay.io username
podman push localhost/ocp4-auto-approve-csr:4.1.18 quay.io/<quay-username>/ocp4-auto-approve-csr:4.1.18
```

## Deploy the cron-job onto Openshift 4.x

```sh 
# Create a new openshift folder and call it openshift-cron-jobs
oc adm new-project openshift-cron-jobs

# Provide the default service account of openshift-cron-jobs the role of cluster-admin
oc adm policy add-cluster-role-to-user cluster-admin -z default -n openshift-cron-jobs

# Review the ocp4-auto-approve-csr.yml file, customize it the way you want and deploy it
oc create -f ocp4-auto-approve-csr.yml
```

If you have gone with the defaults in the file `ocp4-auto-approve-csr.yml` then you should see the CSRs getting approved every hour.
