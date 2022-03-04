#Creating New Simulator
set ns [new Simulator]

#Creating trace File
set tf [open out.tr w]
$ns trace-all $tf

#Creating NAM Trace File
set nf [open out.nam w]
$ns namtrace-all $nf

set windowVsTime2 [open WindowVsTime_Linux-Linux w]

#Declaring finish procedure
proc finish {} {
        global ns nf tf
        $ns flush-trace
        close $nf
        close $tf
        #exec nam out.nam &
        exit 0
}

#Flow colors
$ns color 0 Blue
$ns color 1 Red

#Creating nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]

$n0 label "TCP/FTP"
$n0 color red

$n1 label "UDP/CBR"
$n1 color blue

$n5 label "SINK/NULL"
$n5 color green

#Create a random variable that follows the uniform distribution
set loss_random_variable [new RandomVariable/Uniform]
$loss_random_variable set min_ 0 # the range of the random variable;
$loss_random_variable set max_ 100


#Creating links between nodes
$ns duplex-link $n0 $n2 6Mb 10ms DRR
$ns duplex-link $n1 $n2 6Mb 10ms DRR
$ns duplex-link $n3 $n2 6Mb 10ms DRR
$ns duplex-link $n2 $n4 6Mb 10ms DRR
$ns duplex-link $n4 $n5 6Mb 10ms DRR
$ns duplex-link $n4 $n6 6Mb 10ms DRR
$ns duplex-link $n4 $n7 6Mb 10ms DRR

#Link color
$ns duplex-link-op $n0 $n2 color red
$ns duplex-link-op $n1 $n2 color blue
$ns duplex-link-op $n2 $n4 color green
$ns duplex-link-op $n4 $n5 color green

#Nodes orientation for Nam
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n3 $n2 orient right-up
$ns duplex-link-op $n1 $n2 orient right
$ns duplex-link-op $n2 $n4 orient left
$ns duplex-link-op $n4 $n2 orient right
$ns duplex-link-op $n4 $n7 orient right-down 
$ns duplex-link-op $n4 $n5 orient right-up
$ns duplex-link-op $n4 $n6 orient right

#Set Queue Size of link (n2-n4) to 10
$ns queue-limit $n2 $n4 10

#Creating a TCP agent LINUX
set tcp [new Agent/TCP/Linux]
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n5 $sink
$ns connect $tcp $sink
$tcp set fid_ 1
$tcp set window_ 2000
$tcp set packetSize_ 1040

#Creatinf FTP source and attaching it to TCP Agent
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

#Creating UDP agent
set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
set null [new Agent/Null]
$ns attach-agent $n5 $null
$ns connect $udp $null
$udp set fid_ 0

#Creating CBR source and attaching to UDP agent
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR
$cbr set packet_size_ 1000
$cbr set rate_ 2Mb
$cbr set random_ false

#Event schedular
$ns at 0.1 "$ftp start"
$ns at 2 "$cbr start"
$ns at 50 "$cbr stop"
$ns at 50 "$ftp stop"
$ns at 50 "finish"

#Printing windos size
proc plotWindow {tcpSource file} {
global ns
set time 0.01
set now [$ns now]
set cwnd [$tcpSource set cwnd_]
puts $file "$now $cwnd"
$ns at [expr $now+$time] "plotWindow $tcpSource $file"}
$ns at 0.05 "plotWindow $tcp $windowVsTime2" 

#Start simulation
$ns run
