# Warning! Not to be used by blindly copy-pasting

# obtain the NixOS guest IP
ifconfig


# connect to NixOS guest with password auth
ssh \
    -o "UserKnownHostsFile=/dev/null" \
    -o "StrictHostKeyChecking=no" \
    root@192.168.122.68


# enter interactive program for partitioning
cgdisk /dev/sda


# apply file systems and mount the partitions
mkfs.ext4 /dev/disk/by-partlabel/root
mount /dev/disk/by-partlabel/root /mnt

mkfs.fat /dev/disk/by-partlabel/uefi
mkdir /mnt/boot
mount /dev/disk/by-partlabel/uefi /mnt/boot

mkswap /dev/disk/by-partlabel/swap
swapon /dev/disk/by-partlabel/swap


# generate `configuration.nix` and `hardware-configuration.nix`
nixos-generate-config --root /mnt


# generate ssh keypair
ssh-keygen \
    -q \
    -N "" \
    -t ed25519 \
    -f ~/.ssh/id_ed25519_for_nixos


# edit the file with nano text editor
nano /mnt/etc/nixos/configuration.nix


# install NixOS
nixos-install


# reboot the system
reboot


# connect to NixOS guest with public key authentication
ssh theNameOfTheUser@192.168.122.68 -i ~/.ssh/id_ed25519_for_nixos


# optionally switch to superuser
sudo su


# edit the file with nano text editor (as superuser)
sudo nano /etc/nixos/configuration.nix


# rebuilt NixOS configuration and let the changes take effect (as superuser)
sudo nixos-rebuild switch
