# Build the Linux Kernel for the Banana Pi

The configuration is based on Debian Testing. Early printk is enabled.

## Earlyprintk

To enable early printk we need the following configuration settings:

    CONFIG_DEBUG_LL=y
    CONFIG_DEBUG_SUNXI_UART0=y
    CONFIG_EARLY_PRINTK=y

