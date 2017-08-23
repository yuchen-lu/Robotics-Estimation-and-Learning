
close all


imagepath = '/u/b/luyuche1/Documents/Estination and Learning hw/train';
Samples=[];
D=3;
largek=5;
Samplesmean=0;
for k=1:15
    
    I = imread(sprintf('%s/%03d.png',imagepath,k));
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
       
    
    disp('')
    disp('INTRUCTION: Click along the boundary of the ball. Double-click when you get back to the initial point.');
    disp('INTRUCTION: You can maximize the window size of the figure for precise clicks.')

    mask=roipoly(I);
   imshow(I);
   imshow(mask);
    sample_ind = find(mask > 0);
    
    R = R(sample_ind);
    G = G(sample_ind);
    B = B(sample_ind);

    Samplesmean =Samplesmean+mean(Samples);
  %  Samplesvar = var(Samples);  
    disp('INTRUCTION: Press any key to continue. (Ctrl+c to exit)')
    pause
end


%{
close all

imagepath = '/u/b/luyuche1/Documents/Estination and Learning hw/train';
Samples = [];
for k=1:15
    I = imread(sprintf('%s/%03d.png',imagepath,k));
    

end
%}