#/usr/bin/env bash

echo "Executing"
sudo qemu-system-x86_64 \
    -name 'win10' \
    -enable-kvm \
    -nodefaults \
    -device virtio-net,addr=09.0,netdev=net0 \
    -netdev user,id=net0 \
    -drive file=virtio-win.iso,media=cdrom \
    -drive file=windows.iso,media=cdrom \
    -device vfio-pci,host=07:00.0,addr=07.0,x-vga=on,rombar=1,romfile=dump.rom,multifunction=on \
    -object input-linux,id=kbd,evdev=/dev/input/by-path/pci-0000:03:00.0-usb-0:1:1.0-event-kbd,repeat=on,grab_all=on \
    -object input-linux,id=mouse,evdev=/dev/input/by-path/pci-0000:01:00.0-usb-0:12:1.2-event-mouse,repeat=on,grab_all=on \
    -M q35 \
    -m 31000 \
    -serial stdio \
    -display none \
    -vga none \
    -drive file=windows.qcow2,if=virtio,cache=unsafe,aio=native,cache.direct=on,discard=unmap  \
    -bios /usr/share/OVMF/OVMF_CODE.fd \
    -cpu host,kvm=off,hv_vendor_id=fcknvidia \
    -smp cores=16 \

