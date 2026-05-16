#!/bin/bash

echo "Begin shrinking package..."
target="$(dirname $0)/target/datax"
[ -d ${target} ] || exit 1
[ -d ${target}/datax ] || exit 2

cd ${target}/datax || exit 3
# should be in target/datax/datax
[ -d shared ] || mkdir shared

for jar in $(find  plugin/*/*/libs -type f -name *.jar)
do
    plugin_dir=$(dirname $jar)
    file_name=$(basename $jar)
    # 1. move it to shared folder
    /bin/mv -f ${jar} shared/
    # 2. create symbol link
    ( cd ${plugin_dir} && ln -sf ../../../../shared/${file_name} $file_name )
done

cd -

  # create archive package
cd ${target}
echo "Create archived package"
tar -czf "datax.tar.gz" datax/
echo "The archive package is at: ${target}/datax.tar.gz"

exit $?

