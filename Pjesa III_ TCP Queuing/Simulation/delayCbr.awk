#============ delay-e2e.awk =========
BEGIN {
  src="1.0"; dst="5.1";
  num_samples = 0;
  total_delay = 0;
}
/^\+/&&$9==src&&$10==dst {
    t_arr[$12] = $2;
};
/^r/&&$9==src&&$10==dst{
    if (t_arr[$12] > 0) {
      num_samples++;
      delay = $2 - t_arr[$12];
    total_delay += delay;
    };
};
END{
  avg_delay = total_delay/num_samples;
  print "Average end-to-end transmission delay CBR is " avg_delay*1000  " ms";
};
