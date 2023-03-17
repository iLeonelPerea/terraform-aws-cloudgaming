# Building Your Dream Cloud Gaming: How to Set Up Your Own Low-Latency Gaming 

### Description
If you're looking to build your dream cloud gaming setup, one of the first steps is to set up your own low-latency gaming server. By configuring your own server, you can have more control over the hardware, software, and network settings, which can result in a smoother and more responsive gaming experience. 
There are several reasons why cloud gaming has become popular in recent times. The first and most important reason is that you can reach quality benchmarks, similar to what is possible on high-end systems on devices that are not dedicated gaming hardware. These high-end resolutions and 60 fps framerates are possible.

### Prerequisites:
1. You will need to make sure you are authenticated into an AWS account.  
3. Ensure that you are on terraform version 1.4.0: `terraform --version`
4. Fill you aws credentials to the file `variables.tfvars`.
5. Run the command `terraform apply -var-file="variables.tfvars"`

### Cleanup

CU. Tear down your infrastructure at the end of every day.
```sh
terraform destroy -var-file="variables.tfvars"
```

## Maintainers

- Leonel Perea