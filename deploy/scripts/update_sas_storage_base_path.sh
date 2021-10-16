# This is the SAP library’s storage account for sap binaries
if [ ! -n "${SAP_LIBRARY_LB}" ] ;then
  read -p "Please provide the SAP Bits storage account from SAP_LIBRARY? "  sapbitslib
else
  sapbitslib="${SAP_LIBRARY_LB}"
fi
base_path=https://${sapbitslib}.blob.core.windows.net/sapbits

# This is the SAP library’s SAS Token for sap binaries
if [ ! -n "${SAP_LIB_SAS}" ] ;then
  read -p "Please provide the SAP Bits storage SAS Token? "  sas
else
  sas="${SAP_LIB_SAS}"
fi
# This is the deployer keyvault
if [ ! -n "${SAP_KV_TF}" ] ;then
  read -p "Please provide the Deployer keyvault name? "  kv_name
else
  kv_name="${SAP_KV_TF}"
fi

az keyvault secret set --vault-name $kv_name --name "sapbits-sas-token" --value  "${sas}"
az keyvault secret set --vault-name $kv_name --name "sapbits-location-base-path" --value  "${base_path}"