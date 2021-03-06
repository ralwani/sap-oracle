# Application Media Preparation

## Prerequistes

1. Acquisition process complete.

## Inputs

1. SAP XML Stack file stored on user’s workstation in the Stack Download Directory;
1. SAP Media stored on user’s workstation in the Stack Download Directory;
1. SAP Library.

## Process

1. Upload the downloaded media and stack files to the sapbits container in the Storage Account for the SAP Library, using the directory structure shown in the [Example SAP Library file structure](#example-sap-library-file-structure):
   1. Open the Azure Portal;
   1. Click the Menu in the top left and select Resource Groups;
   1. Select your SAP Library Resource group, e.g. `NP-EUS2-SAP_LIBRARY`;
   1. Select the saplib StorageAccount, e.g. `npeus2saplibef9d`;
   1. Click Containers;
   1. Select the `sapbits` container.
   1. Upload the archives and tools:
      1. Click Upload;
      1. In the panel on the right, click Select a file;
      1. Navigate your workstation to your download directory;
      1. Select all Archive files (`*.SAR`, `*.RAR`, `*.ZIP`, `SAPCAR*.EXE`);
      1. Click Advanced to show the advanced options, and enter `archives` for the Upload Directory.
   1. Upload the Stack Files:
      1. Click Upload;
      1. In the panel on the right, click Select a file;
      1. Navigate your workstation to your download directory;
      1. Select all Stack files (MP_*.(xml|xls|pdf|txt));
      1. Click Advanced to show the advanced options, and enter `boms/<Stack_Version>/stackfiles` for the Upload Directory.

         _Note: `<Stack_Version>` should consist of Product type (e.g. `S4HANA`), Product Release (e.g. `2020`), Service Pack (e.g. `SP2` or `ISS` for Initial Software Shipment) and a version of the Stack (e.g. `v001`), example: `S4HANA_2020_ISS_v001`_
   1. Note that BoM `templates` are uploaded as part of the "Prepare System Template" phases later in the process.


### Example SAP Library file structure

```text
sapbits
|
|-- archives/
|   |-- igshelper_17-1001245.sar
|   |-- KE60870.SAR
|   |-- KE60871.SAR
|   |-- <id>[.SAR|.sar]
|   |-- SAPCAR_1320-80000935.EXE
|   |-- <tool>_<id>.EXE
|
|-- boms/
|   |-- S4HANA_2020_ISS_v001/
|   |   |-- bom.yml
|   |   |-- stackfiles/
|   |       |-- MP_Excel_1001034051_20200921_SWC.xls
|   |       |-- MP_Plan_1001034051_20200921_.pdf
|   |       |-- MP_Stack_1001034051_20200921_.txt
|   |       |-- MP_Stack_1001034051_20200921_.xml
|   |       |-- myDownloadBasketFiles.txt
|   |       |-- downloadBasket.json
|   |       |-- templates
|   |           |-- S4HANA_2020_ISS_v001.inifile.params
|   |
|   |-- S4HANA_2020_ISS_v001/
|       |-- bom.yml
|       |-- stackfiles
|           |-- myDownloadBasketFiles.txt
|       |-- templates
|           |-- HANA_2_00_052_v001.params
|           |-- HANA_2_00_052_v001.params.xml
|
```

**_Notes:_**

1. Additional SAP files obtained from SAP Maintenance Planner (the XML Stack file, Text file representation of stack file, the PDF and xls files) will be stored in a subfolder for a particular BoM.
1. Stack files are made unique by an index, e.g. `MP_<type>_<index>_<date>_<???>.<filetype>` where `<type>` is Stack, Plan, or Excel, `<index>` is a 10 digit integer, `<date>` is in format yyyymmdd, `<???>` is SWC for the Excel type and empty for the rest, and `<filetype>` is xls for type Excel, pdf for type Plan, and txt or xml for type Stack.
1. The text file containing the download URL hardlinks named `myDownloadBasketFiles.txt` is not unique, but specific to the BoM so should be stored in the BoM directory it relates to.

### Results and Outputs

- SAP Media has been stored in SAP Library
- SAP Library file path defined in Ansible inventory or passed in as a parameter to a playbook.

## Follow on Process

- [Application BoM Preparation](./prepare-bom.md)
