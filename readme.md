ci cd pipeline is made to run in Azure devops,
terraform spin up the k8s cluster and
helm deploys the mediawiki app to k8s

Prerequisites
First define
         resource_group_name   = "RG_NAME"
        storage_account_name  = "SA_NAME"
        container_name        = "Container_Name"
        key                   = "terraform.tfstate"

under terraform main.tf file to store the terraform tf state files
under pipelines folder edit install_mediawiki.yml file
accordingly as below line with the azure SPN
                 az login --service-principal -u XXXXX -p XXXX --tenant XXXX && az account set --subscription XXXX

under pipelines folder edit install_kubernetes.yml file
edit appropriately 
    - task: Terraform@2
      inputs:
        TemplatePath: 'terraform/'
        Arguments: 'apply -auto-approve'
        InstallTerraform: true
        UseAzureSub: true
        ConnectedServiceNameSelector: 'ConnectedServiceNameARM'
        ConnectedServiceNameARM: 'vaisakh_msdn'
        ManageState: true
        SpecifyStorageAccount: true
        StorageAccountResourceGroup: 'myapilearn'
        StorageAccountRM: 'vaisakh'
        StorageContainerName: 'test'


At azure devops side create a service connection to azure cloud subscription   
Now run the pipelines to create the infra and application from 
azure devops

![alt text](https://github.com/vaisakh007/thoughtworks/blob/master/image/mediawiki_out.png)
