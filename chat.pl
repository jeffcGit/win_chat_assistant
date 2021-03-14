#!/usr/bin/perl 
##############################################################
#  filename  : chat2.pl
#  Author     : Jeff Cyprien
#  Date       : 11/25/2019
#  Last Edited: 03/11/2020, Jeff Cyprien
#  Description: Windows system info: Chat bot assistant
##############################################################
# Purpose:
# - Assist users to quickly find basic system info and more.
##############################################################

######################################
####   Opening Initializations    ####
######################################

use warnings;
use strict;
use English qw' -no_match_vars ';
use Config;
use Win32::Process;
use Win32;
use Win32::GuiTest qw(:ALL);  # Allow  mouse click and  the use of keys from cmd
use Win32::Console;
use LWP::Simple;
use Log::Log4perl qw(:easy);

# Log information to be printed to xyz.log file
Log::Log4perl->easy_init(
    {
        file  => ">> xyz.log",
        level => $INFO,
    }
);
INFO("New Script Execution");

#print "$Config{osname}\n";
#print "$Config{archname}\n";
#print "$Config{cpp}\n";

our $VERSION = "0.1";

my $datestring = localtime();

# Set console colors and window size

my $CONSOLE = Win32::Console->new(STD_OUTPUT_HANDLE);
my $attr = $CONSOLE->Attr();                 # Get current console colors
$CONSOLE->Attr( $FG_YELLOW | $BG_GREEN );    # Yellow text on green

#my $OUT = Win32::Console->new(STD_OUTPUT_HANDLE);

print "WINDOWS BOT ASSISTANT*\n";
print "**********************\n";
print "\n";

$CONSOLE->Attr($attr);                    # Set console colors back to original
$CONSOLE->Attr( $FG_RED | $BG_WHITE );    # Red text on White

my ( $left, $top, $right, $bottom ) = $CONSOLE->Window();
$CONSOLE->Window( 1, 0, -1, 60, 30 );     # Set predefined size for the window

# creating the labels bot: and me: to be displayed on the terminal
print "Bot: Talk to me please\n";
my $me = "Me: \n";
chomp $me;
print $me ;
$_ = <STDIN>;

# simulating working progress with dots
$| = 1;

sub dots {
    for ( 1 ... 2 ) {
        print ".";
        sleep(1);
    }
    print "\n";
}

#Getting public IP
sub public_ip {
    my $url     = "http://ifconfig.me/ip";
    my $content = get($url);
    return "Your public IP for the world is $content \n";
}

# Display the  bot response
sub chat {
    for ($_) {
        my $bot = "Bot: \n";
        chomp($bot);
        print $bot ;
    }

    if ( /^\s*$/ || /^ *$/ )    #regx to match empty space entry
    {
        print "Seems like you did not type a thing...\n";
        dots();  # Working simulation
    }
    elsif (m/\bhi\b/i
        || m/\bhello\b/i
        || m/\bhey\b/i
        || m/\bhowdy\b/i
        || m/\bwhat's up\b/i )
    {
        print "Hi, how are you?\n";
        dots();
    }
    elsif (m/\bhow are you\b/i
        || m/\bhow you doing\b/i
        || m/\bhow is it going\b/i )
    {
        print "It seems to be a beautiful day\n";
        dots();
    }
    elsif ( m/\bpublic\b/i && m/\bip\b/i ) {
        print public_ip();
        dots();
    }
    elsif ( m/\bIP\b/i || m/\bsubnet mask\b/i || m/\bip address\b/i ) {
        system "ipconfig\n";
        dots();
    }
    elsif (m/\bmac\b/i
        || m/\bmac address\b/i
        || / \bphysical address\b/i
        || m/\bDNS\b/i
        || m/\bMAC\b/i
        || m/\bMac mask\b/i )
    {
        system "ipconfig /all\n";
        dots();
    }
    elsif (m/\bdisk space\b/i
        || m/\bdisk\b/i && m/ \bspace\b/i
        || m/\bdisk size\b/i
        || m/\bdisk\b/i && m/\busage\b/i
        || m/\bdisk\b/i && m/\bsize\b/i )
    {
        system "wmic logicaldisk get size,freespace,caption\n";
        dots();
    }

    elsif ( m/\bgood\b/i && m/\bmorning\b/i ) {
        print "Hi, how are you?\n";
        dots();
    }
    elsif ( m/\bsorry\b/i || m/\bapologize\b/i || m/\bapology\b/i ) {
        print "For what, I have no feelings...lol...\n";
        dots();
    }
    elsif (m/\bwho are\b/i && m/\byou\b/i
        || m/\bare you\b/i && m/\bhuman\b/i
        || m/\byour name\b/i
        || m/\byour version\b/i
        || m/\bwhich version\b/i
        || m/\byour current version\b/i )
    {
        print "I'm a chat bot?" and print " Version $VERSION, \n";
        dots();
    }
    elsif (m/\balright\b/i
        || m/\bgood\b/i
        || m/\bcool\b/i
        || m/\bok\b/i
        || m/\bokay\b/i
        || m/\bunderstood\b/i
        || m/\bwait\b/i
        || m/\bgotcha\b/i
        || m/\bno\b/i && m/\bproblem\b/i )
    {
        print "Alright\n";
        dots();
    }

    elsif (m/\bweather\b/i) {
        print "Sorry, I don't have this info at this time..\n";
        dots();
    }
    elsif (m/\bwho\b/i && m/\bdesigned\b/i
        || m/\bwho\b/i  && m/\bprogrammed\b/i
        || m/\bwho\b/i  && m/\bmaster\b/i
        || m/\byour\b/i && m/\bprogrammer\b/i
        || m/\byour\b/i && m/\bmaster\b/i
        || m/\byour creator\b/i )
    {
        print "Jeff C.\n";
        dots();
    }
    elsif (m/\bGreat\b/i
        || m/\bFine\b/i
        || m/\bwell\b/i
        || m/\bi'm\b/i && m/\balright\b/i
        || m/\bi'm\b/i && m/\bgood\b/i )
    {
        print "Great, how can I help you?\n";
        dots();
    }
    elsif (m/\bhelp\b/i
        || m/\bsupport\b/i
        || m/\bassistance\b/i
        || m/\binformation\b/i
        || m/\binfo\b/i )
    {
        print "If you need help, be more specific, I'll do my best.\n";
        dots();
    }
    elsif (m/\btime\b/i
        || m/\bdate\b/i
        || m/\byear\b/i )
    {
        print "the local time and date is: $datestring", "\n";
        dots();
    }
    elsif ( m/\boperating system\b/i || m/\bOS\b/i || m/\bOperating System\b/i )
    {
        system 'systeminfo | findstr /B /C:"OS Name" /C:"OS Version';
        dots();
    }
    elsif (m/\bOS\b/i && m/\btype\b/i
        || m/\boperating system\b/i && m/\btype\b/i )
    {
        print "Your system is:", $OSNAME, "\n";
        dots();
    }
    elsif ( m/\bthanks\b/i || m/\bthank you\b/i ) {
        print "You are welcome, anything else?" || print "More help?";
        dots();
    }
    elsif (/\byes\b/
        || /\byeah\b/
        || /\byup\b/
        || /\bYes\b/
        || /\bYeah\b/
        || /\bYup\b/
        || /\bsure\b/ )
    {
        print "please ask your question\n";
        dots();
    }
    elsif (m/\bcomputer vendor\b/i
        || m/\bcomputer brand\b/i
        || m/\bComputer Manufacturer\b/i )
    {
        system "wmic csproduct get vendor, version\n";
        dots();
    }
    elsif (m/\bcomputer model\b/i
        || m/\bpc model\b/i
        || m/\bmodel of\b/i )
    {
        system "wmic computersystem get model\n";
        dots();
    }
    elsif (m/\bcomputer details\b/i
        || m/\bsystem details\b/i
        || m/\bsystem type\b/i )
    {
        system "wmic computersystem get model,name,manufacturer,systemtype\n";
        dots();
    }
    elsif (m/\bno\b/i
        || m/\bnope\b/i
        || m/\bbye\b/i
        || m/\bnothing\b/i
        || m/\badios\b/i
        || m/\bnope\b/i
        || m/\bhasta la vista\b/i
        || m/\bexit\b/i )
    {
        print "OK then, bye\n";
        sleep(1);
        SendKeys("%{F4}")
          ; # This will automatically type the Alt + F4 keys to close the window
    }
    else {
        print "sorry, I couldn't interprete that. \n";
        dots();
    }
}

# This loop will continuously return the next question
while ( $_ ne "" ) {
    chat();
    chomp($me);
    print $me ;
    $_ = <STDIN>;
}

