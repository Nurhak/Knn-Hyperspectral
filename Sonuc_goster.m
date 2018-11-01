% NURHAK ALTIN KCOAELÝ ÜNÝVERSÝTESÝ ELEKTRONÝK VE HABERLEÞME MÜHENDÝSLÝÐÝ 3.SINIF 2.ÖÐRETÝM 130208014
% UZAKTAN ALGILAMA TEKNOLOJÝLERÝ DERSÝ PROJESÝ
% AVIRIS Indian Pine HÝPERSPEKTRAL VERÝ KÜMESÝ ÝÇÝN, K EN YAKIN KOMÞULAR ÝLE SINIFLANDIRMA YAPILMIÞTIR.
% TAMAMEN NURHAK ALTIN TARAFINDAN YAZILMIÞTIR.
% K DEÐERÝ 3 VE 5 OLARAK ALINIP SONUÇLAR KAYDEDÝLMÝÞTÝR.


%SONUÇLAR VE GROUNDTRUTH YÜKLENDÝ
load('predicted_16_5.mat');
load('Indian_pines_gt.mat');

ara=predicted_5;

for i=1:145
    for j=1:145
        if(indian_pines_gt(i,j)==0)
            ara(i,j)=0;
        end
    end
end

counter=0;

for i=1:145
    for j=1:145
        if(indian_pines_gt(i,j)==ara(i,j))
            counter=counter+1;
        end
    end
end

yuzde=(counter*100)/(145*145);

figure();
imagesc(ara);



