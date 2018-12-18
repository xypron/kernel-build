TAG=4.18.20

MK_ARCH="${shell uname -m}"
ifneq ("armv7l", $(MK_ARCH))
	export ARCH=arm
	export CROSS_COMPILE=arm-linux-gnueabihf-
endif
undefine MK_ARCH

all: prepare build

prepare:
	test -d linux || git clone -v \
	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git \
	linux
	cd linux && git fetch
	gpg --list-keys 79BE3E4300411886 || \
	gpg --keyserver keys.gnupg.net --recv-key 79BE3E4300411886
	gpg --list-keys 38DBBDC86092693E || \
	gpg --keyserver keys.gnupg.net --recv-key 38DBBDC86092693E

build:
	cd linux && git verify-tag v$(TAG) 2>&1 | \
	grep '647F 2865 4894 E3BD 4571  99BE 38DB BDC8 6092 693E' || \
	git verify-tag v$(TAG) 2>&1 | \
	grep 'ABAF 11C6 5A29 70B1 30AB  E3C4 79BE 3E43 0041 1886'
	cd linux && git checkout v$(TAG)
	cd linux && ( git branch -D build || true )
	cd linux && git checkout -b build
	test ! -f patch/patch-$(TAG) || ( cd linux && ../patch/patch-$(TAG) )
	cd linux && make distclean
	cp config/config-$(TAG) linux/.config
	cd linux && make oldconfig
	cd linux && make bindeb-pkg

install:
	dpkg -i linux-image-$(TAG)-armmp-lpae_$(TAG)-armmp-lpae-*_armhf.deb	
