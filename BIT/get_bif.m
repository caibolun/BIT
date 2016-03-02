function C1 = get_bif(im, ns)

    global cnmap
    if(isempty(cnmap))
        temp=load('w2c.mat');
        cnmap=temp.w2c;
    end  
    
    C1_color=[];
    if size(im,3)>1        
         %Change the order of AVG pooling Eq(6) and CN Mapping Eq(3) to speed up
        [h,w,~]=size(im);
        C1_img=single(imresize(im,[floor(h/ns),floor(w/ns)])); %Eq(6)

        RR=C1_img(:,:,1);GG=C1_img(:,:,2);BB=C1_img(:,:,3);
        index_im = 1+floor(RR(:)/8)+32*floor(GG(:)/8)+32*32*floor(BB(:)/8);
        C1_color=reshape(cnmap(index_im,:),size(C1_img,1),size(C1_img,2),size(cnmap,2)); %Eq(3)
    end
    
    xi=[7,9,11,13,15];
    sig=[2.8,3.6,4.5,5.4,6.3];
    lambda=[3.5,4.6,5.6,6.8,7.9];
    orientations=4;
    
    C1_gabor=[];
    if size(im,3)>1
        im=rgb2gray(im);
    end
    im=single(im)/255;
    for scale=1:5
        %% 1D Gabor filter
        [~,Gx] = filterGabor( xi(scale), sig(scale), lambda(scale));
        Gy=Gx';
        %% multi scale orthogonal Gabor response maps on Eq(11) 
        Dx=imfilter(im,Gx,'replicate');
        Dy=imfilter(im,Gy,'replicate');
        %% the orientation and magnitude of the Gabor gradient on Eq(12)
        A=sqrt(Dx.^2+Dy.^2);
        Theta=atan2(Dy,Dx);
        Theta(Theta<0)=2*pi+Theta(Theta<0);
        %% Eq(13), Eq(14) and Eq(4), Eq(5), Eq(6)
        H = fga(A,Theta,ns,orientations,scale);
        C1_gabor=cat(3,C1_gabor,H);
    end
    
    if ~isempty(C1_color)
        C1=bsxfun(@plus,C1_gabor,C1_color*1i);
    else
        C1=C1_gabor;
    end
	
end
