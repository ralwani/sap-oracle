### <img src="../../../assets/images/UnicornSAPBlack256x256.png" width="64px"> SAP Deployment Automation Framework <!-- omit in toc -->
<br/><br/>

# Bootstrap - SAP Library <!-- omit in toc -->

<br/>

## Table of contents <!-- omit in toc -->

- [Overview](#overview)
- [Notes](#notes)
- [Procedure](#procedure)
  - [Bootstrap - SAP Library](#bootstrap---sap-library)

<br/>

## Overview

![Block3](assets/Block3.png)
|                  |              |
| ---------------- | ------------ |
| Duration of Task | `5 minutes`  |
| Steps            | `5`          |
| Runtime          | `1 minutes`  |

---

<br/><br/>

## Notes

- For the workshop the *default* naming convention is referenced and used. For the **SAP Library** there are three fields.
  - `<ENV>`-`<REGION>`-SAP_LIBRARY

    | Field             | Legnth   | Value  |
    | ----------------- | -------- | ------ |
    | `<ENV>`           | [5 CHAR] | NP     |
    | `<REGION>`        | [4 CHAR] | EUS2   |
  
    Which becomes this: **DEMO-EUS2-SAP_LIBRARY**
    
    This is used in several places:
    - The path of the Workspace Directory.
    - Input JSON file name
    - Resource Group Name.

    You will also see elements cascade into other places.

<br/><br/>

## Procedure

### Bootstrap - SAP Library

<br/>

1. Log on the the Deployer using your SSH Client and the SSH Keys that you retrieved with the Public IP Address.<br/>
   (*Note*) If using Putty, the SSH Key will have to be [converted](https://www.simplified.guide/putty/convert-ssh-key-to-ppk) to ppk format.

2. Repository

    1. (*Optional*) Checkout Branch
        ```bash
        cd  ~/Azure_SAP_Automated_Deployment/sap-hana
        git checkout <branch_name>
        ```
        Do nothing if using **master** branch.<br/>
        Otherwise, use the appropriate
        - Tag         (*ex. v2.1.0-1*)
        - Branch Name (*ex. feature/remote-tfstate2*)
        - Commit Hash (*ex. 6d7539d02be007da769e97b6af6b3e511765d7f7*)
        <br/><br/>

    2. (*Optional*) Verify Branch is at expected Revision
        ```bash
        git rev-parse HEAD
        ```
        <br/>

3. Create Working Directory and prepare JSON.
    <br/>*`Observe Naming Convention`*<br/>
    ```bash
    mkdir -p ~/Azure_SAP_Automated_Deployment/WORKSPACES/LIBRARY/DEMO-EUS2-SAP_LIBRARY; cd $_

    cat <<EOF > DEMO-EUS2-SAP_LIBRARY.json
    {
      "infrastructure": {
        "environment"                         : "DEMO",
        "region"                              : "eastus2"
      },
      "deployer": {
        "environment"                         : "DEMO",
        "region"                              : "eastus2",
        "vnet"                                : "DEP00"
      }
    }
    EOF
    ```
    <br/>

4. Terraform
    1. Initialization
       ```bash
       terraform init  ../../../sap-hana/deploy/terraform/bootstrap/sap_library/
       ```

    2. Plan
       <br/>*`Observe Naming Convention`*<br/>
       ```bash
       terraform plan                                                                  \
                       --var-file=DEMO-EUS2-SAP_LIBRARY.json                           \
                       ../../../sap-hana/deploy/terraform/bootstrap/sap_library
       ```

    3. Apply
       <br/>*`Observe Naming Convention`*<br/>
       *This step deploys the resources*
       ```bash
       terraform apply --auto-approve                                                  \
                       --var-file=DEMO-EUS2-SAP_LIBRARY.json                           \
                       ../../../sap-hana/deploy/terraform/bootstrap/sap_library/
       ```

<br/><br/><br/><br/>

# Next: [Reinitialize](04-reinitialize.md) <!-- omit in toc -->
