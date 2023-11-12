# Optimism Local Devnet in VM

This is a quick guide on how to setup your own local Optimism devnet. In order to run the Optimism ecosystem several tools are required like:
- docker
- geth
- foundry
- nodejs
- pnpm

If you follow this guide, you end up with a virtual machine that contains the whole devnet and exposes the RPC ports of the chains to your host machine. This allows you to interact with the devnet from your host machine.

## Prerequisites
 
#### 1. QEMU and KVM

Assuming you have a virtualizable system (most are nowadays) you can install QEMU with the following commands:
```bash
sudo apt update
sudo apt install qemu-kvm virt-manager virtinst libvirt-clients bridge-utils libvirt-daemon-system -y
```

Next we start the libvirt virtualization daemon:
```bash
sudo systemctl enable --now libvirtd
sudo systemctl start libvirtd
```

Lastly, add the user to the kvm and libvirt groups:
```bash
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER
```

For a more complete installation guide, see [here](https://www.tecmint.com/install-qemu-kvm-ubuntu-create-virtual-machines/).

#### 2. Start the devnet

Now you have two options: you can either use a prebuilt VM that contains all the necessary components or you can build the VM yourself. The prebuilt VM is the easiest option, but it is also the least flexible and might not have the most up-to-date version of the devnet. If you want to customize the devnet, you should build the VM yourself.

##### Option 1: Use a prebuilt VM

Download the prebuit VM [here](https://polybox.ethz.ch/index.php/s/7ispNzwvvpJqTqv). The password for the download is sandbox. Once downloaded you have a file called devnet.qcow2. This is the VM image that contains a light weight Ubuntu server and all the necessary components of the Optimism ecosystem.

To start the VM run the bash script `start_devnet` that is provided in this repository:
```bash
start_devnet devnet
```
The VM runs with 8GB of RAM and 4 CPUs but depending on your host machine you can change these values in the bash script.

And that's it! You now have a running devnet. You can ssh into the VM using the following command: `ssh sandbox@127.0.0.1 -p 10022`. Password is `sandbox`.

Further you can connect to the Ethereum chain and Optimism chain through the following RPC ports:

| Chain | RPC Port |
|-------|----------|
| L1    | 8545     |
| L2    | 9545     |


##### Option 2: Build the VM yourself

First, let's create a base disk image that we will base our devnet VM on. This can be done with the following command:
```bash
qemu-img create -f qcow2 base_vm.qcow2 80G
```

Next, we will download the Ubuntu server image. You can also choose a different distribution however this guide is tailored for Ubuntu. Once we have the iso file downloaded, we can start the installation process with the following command:
```bash
qemu-system-x86_64 -hda base_vm.qcow2 -cdrom ~/Downloads/ubuntu-22.04.2-live-server-amd64.iso -m 8192
```
I recommend setting up a user with the username `sandbox` and password `sandbox` so that the scripts in this repositiory remain compatible.

Now we have Ubuntu installed on the disk image. Let's now create a new fesh VM that contains the Optimism devnet. 

Run the script `create_devnet` that is provided in this repository which will install all the required dependencies. The first argument is our base disk image and the second argument is the name of the new VM:
```bash
create_devnet base_vm devnet
```

Congrats! We have just created our own running devnet.