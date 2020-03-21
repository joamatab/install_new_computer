# License types

install jupyter support

```
conda install -y nb_conda notebook ipykernel
```

Floating license youn can move it between computer
Node-locked license locks to a MAC address

```
$HOME/miniconda/envs/ipkiss3
5053@serverIP

```

# Installing your license

The installation of your floating license is a 2-step process. First you need to properly configure the license server. Second you need to properly install the license on the computers of IPKISS users within your organization that share the floating license.

## STEP 1: Configuring the license server

Download the RLM License Administration Bundle behind the following link.
Install (Windows) or extract (Linux) the RLM License Administration Bundle to a folder on the license server.
At the top of the license file (.lic) modify the line mylicenseserver.mycompany.com by the server_name.
server_name can be a hostname or the IP-address of the server. The server should be accessible by everybody that wants to check out the license.
Optionally, on the same line in the license file, modify the server port number (5053) by the port number you want to use to access the license server.
Copy the luceda.set file attached to this email to the folder where the RLM License Administration Bundle is installed. This folder contains rlm.exe (Windows) or rlm (Linux).
Copy the modified license file to the folder where the RLM License Administration Bundle is installed. This folder contains rlm.exe (Windows) or rlm (Linux).
On the license server, start the server program by running rlm.exe (Windows) or rlm (Linux).
The license server should start properly.
More detailed instructions on how to configure a floating license are described in the attached document license-server-installation-311.pdf

## STEP 2: Installing the license on user computer

Install IPKISS using the installer.
Open the Luceda Control Center.
Click on the Product License tab.
Drag and drop the modified license on the Product License window in the Luceda Control Center.
The products activated by the license will be marked as valid.

- http://www.reprisesoftware.com/admin/software-licensing-download.php
