#Creating New Simulator
set ns [new Simulator]

#Creating trace File
set tf [open out.tr w]
$ns trace-all $tf

#Creating NAM Trace File
set nf [open out.nam w]
$ns namtrace-all $nf

set windowVsTime2 [open WindowVsTime_NewReno-Vegas w]

#Declaring finish procedure
proc finish {} {
        global ns nf tf
        $ns flush-trace
        close $nf
        close $tf
        exec nam out.nam &
	exec awk -f CodeNewReno.awk out.tr &     
        exec awk -f CodeVegas.awk out.tr &
        exit 0
}

#Flow colors
$ns color 0 Red
$ns color 1 Green
$ns color 2 Blue

#Creating nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]

$n1 label "CBR-FTP1"
$n1 color green

$n2 label "NULL"
$n2 color red

$n3 label "TCP/FTP-2"
$n3 color blue

$n5 label "SINK"
$n5 color blue

#Create a random variable that follows the uniform distribution
set loss_random_variable [new RandomVariable/Uniform]
$loss_random_variable set min_ 0 # the range of the random variable;
$loss_random_variable set max_ 100

#Creating links between nodes
$ns duplex-link $n0 $n2 6Mb 10ms DropTail
$ns duplex-link $n1 $n2 6Mb 10ms DropTail
$ns duplex-link $n3 $n2 6Mb 10ms DropTail
$ns duplex-link $n2 $n4 6Mb 10ms DropTail
$ns duplex-link $n4 $n5 6Mb 10ms DropTail
$ns duplex-link $n4 $n6 6Mb 10ms DropTail
$ns duplex-link $n4 $n7 6Mb 10ms DropTail

#Link color
$ns duplex-link-op $n1 $n2 color green
$ns duplex-link-op $n3 $n2 color blue
$ns duplex-link-op $n2 $n4 color blue
$ns duplex-link-op $n4 $n5 color blue

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

#Creating UDP agent
set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
set null [new Agent/Null]
$ns attach-agent $n2 $null
$ns connect $udp $null
$udp set fid_ 0

#Creating CBR source and attaching to UDP agent
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR
$cbr set packet_size_ 1000
$cbr set rate_ 7Mb
$cbr set random_ false

#Creating a TCP-1 agent NewReno
set tcp1 [new Agent/TCP/Newreno]
$ns attach-agent $n1 $tcp1
set sink1 [new Agent/TCPSink/DelAck]
$ns attach-agent $n5 $sink1
$ns connect $tcp1 $sink1
$tcp1 set fid_ 1
$tcp1 set window_ 2000
$tcp1 set packetSize_ 1040

#Creatinf FTP1 source and attaching it to TCP1 Agent
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP

#Creating a TCP-2 agent Vegas
set tcp2 [new Agent/TCP/Vegas]
$ns attach-agent $n3 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n5 $sink2
$ns connect $tcp2 $sink2
$tcp2 set fid_ 2
$tcp2 set window_ 2000
$tcp2 set packetSize_ 1040

#Creating FTP2 source and attaching it to TCP2 Agent
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set type_ FTP

#Event schedular
$ns at 0.01 "$cbr start"
$ns at 0.01 "$ftp1 start"
$ns at 0.01 "$ftp2 start"
$ns at 50 "$cbr stop"
$ns at 50 "$ftp1 stop"
$ns at 50 "$ftp2 stop"
$ns at 50 "finish"

#Printing windos size
proc plotWindow {tcpSource file} {
global ns
set time 0.01
set now [$ns now]
set cwnd [$tcpSource set cwnd_]
puts $file "$now $cwnd"
$ns at [expr $now+$time] "plotWindow $tcpSource $file"}
$ns at 0.05 "plotWindow $tcp1 $windowVsTime2" 

#Start simulation
$ns run
