patch_files=(	
    fs/exec.c	
    fs/open.c	
    fs/read_write.c	
    fs/stat.c	
)	

is_ksu=0

for i in "${patch_files[@]}"; do	
    if grep -q "ksu" "$i"; then	
        echo "Warning: $i contains KernelSU"	
            if grep -q "CONFIG_KERNELSU" "$i"; then	
                sed -i s/'CONFIG_KERNELSU'/'CONFIG_KSU'/g "$i"	
                echo "CONFIG_KERNELSU  ---->  CONFIG_KSU"	
            fi	
    fi
    is_ksu=1
done

if [ $is_ksu == "1"  ];then
   retuen
fi

if git apply --check ../KernelSU.patch ; then
   git apply ../KernelSU.patch
fi
