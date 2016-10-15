function first_hist = lab2(filename)

  first_pic=myjpgload(filename,0);
  first_hist=dohist(first_pic,0);
  
  filter=gausswin(50,6);
  filter=filter/sum(filter);
  %plot(filter);
  hold on;
  smooth_hist=conv(filter,first_hist);
  plot(smooth_hist);
  

  
