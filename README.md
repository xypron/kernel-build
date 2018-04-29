# Build the Linux Kernel for the Banana Pi

The configuration is based on Debian Testing with the following changes:

## Showing early boot messages

To show early boot messages the following configuration items are needed:

    CONFIG_DEBUG_LL=y
    CONFIG_DEBUG_SUNXI_UART0=y
    CONFIG_EARLY_PRINTK=y

## Compatiblity with package flash-kernel

flash-kernel checks the local version. It has to be -armmp or -armmp-lpae for
the Banana Pi:

    CONFIG_LOCALVERSION="-armmp-lpae"

## Trusted keys

The Debian trusted keys are not used:

    CONFIG_SYSTEM_TRUSTED_KEYS=""

