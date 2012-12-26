#!/usr/bin/ruby

# By Erik Wrenholt 2012

require 'digest/md5'

# This script will set the terminal color based on the host name when ssh-ing to a server
# using the form "ssh user@host" or "ssh host". If you want to use other ssh flags, you'll
# have to use the full path /usr/bin/ssh instead.

# Installation

#	To install, place this script anywhere and make it executable with "chmod +x color_ssh.rb".
#	Then place this in your ~/.profile
#		alias ssh="/path/to/color_ssh.rb"

# Config

# When the ssh session ends, the color is returned to your default theme. 
# You can specify another theme name here if you want.
DEFAULT_THEME = "Basic"

# If you prefer to use white text on black, set this to false.
USE_LIGHT_COLORS = true

# You may wish to set up pre-defined themes for certain hosts in Terminal Preferences -> Settings. 
# Click on the + button or click on the gear icon and duplicate an existing theme. Give it a name.
# Then map the hostname to the theme name you'd like to use in the theme map.

theme_map = {
	#	"linux-host.com" => "black_theme",
	#	"mac-host.com" => "default"
}

# Generates a random color by hashing the host name.
# Applescript uses numbers between 0 and 65535.

class RandomColor
	attr_reader :red, :green, :blue
	def initialize(hostname)
		hash = Digest::MD5.hexdigest(hostname)
		@red = 64 * hash[0..1].to_i(16)
		@green = 64 * hash[2..3].to_i(16)
		@blue = 64 * hash[4..5].to_i(16)
	end
	
	def light_color
		[49151 + red, 49151 + green, 49151 + blue]
	end
	
	def dark_color
		[red, green, blue]
	end
end

remote_host = ARGV[0]
hostname = remote_host
if remote_host.match(/(.*?)\@(.*?)$/)
	hostname = $2
end

theme = theme_map[hostname]
if theme
	system("echo \"tell application \\\"Terminal\\\" to set current settings of selected tab of window 1 to (first settings set whose name is \\\"#{theme}\\\")\" | osascript")
else
	color_maker = RandomColor.new(hostname)
	(red, green, blue) = USE_LIGHT_COLORS ? color_maker.light_color : color_maker.dark_color
	applescript_color = "{ #{red}, #{green}, #{blue} }"
	system("echo \"tell application \\\"Terminal\\\" to set background color of window 1 to #{applescript_color}\" | osascript")
end

cmd = "ssh #{remote_host}"
system(cmd)

# Set the theme back to the default theme.
system("echo \"tell application \\\"Terminal\\\" to set current settings of selected tab of window 1 to (first settings set whose name is \\\"#{DEFAULT_THEME}\\\")\" | osascript")

# Applescript from:
# http://serverfault.com/questions/130436/how-can-i-automatically-change-terminal-colors-when-i-ssh-a-server
