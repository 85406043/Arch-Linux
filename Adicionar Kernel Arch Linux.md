# ADICIONAR UM KERNEL NO ARCH LINUX


1 - INSTALAR O KERNEL(LINUX-LTS, LINUX-ZEN, LINUX, ETC...)

        sudo pacman -S linux-zen linux-zen-headers
    
2 - VERIFICAR SE O KERNEL FOI INSTALADO NORMALMENTE

        pacman -Q | grep linux
    
3 - CRIAR UM ARQUIVO DE CONFIGURAÇÃO EFI NO DIRETORIO:

        sudo touch /boot/loader/entries/linux-zen.conf
    
4 - CONFIGURAR O LINUX-ZEN.CONF:

        #Edite com o gedit, para mais facilidade. (sudo pacman -S gedit)

    1. ESTRUTURA DA CONFIGURAÇÃO DENTRO .CONF:
    
        title   Arch Linux LTS = como ele vai aparecer no menu de inicialização(personalizado)
        linux   /vmlinuz-linux-zen = altera de acordo com o kernel
        initrd  /initramfs-linux-zen.img = altera de acordo com o kernel
        options root=PARTUUID= aqui adiciona o id do unidade de armazenamento
        
#COPIA E COLA:
title   (Personalizado)
linux   /
initrd  /
options root=PARTUUID= 
        
    2. CONFIGURAR O LINUX E O INITRD DO ARQUIVO .CONF:
        
        Procure pelo arquivo do Kernel, na pasta /boot, exemplo:
            cd /boot/vmlinuz-linuz-zen
            cd /boot/initramfs-linuz-zen.img
            #Precisamos destes dois arquivos para configurar no .conf. Se ambos
            não estiverem instalados, revise a instalção do kernel.
            
        Se você encontrou os dois arquivos dentro de /boot, adicione-os ao lado de "linux" e 
        "initrd" no arquivo .conf, na mesma estrutura mostrada acima. Somente o 'vmlinuz' e o 
        arquivo 'img'.
    
    3. COMANDOS PARA DESCOBRIR ESSAS INFOS:
    
        INFO DA PARTIÇÃO = findmnt -no SOURCE /
        
        ID DA PARTIÇÃO = blkid /dev/info da partição 
        
        #Copie e cole somente o PARTUUID, sem aspas. E cole no arquivo .conf. Salve e saia.

5 - OPCIONAL, COLOCAR O KERNEL COMO PADRÃO:

        sudo nano /boot/loader/loader.conf

        default linux-zen.conf #Nome do arquivo, criado no /boot/loader/entries/
        timeout 3
        editor no
    
        #Esse tutorial foi feito no systemd-boot, caso for feito no grub, precisa atualizar
        a inicialização do grub.
        
            sudo grub-mkconfig -o /boot/grub/grub.cfg

#REINICIE! SE TUDO FOI FEITO COMO DEVERIA, O KERNEL VAI APARECER NA INICIALIZAÇÃO DO SYSTEMD-BOOT OU GRUB.
