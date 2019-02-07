

n=1;
D0=50; 

%  amplitude
A=10; 

%Read  the input image
I=imread('testpattern.tif');

%get the size of the image
[M,N]=size(I); % is easy to get the h and w like this

% compute the 2d fourier transform 
F=fft2(double(I));

% compute filter
u=0:(M-1);
v=0:(N-1);

idx=find(u>M/2);
u(idx)=u(idx)-M;
idy=find(v>N/2);
v(idy)=v(idy)-N;
[V,U]=meshgrid(v,u);
D=sqrt(U.^2+V.^2);
H =A * (1./(1 + (D0./D).^(2*n)));

%HHi = H-1

% multiply the filter 
G=H.*F;
g=real(ifft2(double(G)));

%create a mask(question specification)
c = [500 400 400 500 ];
r = [100 100 1 1 ];
T =  fspecial('unsharp')*5;
BW = roipoly(I,c,r);
J = roifilt2(T,g,BW);


subplot(1,4,1); imshow(I); title('Input image');
subplot(1,4,2); imshow(H,[ ]); title('filter');
subplot(1,4,3); imshow(g,[ ]); title('filtered image');
subplot(1,4,4); imshow(J,[ ]); title('masked filter');