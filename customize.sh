array=$(find /system /vendor -name WCNSS_qcom_cfg.ini)
for CFG in $array
do
[[ -f $CFG ]] && [[ ! -L $CFG ]] && {
SELECTPATH=$CFG
mkdir -p `dirname $MODPATH$CFG`
ui_print "- Migrating $CFG"
[[ -f /sbin/.magisk/mirror$SELECTPATH ]] && cp -af /sbin/.magisk/mirror$SELECTPATH $MODPATH$SELECTPATH || cp -af $SELECTPATH $MODPATH$SELECTPATH
ui_print "- Starting modifiy"
sed -i '/gRegulatoryChangeCountry=0/d;/gCountryCodePriority=1/d;s/^END$/gRegulatoryChangeCountry=1\ngCountryCodePriority=0\nEND/g' $MODPATH$SELECTPATH
}
done
[[ -z $SELECTPATH ]] && abort "- Installation FAILED. Your device didn't support WCNSS_qcom_cfg.ini." || { mkdir -p $MODPATH/system; mv -f $MODPATH/vendor $MODPATH/system/vendor;}
