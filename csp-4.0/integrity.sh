#!/bin/sh
cd `dirname $0`
./cpverify cprocsp-compat-debian_1.0.0-1_all.deb 68B47998956EA1A343865FC6460706A3801CA0E6B140087EF32F59D1AF0FACD7
test $? -eq 0 || exit 1
./cpverify cprocsp-cpopenssl-64_4.0.0-4_amd64.deb 34AEE933E5CDFC9C95734ED08398F7D5BFAD6C7E7958C18782BE5B8C9FA587B7
test $? -eq 0 || exit 1
./cpverify cprocsp-cpopenssl-base_4.0.0-4_all.deb 8DC8D38735A41C0A81622202751DB6B51241EC83B358813BAFD34FC9519F9054
test $? -eq 0 || exit 1
./cpverify cprocsp-cpopenssl-devel_4.0.0-4_all.deb 9771E1AB171246DFB4FAD0F74E45CA963FBED861CFCC0A4AF9A31D2B371A47DD
test $? -eq 0 || exit 1
./cpverify cprocsp-cpopenssl-gost-64_4.0.0-4_amd64.deb D1E563AFD344E15C912A1901331BEDEB9C779F3D7D81E61D919A8824C887FA6E
test $? -eq 0 || exit 1
./cpverify cprocsp-curl-64_4.0.0-4_amd64.deb 590CE69B0E940CE5C3502CA9AE463F67E6A4B76282E0B4628C0020B8EA2D2221
test $? -eq 0 || exit 1
./cpverify cprocsp-drv-64-dummy_4.0.0-4_amd64.deb C7FE7DADA6C8DB52680F2070B43B3E57375D4E55071E2400B5E2CDCD3DBA29DD
test $? -eq 0 || exit 1
./cpverify cprocsp-drv-devel_4.0.0-4_all.deb 5F3D670C98E56C24621505778ED6433D79375960812DCA73B5BBA51F057D8BC7
test $? -eq 0 || exit 1
./cpverify cprocsp-ipsec-devel_4.0.0-4_all.deb 592722BD6F0A861018F7862F204E04C4914BDADAF5626C531ACEFEAF5E204590
test $? -eq 0 || exit 1
./cpverify cprocsp-ipsec-esp-64-dummy_4.0.0-4_amd64.deb 61C190741E5DAC14BF84351859D994126EB410FCE3BE059D332BA509A99C8918
test $? -eq 0 || exit 1
./cpverify cprocsp-ipsec-genpsk-64_4.0.0-4_amd64.deb 448C7B841773DC5038EB6FD2C3D98A86D71A1E7E1F003432332F5E821BBD3F51
test $? -eq 0 || exit 1
./cpverify cprocsp-ipsec-ike-64_4.0.0-4_amd64.deb 269FDE941C69A1A09D75465ABF3AC826B63D3CC164E7134C44ED792A220CE17D
test $? -eq 0 || exit 1
./cpverify cprocsp-rdr-emv-64_4.0.0-4_amd64.deb 11CBD2C12B5A00F664A5D50B4BB4006B5983B625B668EA4CF90AC9072A40DC91
test $? -eq 0 || exit 1
./cpverify cprocsp-rdr-esmart-64_4.0.0-4_amd64.deb 5D6CD51E7DFBC90EE9E123FAE34CB96B24241E58A9FE2836758A25DE49EFC7C4
test $? -eq 0 || exit 1
./cpverify cprocsp-rdr-gui-64_4.0.0-4_amd64.deb A8F5117864989A75A66D1ADBD7A84F8F8F10378468690B76EFE8BD1F9EE70BE0
test $? -eq 0 || exit 1
./cpverify cprocsp-rdr-gui-gtk-64_4.0.0-4_amd64.deb ECF4EE03A51358D36EDEBE1EDAC74A66ED05E8B90FF978FCE5AD9546A3351442
test $? -eq 0 || exit 1
./cpverify cprocsp-rdr-inpaspot-64_4.0.0-4_amd64.deb 88B587C4F15254FB47026B3F807E1A4EE8F18881AB049D7B82071C54B7C440C8
test $? -eq 0 || exit 1
./cpverify cprocsp-rdr-mskey-64_4.0.0-4_amd64.deb 9A05947EF86C5ED7EACD80AE9D98119C6EDF6472B06245873334761211C71058
test $? -eq 0 || exit 1
./cpverify cprocsp-rdr-novacard-64_4.0.0-4_amd64.deb E2083A53AD048525005C366675A2B9F649D6F6BBEC4263377E0151C68E2DA117
test $? -eq 0 || exit 1
./cpverify cprocsp-rdr-pcsc-64_4.0.0-4_amd64.deb 2A75BDF3B48FC991EECD81AD5D03B00AA00048F098DC3C39D7AEA4F301989EF1
test $? -eq 0 || exit 1
./cpverify cprocsp-rdr-rutoken-64_4.0.0-4_amd64.deb 730435673BE101F7D3ECFA490850EAAEA14EF3BC43CCA439BC56B1BE1BE92B63
test $? -eq 0 || exit 1
./cpverify cprocsp-rsa-64_4.0.0-4_amd64.deb F639CD9901390A928E4044CD5D1468F662CE8A0639B9622107AA6479BF994465
test $? -eq 0 || exit 1
./cpverify cprocsp-stunnel-64_4.0.0-4_amd64.deb 530D260634F00933BF57B5C3490D4D0CDC4A675EBACCB1A196C7648B74B6BD23
test $? -eq 0 || exit 1
./cpverify cprocsp-xer2print_4.0.0-4_all.deb 08D6F230B4A600752BD4BDA7C0E748B60A17E84BD6DEB73F02CE85CEF365B275
test $? -eq 0 || exit 1
./cpverify cpverify 94289F75F58FB78405FDC73BB213B3B83A8F283875945CFF7E16ED84E01FDDA2
test $? -eq 0 || exit 1
./cpverify ifd-rutokens_1.0.1_amd64.deb F332EE350CDA6850CE0DF707F1F8403D3F9B8577F14CBF14AAC3C75D0DF1A0E3
test $? -eq 0 || exit 1
./cpverify install_gui.sh C2F5109568F764FB0B6C872D5B35C2D7F2DFA693903C0C6045323CAE8C7E00DC
test $? -eq 0 || exit 1
./cpverify install.sh 98BB79112BE91D234367C7644686F794292177D4F17D2622D2C9195C137B1648
test $? -eq 0 || exit 1
./cpverify linux-amd64.ini 4C21863D264D773FA085AA948692DBCF7DE4F658F2B4896F2186870365D3283B
test $? -eq 0 || exit 1
./cpverify lsb-cprocsp-base_4.0.0-4_all.deb 9DE466EE18DB85FBB8B88FC390F88EAE5CDA2F13F0ADA55F29A425CF6EF7B0DF
test $? -eq 0 || exit 1
./cpverify lsb-cprocsp-capilite-64_4.0.0-4_amd64.deb 03429FA7F4C6D802D0892965F495878A8EAF94EDC6080C5584E8F8FACEBBD8E5
test $? -eq 0 || exit 1
./cpverify lsb-cprocsp-devel_4.0.0-4_all.deb 8D26DBC7814B771ABE514EA961073DCD735A87127F4D01A7285A3E4DB69127B7
test $? -eq 0 || exit 1
./cpverify lsb-cprocsp-kc1-64_4.0.0-4_amd64.deb 36E66446388120D3CCA9EA0EF59C96222D1A41B233D5CCFB6E81D298431AE2E8
test $? -eq 0 || exit 1
./cpverify lsb-cprocsp-kc2-64_4.0.0-4_amd64.deb 240B3077F75EC7BDB7BF53CEF96995BA54F28490A2339561CE98127A25BD79F1
test $? -eq 0 || exit 1
./cpverify lsb-cprocsp-pkcs11-64_4.0.0-4_amd64.deb EDF09B27859E2028EEC06DE2A17E4F5A712E5352FB694EF2CB660090C99E7633
test $? -eq 0 || exit 1
./cpverify lsb-cprocsp-rdr-64_4.0.0-4_amd64.deb 07B37CC368165D14C912AC2D87687571F972AAF1D03778A12CC070AAC5F447EC
test $? -eq 0 || exit 1
./cpverify lsb-cprocsp-rdr-accord-64_4.0.0-4_amd64.deb 5A5503D6A9D00279DAD46E60081F1F59D649137175FE743114F6A2DA7845B017
test $? -eq 0 || exit 1
./cpverify lsb-cprocsp-rdr-sobol-64_4.0.0-4_amd64.deb C737B48B525CF234A2C522AD40315A3E89828560EEAD1DC3089C7EE011E4D82F
test $? -eq 0 || exit 1
./cpverify uninstall.sh 2A4515BE5CE7FB7AF3B50D03F56EB7171AFE8B7C60F5A7B0AC8FF5E04A0B87A0
test $? -eq 0 || exit 1
printf "Everything is OK.\n"
