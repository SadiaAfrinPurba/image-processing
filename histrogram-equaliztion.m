I=imread('cameraman.png');
[row,col]=size(I);
histEq = uint8(ones(row, col));
total_pixel = row * col;
n_k = zeros(256,1);
pdf = zeros(256,1);
cdf = zeros(256,1);
cum = zeros(256,1);
round_off = zeros(256,1);
sum = 0;
L = 255;

%pdf
for i=1:row
    for j=1:col
        value = I(i,j);
        n_k(value+1) = n_k(value+1) +1;
        pdf(value+1) = n_k(value+1)/total_pixel;
        
        
    end
end

%cdf
for i=1:size(pdf)
    sum = sum + n_k(i);
    cum(i) = sum;
    cdf(i) = cum(i) / total_pixel;
    round_off(i) = round(cdf(i) * L);
end

figure, bar(pdf);
grid on;
ylabel('no. of pixels with such intensity levels---->');
xlabel('intensity levels---->'); title('PDF')

figure, bar(cdf);

grid on;
ylabel('no. of pixels with such intensity levels---->');
xlabel('intensity levels---->'); title('CDF')
 


%mapping
for i=1:row
    for j=1:col
        histEq(i,j) =  round_off(I(i,j) +1);
    end
end
figure,imshow(I),title('Original Image');
figure,imshow(histEq),title('Equalise Image');

t=1:256;
n=0:255;
count=0;
for z=1:256
    for i=1:row
        for j=1:col
            
            if histEq(i,j)==z-1
                count=count+1;
            end
        end
    end
            t(z)=count;
            count=0;
end
figure,stem(n,t); 
grid on;
ylabel('no. of pixels with such intensity levels---->');
xlabel('intensity levels---->'); title('HISTOGRAM OF THE IMAGE')
        
        