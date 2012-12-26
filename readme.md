Color SSH
---------

This is a Ruby script for MacOS X to set the Terminal background color based on the host name you ssh to. It uses Applescript to set the Terminal color.

To install, you'll need to alias your 'ssh' command to this script. Install the script somewhere on your computer.  For example:

	mv color_ssh.rb /usr/local/bin/color_ssh.rb
	chmod +x /usr/local/bin/color_ssh.rb

Then place this line in your ~/.profile in your home folder:

	alias ssh="/usr/local/bin/color_ssh.rb"
	
Open a new terminal window to apply the changes to the .profile, then ssh to another host name. If all went well, the background color of your terminal will change accordingly.

Configuration
-------------

If you prefer to use white text on a dark background, you'll need to set the USE_LIGHT_COLORS flag in color_ssh.rb to false.

It is also possible to set up predefined themes for specific host names. If you want your linux servers to use a dark background, you can map them all to the "Homebrew" theme. See the color_ssh.rb script for more details.

Other SSH Commands
------------------

You can easily run other ssh commands while this is installed by using the full path to ssh:

	/usr/bin/ssh "ls -l" user@remote-host.com

References
----------

The Applescript is from this helpful response to this ServerFault question:

- [How can I automatically change terminal colors when I ssh a server?](http://serverfault.com/questions/130436/how-can-i-automatically-change-terminal-colors-when-i-ssh-a-server)
	
-------------------------------

©2012 Erik Wrenholt

- Web site: [Timestretch.com](http://www.timestretch.com/)
- GitHub: [github.com/timestretch](https://github.com/timestretch)