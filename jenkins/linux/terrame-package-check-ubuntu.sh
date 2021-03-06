#!/bin/bash -l

#
# TerraME - a software platform for multiple scale spatially-explicit dynamic modeling.
# Copyright (C) 2001-2017 INPE and TerraLAB/UFOP -- www.terrame.org
#
# This code is part of the TerraME framework.
# This framework is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library.
#
# The authors reassure the license terms regarding the warranties.
# They specifically disclaim any warranties, including, but not limited to,
# the implied warranties of merchantability and fitness for a particular purpose.
# The framework provided hereunder is on an "as is" basis, and the authors have no
# obligation to provide maintenance, support, updates, enhancements, or modifications.
# In no event shall INPE and TerraLAB / UFOP be held liable to any party for direct,
# indirect, special, incidental, or consequential damages arising out of the use
# of this software and its documentation.

PACKAGE=$1
DEPENDS="$2"

# Exporting terrame vars
export TME_PATH="$_TERRAME_INSTALL_PATH/bin"
export PATH=$PATH:$TME_PATH

echo ""

terrame -version

echo ""
echo "Verifing dependencies"
if [ ! -z $DEPENDS ]; then
	IFS=";" deps=($DEPENDS)
	for dep in "${deps[@]}"; do
		echo "Installing package $dep"
		terrame -color -package $dep -uninstall
		terrame -color -install $dep
		echo ""
	done
	unset IFS
fi

echo ""
echo ""

# TerraME command arguments. Used for packages like "gis", "sci", "calibration" etc.
TERRAME_COMMANDS=""
echo "Verifing packages"
if [ "$PACKAGE" != "" ] && [ "$PACKAGE" != "base" ]; then
	TERRAME_COMMANDS="-package $PACKAGE"
	if [ "$PACKAGE" != "gis" ] && [ "$PACKAGE" != "luadoc" ]; then
		terrame -color $TERRAME_COMMANDS -uninstall
	fi
fi

echo ""

echo "Executing check"
terrame -color $TERRAME_COMMANDS -check
RESULT=$?

echo ""
echo ""

exit $RESULT
