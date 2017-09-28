#!/bin/bash

type whiptail &>/dev/null
if test $? -eq 1; then
  echo "Error, whiptail wasn't found"
  exit 1
fi

debian=0
[ -r /etc/debian_version ] && debian=1
[ -r /etc/lsb-release ] && grep -q Ubuntu /etc/lsb-release && debian=1

is_deb_release=0
ls lsb-cprocsp-base*.deb > /dev/null 2>&1 && is_deb_release=1
# install debian packages only on debian based systems
if test $is_deb_release -eq 1; then
  type dpkg 1>/dev/null 2>&1
  if test $? -ne 0; then 
    whiptail --msgbox "You are trying to install debian packages on not debian package system" 12 80 && exit 1
  fi
fi

if test $debian -eq 0; then
  pkg_list_command="rpm -qa | grep cprocsp"
  pkg_install_command="rpm -i"
else
  pkg_list_command="dpkg -l | grep cprocsp | awk '{print \$2}'"
  if test $is_deb_release -eq 1; then
    pkg_install_command="dpkg -i"
  else
    pkg_install_command="alien -kci"
  fi
fi

case `uname -m` in
x86_64|amd64)
  ARG=-64
  if test $is_deb_release -eq 1; then
    arch=amd64
  else
    arch=x86_64
  fi
  ;;
armv7l|armv7)
  arch=noarch
  ;;
ppc64)
  ARG=-64
  arch=ppc64
  ;;
ppc64le)
  ARG=-64
  arch=ppc64le
  ;;
*)
  if test $is_deb_release -eq 1; then
    arch=i386
  else
    arch=i486
  fi
  ;;
esac

version=4.0.0-4
tmpFile=`mktemp /tmp/XXXXXXXX`

packages_correct_list="lsb-cprocsp-base lsb-cprocsp-rdr lsb-cprocsp-capilite lsb-cprocsp-kc1 lsb-cprocsp-kc2 cprocsp-curl cprocsp-cpopenssl-base cprocsp-cpopenssl cprocsp-cpopenssl-gost cprocsp-rdr-gui-gtk cprocsp-rsa cprocsp-stunnel cprocsp-rdr-pcsc cprocsp-rdr-emv cprocsp-rdr-esmart cprocsp-rdr-etokgost-fkc cprocsp-rdr-gemfkc cprocsp-rdr-inpaspot cprocsp-rdr-mskey cprocsp-rdr-novacard cprocsp-rdr-rutoken cprocsp-rdr-rutoken-fkc"

get_user_base_csp_choice(){
      base_csp_choice=$(whiptail --title "Select CSP packages" --checklist \
  "Choose user's permissions" 35 85 26 \
  "cprocsp-curl" "libcurl library with GOST implementation" ON \
  "lsb-cprocsp-base" "CryptoPro base package" ON \
  "lsb-cprocsp-capilite" "CAPILite interface and binary utilities" ON \
  "lsb-cprocsp-kc1" "KC1 Cryptographic Service Provider" ON \
  "lsb-cprocsp-kc2" "KC2 Cryptographic Service Provider" OFF \
  "lsb-cprocsp-rdr" "Readers and RNG support" ON 3>&1 1>&2 2>&3)
}

get_user_additional_csp_choice(){
      other_csp_choice=$(whiptail --title "Select CSP packages" --checklist \
  "Choose user's permissions" 35 85 26 \
  "cprocsp-cpopenssl" "openssl library" OFF \
  "cprocsp-cpopenssl-base" "Base openssl package" OFF \
  "cprocsp-cpopenssl-gost" "openssl library with GOST support" OFF \
  "cprocsp-rdr-gui-gtk" "Reader GUI" OFF \
  "cprocsp-rdr-pcsc" "Readers and smartcards support (PC/SC)" OFF \
  "cprocsp-rsa" "RSA Cryptographic Service Provider" OFF \
  "cprocsp-stunnel" "SSL-tunnel with GOST support" OFF 3>&1 1>&2 2>&3)
}

get_user_rdr_choice(){
      reader_choice=$(whiptail --title "Select CSP reader packages" --checklist \
  "Choose user's permissions" 35 85 26 \
  "cprocsp-rdr-emv" "EMV/Gemalto support module" OFF \
  "cprocsp-rdr-esmart" "Esmart support module" OFF \
  "cprocsp-rdr-etokgost-fkc" "Aladdin Etoken GOST support module" OFF \
  "cprocsp-rdr-gemfkc" "Gemalto FKC support module" OFF \
  "cprocsp-rdr-inpaspot" "Inpaspot support module" OFF \
  "cprocsp-rdr-mskey" "Mskey support module" OFF \
  "cprocsp-rdr-novacard" "Novacard support module" OFF \
  "cprocsp-rdr-rutoken" "Rutoken support module" OFF \
  "cprocsp-rdr-rutoken-fkc" "Rutoken FKC support module" OFF 3>&1 1>&2 2>&3) 
}

check_selected_packages(){
  necessary_packages="lsb-cprocsp-base lsb-cprocsp-rdr lsb-cprocsp-capilite"
  if test "$choice" = "Base"; then
    for pack in $necessary_packages; do
      echo $packages_to_install | grep $pack > /dev/null
      if test $? -ne 0; then
        whiptail --msgbox "$necessary_packages must be selected" 12 80
        ret=1
      fi
    done

    echo $packages_to_install | grep "kc1\|kc2" > /dev/null
    if test $? -ne 0; then
      whiptail --msgbox "lsb-cprocsp-kc1 or lsb-cprocsp-kc2  must be selected" 12 80
      ret=1
    fi
  fi
  
  if test "$choice" = "Reader" && test "$reader_choice" != ""; then
    echo $csp_packages | grep cprocsp-rdr-pcsc > /dev/null || packages_to_install="$packages_to_install cprocsp-rdr-pcsc"
  fi
}

check_selected_packages_existence(){
  for pack in $packages_to_install; do
    if test $is_deb_release -eq 0; then
      # don't touch *base names of packages
      test $pack != "lsb-cprocsp-base" && test $pack != "cprocsp-cpopenssl-base" && pack="$pack${ARG}-$version"
    else
      test $pack != "lsb-cprocsp-base" && test $pack != "cprocsp-cpopenssl-base" && pack="$pack${ARG}_$version"
    fi
    pack_to_install=`ls | grep $pack`
    if test -z "$pack_to_install"; then
      whiptail --msgbox "$pack was not found" 12 80
      ret=1
      break
    fi
    installing_packages="$installing_packages $pack_to_install"
  done
}

csp_install() {
      if test "$csp_packages" != "0"; then
        whiptail --msgbox "Installed CSP was found, you need to uninstall CSP." 12 80
      else
        # warning for installing compat-debian package
        if test $is_deb_release -eq 1; then
          if ! dpkg -s lsb-core > /dev/null 2>&1; then
            whiptail --yesno --yes-button "Ok" --no-button "Cancel" "Warning: lsb-core package not installed - installing cprocsp-compat-debian.\nIf you prefer to install system lsb-core package then\n * uninstall CryptoPro CSP\n * install lsb-core manually\n * install CryptoPro CSP again" 12 80
            test $? -ne 0 && exit 1
            dpkg -i cprocsp-compat-debian_1.0.0-1_all.deb
            if test $? -ne 0; then
              whiptail --msgbox "Error while installing cprocsp-compat-debian_1.0.0-1_all.deb" 12 80 && exit 1
            fi
          fi
        fi

        whiptail --yesno "Do you want to choose installed CSP packages?" --yes-button "Yes" --no-button "No, automatically install" 8 90
        ret=$?
        install_status=0
        if test $ret -ne 0; then
          ./install.sh 2>$tmpFile 
          ret=$?
          if test $ret -eq 0; then
            whiptail --msgbox "CSP was installed successfully" 12 80
            csp_packages=`eval "$pkg_list_command"`
          else
            error=`cat "$tmpFile"`
            whiptail --msgbox "Error installing CSP\n$error" 12 80
          fi
          install_status=1
        fi

	while test $install_status -eq 0; do
          packages_choice=""
          base_csp_choice=""
          other_csp_choice=""
          reader_choice=""
          installing_packages=""
          ret=0
          > $tmpFile
          choice=$(whiptail --title "CSP install menu" --menu "Choose an option" 20 78 10 \
"Base" "install base CSP packages" \
"Other" "install other CSP packages" \
"Reader" "install reader CSP packages" 3>&1 1>&2 2>&3)

          install_status=$?
          if test $install_status -ne 0; then
            break
          fi

          case "$choice" in
            "Base") get_user_base_csp_choice;;
            "Other") get_user_additional_csp_choice;;
            "Reader") get_user_rdr_choice;;
          esac

          if test $? -eq 0; then        
            packages_choice="$base_csp_choice $other_csp_choice $reader_choice"
            packages_to_install=`echo $packages_choice | sed 's/"//g'`
            check_selected_packages
            if test $ret -eq 0; then             
              check_selected_packages_existence
            fi
	  
            if test "$installing_packages" = ""; then
               echo "No packages to install" > $tmpFile
               ret=1
            else
              echo "Installing CSP..."
            fi
            
            if test $ret -eq 0; then 
              for pack in $packages_correct_list; do
                if test $is_deb_release -eq 1; then
                  pack="$pack${ARG}_${version}_$arch.deb"
                  # process *base packages separately
                  echo $pack | grep lsb-cprocsp-base && pack="lsb-cprocsp-base_${version}_all.deb" 
                  echo $pack | grep cprocsp-cpopenssl-base && pack="cprocsp-cpopenssl-base_${version}_all.deb"
                else
                  pack="$pack${ARG}-$version.$arch.rpm" 
                  # process *base packages separately
                  echo $pack | grep lsb-cprocsp-base && pack="lsb-cprocsp-base-$version.noarch.rpm"
                  echo $pack | grep cprocsp-cpopenssl-base && pack="cprocsp-cpopenssl-base-${version}.noarch.rpm"
                fi
                echo $installing_packages | grep $pack > /dev/null
                if test $? -eq 0; then
                  $pkg_install_command $pack 2>$tmpFile  
                  if test $? -ne 0; then
                    ret=1
                    break;
                  fi
                fi
              done 
            fi

            if test $ret -eq 0; then
              whiptail --msgbox "CSP was installed successfully" 12 80
              echo "Updating package information..."
              csp_packages=`eval "$pkg_list_command"`
            else
              error=`cat "$tmpFile"`
              whiptail --msgbox "Error installing CSP\n$error" 12 80
            fi
          fi
        done
      fi
}

process_license(){
  license_status=0

  while test $license_status -eq 0; do
    choice=$(whiptail --title "License menu" --menu "Choose an option" 20 78 10 \
"Input" "input license serial number" \
"Check" "view license" 3>&1 1>&2 2>&3)
    license_status=$?

    if test "$choice" = "Check"; then
      if test "$arch" = "x86_64" || test "$arch" = "amd64"; then
        license=`/opt/cprocsp/sbin/amd64/cpconfig -license -view 2>&1`
      else
        license=`/opt/cprocsp/sbin/ia32/cpconfig -license -view 2>&1`
      fi 

      if test $? -eq 0; then
        whiptail --msgbox "Check license successfull\n$license" 12 80
      else 
        whiptail --msgbox "Check license error\n$license" 12 80
      fi
    fi

    if test "$choice" = "Input"; then
      license_number=$(whiptail --inputbox "input license" 10 78 --title "CSP license" 3>&1 1>&2 2>&3)

      ret=$?
      if test $ret -eq 0; then
        if test "$arch" = "x86_64" || test "$arch" = "amd64"; then
          license=`/opt/cprocsp/sbin/amd64/cpconfig -license -set $license_number 2>&1`
        else
          license=`/opt/cprocsp/sbin/ia32/cpconfig -license -set $license_number2>&1`
        fi
        
        if test $? -eq 0; then
          whiptail --msgbox "License was set\n$license" 12 80
        else
          whiptail --msgbox "Error setting license\n$license" 12 80
        fi
      fi  
    fi

  done
}

exitstatus=0
while test $exitstatus -eq 0; do
  choice=$(whiptail --title "Menu" --menu "Choose an option" 20 78 10 \
"Install" "install CSP packages" \
"Uninstall" "uninstall CSP packages" \
"Check" "check installed CSP" \
"License" "input or check license" 3>&1 1>&2 2>&3)

  exitstatus=$?
  
  if test "$choice" = "Check" || test "$choice" = "Install"; then 
    if test -z "$csp_packages"; then
      echo "Reading package database..."
      csp_packages=`eval "$pkg_list_command"`
      if test -z "$csp_packages"; then
        csp_packages=0;
      fi
    fi
  fi
     
  if test "$choice" = "Check"; then
    if test "$csp_packages" != "0"; then
      tmp_text="Followed CSP packages are installed:\n$csp_packages"
    else
      tmp_text="CSP is not installed"
    fi
    tmp_msgbox=`echo $tmp_text`
    whiptail --msgbox "$tmp_msgbox" 25 95
  fi

  if test "$choice" = "Install"; then
    csp_install
  fi

  if test "$choice" = "Uninstall"; then
    if (whiptail --title "Uninstalling CSP" --yesno "Are you sure to delete CSP?" 8 78) then
      echo "Uninstalling CSP..."
      ./uninstall.sh 2>$tmpFile
      if test $? -eq 0; then 
        whiptail --msgbox "CSP was deleted successfully" 12 80   
        csp_packages="0"
      else
        error=`cat "$tmpFile"`
        whiptail --msgbox "Error deleting CSP\n$error" 12 80
      fi
    fi
  fi

  if test "$choice" = "License"; then
    process_license
  fi

done

rm -f $tmpFile
