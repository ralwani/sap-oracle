### <img src="../../../assets/images/UnicornSAPBlack256x256.png" width="64px"> SAP Deployment Automation Framework <!-- omit in toc -->
<br/><br/>

# SPN Credentials <!-- omit in toc -->

<br/>

## Table of contents <!-- omit in toc -->

- [Overview](#overview)
- [Procedure](#procedure)
  - [Bootstrap - SPN Creation](#bootstrap---spn-creation)

<br/>

## Overview

The Deployer uses the SPN to deploy resources into a subscription.
The Environment input is used as a key to lookup the SPN information from the deployer KeyVault.
This allows for mapping of an environment to a subscription, along with credentials.

<br/><br/>

|                  |              |
| ---------------- | ------------ |
| Duration of Task | `5 minutes`  |
| Steps            | `4`          |
| Runtime          | `3 minutes`  |

<br/>

---

<br/><br/>

## Procedure

### Bootstrap - SPN Creation

<br/>

1. Cloud Shell
   1. Log on to the [Azure Portal](https://portal.azure.com).
   2. Open the cloud shell.
      <br/>![Cloud Shell](assets/CloudShell1.png)
      <br/><br/>

2. Ensure that you are authenticated with the correct subscription.
    ```bash
    az login
    az account list --output=table | grep -i true
    ```

    If not, then find and set the Default to the correct subscription.

    ```bash
    az account list --output=table
    az account set  --subscription XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
    ```
    <br/>

3. Create SPN<br/>
    From a privilaged account, create an SPN.<br/>
    The Subscription ID that you are deploying into is reqired.
    ```
    az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" --name="Deployment-Account-NP"
    ```
    <br/><br/>

4. Record the credential outputs.<br/>
   The pertinant fields are:
   - appId
   - password
   - tenant
    ```
    {
      "appId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
      "displayName": "Deployment-Account-NP",
      "name": "http://Deployment-Account-NP",
      "password": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
      "tenant": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx""
    }
    ```
    <br/><br/>

5. Add Role Assignment to SPN.
    ```
    az role assignment create --assignee <appId> --role "User Access Administrator"
    ```
    <br/><br/>

6. Add keys for SPN to KeyVault.
   - Where `<ENV>` is the environment.
   - Where `<User_KV_name>`
   - Where `<subscription-id>`
   - Where `<appId>`
   - Where `<password>`
   - Where `<tenant>`
    ```
    az keyvault secret set --name "<ENV>-subscription-id" --vault-name "<User_KV_name>" --value "<subscription-id>";
    az keyvault secret set --name "<ENV>-client-id"       --vault-name "<User_KV_name>" --value "<appId>";
    az keyvault secret set --name "<ENV>-client-secret"   --vault-name "<User_KV_name>" --value "<password>";
    az keyvault secret set --name "<ENV>-tenant-id"       --vault-name "<User_KV_name>" --value "<tenant>";
    ```

<br/><br/><br/><br/>


# Next: [Bootstrap - Library](02-prepare-environment.md) <!-- omit in toc -->
