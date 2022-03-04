#Krijohet nje instance simulatori
set ns [new Simulator]

$ns color 0 Red
$ns color 1 Green

#Vartanti TCP dhe CBR rate
set variant [lindex $argv 0]
set cbrrate [lindex $argv 1]

#Krijohet nje file trace
set tf [open out.tr w]
$ns trace-all $tf

set windowVsTime2 [open WindowVsTime_${variant} w]

#Krijohet nje NAM trace file
set nf [open paraqitja.nam w]
$ns namtrace-all $nf

#Percaktohet nje procedure finish
proc finish {} {
        global ns nf tf
        $ns flush-trace
        close $nf
        close $tf
        exec nam paraqitja.nam &
        #exec gawk -f drop_rate.awk out.tr &
        #exec gawk -f delay_link.awk out.tr &
        #exec perl throughputTCP.pl out.tr 5 1.0 5.1 1 &
        exec awk -f performanca.awk out.tr &
        exit 0
}


#Krijohen nyjet
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]



$ns at 0 "$n0 label \"CBR\""
$ns at 0 "$n1 label \"FTP\""
$n0 color red
$n5 color blue
$n1 color green
$n2 color gray
$n3 color gray
$n4 color gray
$n6 color gray
$n7 color gray



#Lidh nyjet me link

$ns duplex-link $n0 $n2 6Mb 10ms DropTail
$ns duplex-link $n1 $n2 6Mb 10ms DropTail
$ns duplex-link $n3 $n2 6Mb 10ms DropTail
$ns duplex-link $n2 $n4 6Mb 10ms DropTail
$ns duplex-link $n4 $n5 6Mb 10ms DropTail
$ns duplex-link $n4 $n6 6Mb 10ms DropTail
$ns duplex-link $n4 $n7 6Mb 10ms DropTail

#Orientimi i nyjeve 
$ns duplex-link-op $n0 $n2 orient right-down 
$ns duplex-link-op $n3 $n2 orient right-up 
$ns duplex-link-op $n1 $n2 orient right 
$ns duplex-link-op $n2 $n4 orient right 
$ns duplex-link-op $n4 $n7 orient right-down 
$ns duplex-link-op $n4 $n5 orient right-up 
$ns duplex-link-op $n4 $n6 orient right 

$ns queue-limit $n2 $n4 10

#Ngjyros linket
$ns duplex-link-op $n0 $n2 color gray 
$ns duplex-link-op $n3 $n2 color gray 
$ns duplex-link-op $n1 $n2 color gray
$ns duplex-link-op $n2 $n4 color gray 
$ns duplex-link-op $n4 $n7 color gray
$ns duplex-link-op $n4 $n5 color gray
$ns duplex-link-op $n4 $n6 color gray

#Krijo nje agjent UDP 
set udp [new Agent/UDP]
$ns attach-agent $n0 $udp
set null [new Agent/Null]
$ns attach-agent $n5 $null
$ns connect $udp $null
$udp set fid_ 0

#Krijo nje burim CBR
set cbr [new Application/Traffic/CBR]
$cbr set rate_ ${cbrrate}mb
$cbr set type_ CBR
$cbr attach-agent $udp

# TCP
if {$variant == "Tahoe"} {
	set tcp [new Agent/TCP]
} elseif {$variant == "Linux"} {
	set tcp [new Agent/TCP/Linux]
} elseif {$variant == "NewReno"} {
	set tcp [new Agent/TCP/Newreno]
} elseif {$variant == "Vegas"} {
	set tcp [new Agent/TCP/Vegas]
}
$ns attach-agent $n1 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n5 $sink
$ns connect $tcp $sink
$tcp set fid_ 1

#FTP 
set ftp [new Application/FTP]
$ftp attach-agent $tcp

#Koha e fillimit dhe mbarimit 
$ns at 0 "$cbr start"
$ns at 0.1 "$ftp start"
$ns at 50 "$ftp stop"
$ns at 50 "$cbr stop"
$ns at 60 "finish"

#=========================================================================
# create a random variable that follows the uniform distribution
set loss_random_variable [new RandomVariable/Uniform]
$loss_random_variable set min_ 0 # the range of the random variable;
$loss_random_variable set max_ 100
#=========================================================================
#set loss_module [new ErrorModel];		# create the error model;
#$loss_module unit pkt		;		# error unit: packets (the default);
#$loss_module drop-target [new Agent/Null];	#a null agent where the dropped packets go to
#$loss_module set rate_ 0.05	;		# duhet vendosur 5 nqs loss_random_variable [new RandomVariable/Uniform] nuk eshte koment.
#=========================================================================
#$loss_module ranvar $loss_random_variable # attach the random variable to loss module;
#You can attach the loss module to a certain link between two nodes, n2 and n3, with the command:
#$ns lossmodel $loss_module $n2 $n4
#=========================================================================

# Printimi i size te dritares
proc plotWindow {tcpSource file} {
global ns
set time 0.01
set now [$ns now]
set cwnd [$tcpSource set cwnd_]
puts $file "$now $cwnd"
$ns at [expr $now+$time] "plotWindow $tcpSource $file"}
$ns at 0.05 "plotWindow $tcp $windowVsTime2" 

#Fillon simulimi
$ns run
