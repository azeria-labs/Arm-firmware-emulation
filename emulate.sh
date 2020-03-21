# Script to emulate Arm-based Tenda router firmware, tested on Tenda AC6 and AC15.  
# Emulation tutorial: https://https://azeria-labs.com/emulating-arm-firmware
# You can download the VM with the QEMU Armv7 emulation here: https://drive.google.com/file/d/1mWlt8XcV0-XAk8gFtTWO_48LUtUAKZj4/view?usp=sharing

# br0 interface existence is necessary for successful emulation
# You can delete this line for non-Tenda emulations
sudo ip link add br0 type dummy

# Disable ASLR for easier testing. Can be re-enabled with the same command by replacing 0 with 1 or 2.
sudo sh -c "echo 0 > /proc/sys/kernel/randomize_va_space"

# Switch to legacy memory layout. Kernel will use the legacy (2.4) layout for all processes to mimic an embedded environment which usually has old kernels
sudo sh -c "echo 1 > /proc/sys/vm/legacy_va_layout"

# Mount special linux folders to the existing Debian ARM environment to provide the emulated environment with the Linux context.
# Replace /home/user/Tenda with the path to your extracted squashfs-root. 
sudo mount --bind /proc /home/user/Tenda/squashfs-root/proc
sudo mount --bind /sys /home/user/Tenda/squashfs-root/sys
sudo mount --bind /dev /home/user/Tenda/squashfs-root/dev

# Set up an interactive shell in an encapsulated squashfs-root filesystem and trigger the startup of the firmware.
# Replace /home/user/Tenda with the path to your extracted squashfs-root. 
# For non-Tenda routers, replace this line with: sudo chroot /home/user/D-Link/squashfs-root /etc/init.d/rcS
sudo chroot /home/user/Tenda/squashfs-root /bin/sh -c "LD_PRELOAD=/hooks.so /etc_ro/init.d/rcS"
