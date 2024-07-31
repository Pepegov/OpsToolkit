## Disk Encryption. cryptsetup

The command syntax is as follows:
```bash
$ cryptsetup options operation operation_parameters
```

Let's look at the main operations you can perform with this utility:
- luksFormat - create a LUKS-encrypted Linux partition;
- luksOpen - open a virtual device (requires a key);
- luksClose - close a LUKS-encrypted virtual device;
- luksAddKey - add an encryption key;
- luksRemoveKey - remove an encryption key;
- luksUUID - display the partition's UUID;
- luksDump - create a backup of LUKS headers.

Creating an Encrypted Partition:
```bash
sudo cryptsetup -y -v luksFormat /dev/sdb1
```

This command initializes the partition, sets the initialization key, and prompts for a password. First, you must confirm the creation of the virtual encrypted disk by typing YES, and then specify the password.

Opening an Encrypted Partition:
```bash
sudo cryptsetup luksOpen /dev/sdb1 <your_partition_name (e.g., crptblk)>
```

You can now mount the encrypted partition. It is located at /dev/mapper/<your_partition_name>. For example:
```bash
sudo mount /dev/mapper/crptblk /mnt/cryptblk
```

You can check the status of the encrypted device with:
```bash
sudo cryptsetup -v status cryptblk
```

Closing the Partition:
```bash
sudo cryptsetup luksClose cryptblk
```

#### Changing the Password

It's a good idea to first back up the LUKS headers:
```bash
sudo cryptsetup luksDump /dev/sdb1
```

Create a new key (you will need to enter it twice):
```bash
sudo cryptsetup luksAddKey /dev/sdb1
```

Remove the old password (you will need to enter the old password):
```bash
sudo cryptsetup luksRemoveKey /dev/sdb1
```

Note: LUKS supports encryption with up to eight passwords.