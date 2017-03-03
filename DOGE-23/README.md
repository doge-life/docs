# DOGE-23 - AWS Permissions and Resources for Terraform

##  Remote state (Store state of Terraform infrastructure on S3)
* Set `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables
* Execute the following if directory is empty:
```
terraform init \
    -backend=s3 -backend-config=“bucket=<s3 bucket>” \
    -backend-config=“key=<path to terraform state file in bucket>” \
    -backend-config=“region=<region of s3 bucket>”
    .
```
* `example.tf` uses the remote state if it is configured to do so.
* If you want to switch from saving state locally to remote, switch out `init` for `remote config` in the above command.
* Need to keep this in mind when using Terraform as part of Jenkins pipeline

## Permissions
* Can create an IAM user and assign to group with a new policy
* On our AWS, we have a user called `terraform-test`, who is a part of the `terraform-deploy` group. The group has the policy `terraform-test-policy` attached to it.
* The policy grants the following permissions:
    * S3
        * DeleteObject (maybe...?)
        * GetObject
        * PutObject
        * ListBucket
    * EC2
        * Describe*
        * AttachVolume
        * DetachVolume
        * RunInstances
        * TerminateInstances
        * StopInstances
        * StartInstances
        * ModifyInstanceAttribute
* Note that the permissions above works with `example.tf` in this folder. You may need more permissions, depending on what the AWS provider needs to do.
    * The example assumes `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables are set.
    * If you need to find out what API calls Terraform is using so you can set the correct permissions on the policy, set the following environment variables before calling `terraform apply` so you get meaningful log output.
        * `export TF_LOG=DEBUG`
        * `export TF_LOG_PATH=./tf.log`