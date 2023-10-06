#!/usr/bin/env zsh
# Name: Update-AppIcons
# Deps: fileicon

# Set default values for environment variables if not provided
ENABLE_APP_ICONS=${ENABLE_APP_ICONS:-true}
CUSTOM_ICONS_DIR=${CUSTOM_ICONS_DIR:-"$(dirname "$0")/Icons"}
APP_SEARCH_PATH=${APP_SEARCH_PATH:-"/Applications:/Users/$(whoami)/Applications"}

# Create the `mdfind` command arguments
# Run `mdfind` and store results in app_bundles
declare -a mdfind_args=("-onlyin" "${(@s/:/)APP_SEARCH_PATH}")
declare -a app_bundles=("${(@f)$(/usr/bin/mdfind "kMDItemContentType == 'com.apple.application-bundle'" "${mdfind_args[@]}")}")

# Function to test if an app has a custom icon
function test_custom_icon {
	local app=$1
	$(brew --prefix)/bin/fileicon test "$app" &> /dev/null
	local fileicon_exit_code=$?
	return $fileicon_exit_code
}

# Function to apply a custom icon to an app
function apply_custom_icon {
	local app=$1
	local icon=$2
	$(brew --prefix)/bin/fileicon set "$app" "$icon" &> /dev/null
	local fileicon_exit_code=$?
	return $fileicon_exit_code
}

# Function to remove a custom icon from an app
function remove_custom_icon {
	local app=$1
	$(brew --prefix)/bin/fileicon rm "$app" &> /dev/null
	local fileicon_exit_code=$?
	return $fileicon_exit_code
}

# Iterate through app bundles
for app in "${app_bundles[@]}"; do

	# Check if bundle has a custom icon
	if test_custom_icon "$app"; then

		# If a custom icon has already been applied and
		# `ENABLE_APP_ICONS` is disabled, remove the icon
		if [ "$ENABLE_APP_ICONS" = "false" ]; then
			remove_custom_icon "$app"
		fi

	else

		# Apply custom icon if feature enabled
		if [ "$ENABLE_APP_ICONS" = "true" ]; then
			declare bundle_name=$(basename "$app" | cut -f 1 -d '.')
			# Check for icons in custom icon directory
			if [ -f "$CUSTOM_ICONS_DIR/$bundle_name.png" ]; then
				apply_custom_icon "$app" "$CUSTOM_ICONS_DIR/$bundle_name.png"
			elif [ -f "$CUSTOM_ICONS_DIR/$bundle_name.icns" ]; then
				apply_custom_icon "$app" "$CUSTOM_ICONS_DIR/$bundle_name.icns"
			fi
		fi

	fi
done

exit 0
