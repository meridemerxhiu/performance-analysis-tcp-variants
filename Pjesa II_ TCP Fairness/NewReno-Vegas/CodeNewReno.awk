BEGIN{
highest_packet_sn=0; 
ndelay=0;
pktDrops = 0;
pktSent = 0;
packetdrop= 0;
throughput= 0;

hop=0;
}
{
#event = $1; time = $2; s_node = $3; dest_node = $4; pkt_type = $5; pkt_size = $6; flow_id = $8; s_port = $9; dest_port = $10; seq_no = $11; pkt_id = $12;

    if (($9 == 1.1 ) && ($10 == 5.0) && ($1 == "+") && ($5 == "tcp") && ($8 == 1))
pktSent++;
if (($5 == "tcp") && $1 == "d")
pktDrops++;



if(($1 == "+") && ($9== 1.1) && (highest_packet_sn < $11) && ($5 == "tcp") && ($8 == 1)) {

          highest_packet_sn++ ;
                      }
if(($1 == "+") && ($9 == 1.1) && ($5 == "tcp") && ($8 == 1)) 
{

          start_time[$11] = $2;}

     else if(($1 == "r") && ($5 == "tcp") && ($8 == 1))
 {

        end_time[$11] = $2;}

     else if(($1 == "d") && ($5 == "tcp") && ($8 == 1))
 {

          end_time[$11] = -1;

    } 

}  
 
END {        
  
    for($11=0; $11<=highest_packet_sn; $11++)
 {

          if(end_time[$11] > 0) {

              delay[$11] = end_time[$11] - start_time[$11];
hop++;

        }

            else

            {

                  delay[$11] = -1;

            }

    }

    for($11=0; $11<=highest_packet_sn; $11++) 
{

          if(delay[$11] > 0) {

              ndelay = ndelay + delay[$11];

        }         

    }

ndelay = (ndelay/hop)*1000;
      packetdrop = (pktDrops/pktSent)*100;
    throughput= (1040*8*(pktSent-pktDrops))/50000;

printf("\n/========== NewReno ==========/\n");      
printf(" Packet sent %d \n Packet lost %d \n Packet drop rate: %f %\n Throughput %f kbps \n Delay %f ms \n\n ",pktSent,pktDrops,packetdrop,throughput,ndelay);


   


} 

