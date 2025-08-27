{ pkgs }:

pkgs.writeShellScriptBin "vm-init" ''
  #!/usr/bin/env bash
  set -euo pipefail

  VIRT_HOME=/mnt/ssd/Virtualization

  __SCRIPT_DIR="$(cd "$(dirname "$(realpath "''${0}")")" && pwd)"
  __CI_DATA_DIR="''${VIRT_HOME:-''${__SCRIPT_DIR}}/cidata"
  __IMG_DIR="''${VIRT_HOME:-''${__SCRIPT_DIR}}/img"
  __DISKS_DIR="''${VIRT_HOME:-''${__SCRIPT_DIR}}/disks"

  declare -A _SPECS=(
    [uuid]="$(uuidgen)"
    [name]=""
    [title]=""
    [img]=""
    [os]=""
    [cpu]=2
    [mem]=2048
    [diskgb]=10
  )
  declare -A _CI_DATA=(
    [user]=""
    [meta]=""
    [network]=""
  )

  __validate_deps() {
    for cmd in gum virt-install virsh; do
      if ! command -v "''${cmd}" &>/dev/null; then
        printf 'Required command not found: %s\n' "''${cmd}"
        exit 1
      fi
    done
  }

  __print-specs() {
    printf '%s,%s,%s,%s,%s,%s' \
      "''${_SPECS[title]}" \
      "$(basename "''${_SPECS[img]}" .img)" \
      "''${_SPECS[os]}" \
      "''${_SPECS[cpu]}" \
      "''${_SPECS[mem]}" \
      "''${_SPECS[diskgb]} GB" |
      gum table -c TITLE,IMG,OS,VCPU,MEM,DISK -p -b none
  }

  # NOTE: https://cloud-images.ubuntu.com/releases/
  _set-base-image() {
    local _selected
    declare -a images
    mapfile -t images < <(find "''${__IMG_DIR}" -type f -name "*.img" -exec basename {} .img \;)
    IFS=$'\n'
    _selected="$(gum filter --fuzzy --height=8 --placeholder="Select base image..." <<<"''${images[*]}")"
    IFS=' '
    _SPECS[img]="''${__IMG_DIR}/''${_selected}.img"
  }

  _set-domain-name() {
    while [ -z "''${_SPECS[title]}" ]; do
      _SPECS[title]="$(gum input --placeholder='Enter VM title...')"
    done
    _SPECS[name]="''${_SPECS[title]//[ \/]/_}"
    _SPECS[name]="''${_SPECS[name],,}"
  }

  _set-vcpu() {
    local _vcpu=""
    local _max_count=""
    _max_count="$(nproc --all)"
    while [[ ! "''${_vcpu}" =~ [1-9]+ ]] || [[ "''${_vcpu}" -gt "''${_max_count}" ]]; do
      _vcpu="$(gum input --header="CPU:" --value="''${_SPECS[cpu]}")"
    done
    _SPECS[cpu]="''${_vcpu}"
  }

  _set-memory() {
    local _mem=""
    local _max_bytes=""
    _max_bytes="$(awk '/MemTotal/ { print $2 }' /proc/meminfo | numfmt --from-unit=ki)"
    while [[ ! "''${_mem}" =~ [1-9][0-9]+ ]] || [[ "''${_mem}" -gt "''${_max_bytes}" ]]; do
      _mem="$(gum input --header="Memory (Byte):" --value="''${_SPECS[mem]}")"
    done
    _SPECS[mem]="''${_mem}"
  }

  _set-disk-size() {
    local _size=""
    while [[ ! "''${_size}" =~ ^[1-9][0-9]*$ ]]; do
      _size="$(gum input --header="Disk (GB):" --value="''${_SPECS[diskgb]}")"
    done
    _SPECS[diskgb]="''${_size}"
  }

  _set-ci-data() {
    local dist
    if grep -q ubuntu <<<"''${_SPECS[img]}"; then
      dist=ubuntu
    elif grep -q arch-linux <<<"''${_SPECS[img]}"; then
      dist=arch
    elif grep -q almalinux <<<"''${_SPECS[img]}"; then
      dist=rhel
    fi

    _CI_DATA[user]="''${__CI_DATA_DIR}/''${dist}/user-data.yml"
    _CI_DATA[meta]="''${__CI_DATA_DIR}/''${dist}/meta-data.yml"
    _CI_DATA[network]="''${__CI_DATA_DIR}/''${dist}/network-config.yml"
  }

  _set-os() {
    declare -a _oslist
    mapfile -t _oslist < <(virt-install --osinfo list | head -n-5)
    IFS=$'\n'
    _SPECS[os]="$(gum filter --fuzzy --height=8 <<<"''${_oslist[*]}" | cut -d, -f1)"
    IFS=' '
  }

  _add-domain() {
    gum spin --title="Creating..." --show-error -- \
      virt-install \
      --connect=qemu:///system \
      --import \
      --noreboot \
      --noautoconsole \
      --metadata="uuid=''${_SPECS[uuid]},title=''${_SPECS[title]}" \
      --osinfo=detect=on,name="''${_SPECS[os]}" \
      --name="''${_SPECS[name]}" \
      --vcpu="''${_SPECS[cpu]}" \
      --memory="''${_SPECS[mem]}" \
      --network=default \
      --disk=size="''${_SPECS[diskgb]}",bus=virtio,backing_store="''${_SPECS[img]}",path=/mnt/ssd/Virtualization/disks/"''${_SPECS[name]//[ \/]/_}".qcow2 \
      --cloud-init="user-data=''${_CI_DATA[user]},meta-data=''${_CI_DATA[meta]},network-config=''${_CI_DATA[network]}"
  }

  _attach-console() {
    if ! grep -q "''${_SPECS[uuid]}" < <(virsh --connect=qemu:///system list --uuid --state-running); then
      virsh --connect=qemu:///system start --domain "''${_SPECS[name]}"
    fi

    virsh --connect=qemu:///system console "''${_SPECS[name]}"
  }

  _main() {
    local _confirm
    __validate_deps

    _set-base-image
    _set-domain-name
    _set-vcpu
    _set-memory
    _set-disk-size
    _set-ci-data
    _set-os

    __print-specs
    _confirm="$(gum choose --header="Confrim:" Yes No)"
    if [ "''${_confirm,,}" = "no" ]; then
      gum log -sl error "Cancelled"
      exit 1
    fi

    _add-domain
    gum log -sl info "Successfully created libvirt domain" name "''${_SPECS[name]}"

    _confirm="$(gum choose --header="Attach to console:" Yes No)"
    if [ "''${_confirm,,}" = "no" ]; then
      exit 0
    fi

    _attach-console
  }

  _main
''
