#!/bin/sh
echo -e "THIS WILL REMOVE ANY OLD XEMU INSTALLATIONS IN THIS CURRENT DIRECTORY!\n"
echo -e "What flavor of Linux do you run?\n 1. Debian/Ubuntu\n 2. Arch/Manjaro\n 3. Fedora\n 4. MacOS (Homebrew)\n Q. Quit\n\n"
read flavor

if [ $flavor == 1 ] ;
then
	# Remove the old xemu installation
	rm -rf ./xemu/
	# Make sure packages are installed / up-to-date.
	echo "Updating your packages... awaiting password input.\n"
	sudo apt update
	sudo apt install git build-essential libsdl2-dev libepoxy-dev libpixman-1-dev libgtk-3-dev libssl-dev libsamplerate0-dev libpcap-dev ninja-build

	# Clone the repository and build the program.
	git clone --recurse-submodules https://github.com/mborgerson/xemu.git
	cd xemu/
	./build.sh

	# 
	sudo cp ./dist/xemu /usr/bin/

	# Let the user know the build is complete.
	echo "Building is completed!  Type \"xemu\" to run the build executable.\n"
	exit 0

elif [ $flavor == 2 ] ;
then
	# Remove the old xemu installation
        rm -rf ./xemu/

	# Make sure packages are installed / up-to-date.
        echo "Updating your packages... awaiting password input.\n"
        sudo pacman -Syu --noconfirm git base-devel sdl2 libepoxy pixman gtk3 openssl libsamplerate libpcap ninja glu

        # Clone the repository and build the program.
        git clone --recurse-submodules https://github.com/mborgerson/xemu.git
        cd ./xemu/
        ./build.sh

	sudo cp ./dist/xemu /usr/bin/

        # Let the user know the build is complete.
        echo "Building is completed!  Type \"xemu\" to run the build executable\n"
	exit 0

elif [ $flavor == 3 ] ;
then
	# Remove the old xemu installation
        rm -rf ./xemu/

	# Make sure packages are installed / up-to-date.
        echo "Updating your packages... awaiting password input.\n"
        sudo dnf install libdrm-devel libslirp-devel mesa-libGLU-devel gtk3-devel libpcap-devel libsamplerate-devel libaio-devel SDL2-devel libepoxy-devel pixman-devel gcc-c++ ninja-build openssl-devel

        # Clone the repository and build the program.
        git clone --recurse-submodules https://github.com/mborgerson/xemu.git
        cd xemu/
        ./build.sh

	sudo cp ./dist/xemu /usr/bin/

        # Let the user know the build is complete.
        echo "Building is completed!  Type \"xemu\" to run the build executable\n"
	exit 0
elif [ $flavor == 4 ] ;
then
	# Install dependencies
	echo "Please ensure that you have installed homebrew prior to this installation."

	brew update
	brew install coreutils pkg-config dylibbundler ninja
	python3 -m pip install pyyaml

	# Clone and build
	git clone --recurse-submodules https://github.com/mborgerson/xemu.git
	cd xemu
	./build.sh

	# Run
	open ./dist/xemu.app

   	exit 0
elif [ $flavor == 'Q' ] || [ $flavor == 'q' ]
then
	exit 0

else
	echo "Invalid choice!  Pick from the provided!  1, 2, 3, or Q.\n"
	exit 1
fi

# TODO! #
# Make custom CFLAGS and such possible
# Add MacOS support through brew - DONE
# Keep this up to date for a while'
# Add a "real" warning screen about brew for MacOS
# Something else?


# NOTES #
# I did not make xemu, it is not my software, XBOX is Microsoft's thing
# I will NOT add building for Windows through WSL, or Windows itself to this 
# program.  If you have something you'd like to add to the program, feel 
# free to make a PR if you feel so moved to.  I *would* reccomend making
# the build yourself, but some people need the extra push to compile 
# if they've never had the experience, this is for them.  
# 
# Happy development! :D