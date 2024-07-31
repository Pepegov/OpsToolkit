# LVM

Logical Volume Manager (LVM) is a disk space management technology used in Linux-based operating systems. It allows for the creation and management of logical volumes that can be dynamically resized, unlike traditional partitions.

### Key Components of LVM:
- **Physical Volumes (PV)**: Physical disks or partitions that can be combined into a single group.
- **Volume Groups (VG)**: Groups of physical volumes from which logical volumes are allocated.
- **Logical Volumes (LV)**: Logical volumes created from the space in a volume group and can be formatted as file systems.

### Advantages of LVM:
- **Flexibility**: Allows resizing volumes, adding new physical disks to the volume group, and redistributing space without system downtime.
- **Manageability**: Simplifies disk space management, especially in complex configurations.
- **Snapshots**: Ability to create point-in-time copies of volumes for backup or testing.

LVM is used to enhance the flexibility and ease of disk space management, which is especially useful in environments with changing storage requirements.

---

## Installing and Setting Up LVM:
1. Install the LVM2 package:
    ```bash
    sudo apt-get install lvm2
    ```
2. Create a physical volume (PV):
    ```bash
    sudo pvcreate /dev/sdb
    ```
3. Create a volume group (VG):
    ```bash
    sudo vgcreate vg_name /dev/sdb
    ```
4. Create a logical volume (LV):
    ```bash
    sudo lvcreate -n lv_name -L 10G vg_name
    ```
5. Format the logical volume and mount it:
    ```bash
    sudo mkfs.ext4 /dev/vg_name/lv_name
    sudo mount /dev/vg_name/lv_name /mnt
    ```

---

## Data Migration and Volume Expansion:
1. Add a new PV to the VG:
    ```bash
    sudo vgextend vg_name /dev/sdc
    ```
2. Move data from one PV to another:
    ```bash
    sudo pvmove /dev/sdb /dev/sdc
    ```
3. Remove the old PV from the VG:
    ```bash
    sudo vgreduce vg_name /dev/sdb
    ```

## Snapshots:
Snapshots allow you to create copies of the logical volume's state at a specific point in time. This is useful for backups or testing.
1. Create a snapshot:
    ```bash
    sudo lvcreate --size 1G --snapshot --name snapshot_name /dev/vg_name/lv_name
    ```
2. Mount the snapshot for verification:
    ```bash
    sudo mount /dev/vg_name/snapshot_name /mnt/snapshot
    ```

---

## System Layout:

### Creating a Volume Group
```bash
vgcreate ws /dev/sdX
```

It is advisable to move directories such as /usr, /var, /tmp, and /home out of the root partition to avoid defragmenting the root partition and to prevent it from filling up. Therefore, create the following volumes:
```bash
lvcreate -n usr -L10G ws  # Here we create a volume named "usr" with a size of 10Gb
lvcreate -n var -L20G ws
lvcreate -n tmp -L2G ws
lvcreate -n home -L100G ws
lvcreate -n swap -L10G ws
```
It is better to leave some free space in the volume group (for example, for a future backup partition). To see how much space is available, use:
```bash
vgdisplay
```
To view information about the created logical volumes:
```bash
lvdisplay
```
To view information about the physical volumes:
```bash
pvdisplay
```

## Formatting

```bash
mkfs.ext2 -L tmp /dev/ws/tmp
mkfs.ext4 -L usr /dev/ws/usr
mkfs.ext4 -L var /dev/ws/var
mkfs.ext4 -L home /dev/ws/home
```

If a swap partition was created:
```bash
mkswap -L swap /dev/ws/swap
swapon /dev/ws/swap
```

## Extending LVM Volumes:

1. Check the Current LVM Status:
    - Command to view volume group (VG) information:
        ```bash
        sudo vgdisplay vg_name
        ```

2. Extend the Volume Group (VG):
    - Add a new physical volume (PV) to the VG:
        ```bash
        sudo pvcreate /dev/sdX
        sudo vgextend vg_name /dev/sdX
        ```
3. Extend the Logical Volume (LV):
    - Command to increase the size of the LV:
        ```bash
        sudo lvextend -L +size /dev/vg_name/lv_name
        ```
    - Example: Increase by 10G:
        ```bash
        sudo lvextend -L +10G /dev/vg_name/lv_name
        ```
4. Update the File System:
    - For ext4 and ext3 file systems:
        ```bash
        sudo resize2fs /dev/vg_name/lv_name
        ```
    - For the XFS file system:
        ```bash
        sudo xfs_growfs /mount/point
        ```
5. Verify the Changes:
    - Ensure the volume is successfully extended:
        ```bash
        df -h /mount/point
        ```

## Command Examples:
- Create a new PV:
    ```bash
    sudo pvcreate /dev/sdX
    ```
- Extend the VG:
    ```bash
    sudo vgextend vg_name /dev/sdX
    ```
- Extend the LV:
    ```bash
    sudo lvextend -L +10G /dev/vg_name/lv_name
    ```
- Update the file system:
    ```bash
    sudo resize2fs /dev/vg_name/lv_name
    sudo xfs_growfs /mount/point
    ```

## Important Notes:
    /boot partition should be outside of LVM as GRUB does not support booting from LVM volumes.

