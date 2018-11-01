% NURHAK ALTIN KCOAELÝ ÜNÝVERSÝTESÝ ELEKTRONÝK VE HABERLEÞME MÜHENDÝSLÝÐÝ 3.SINIF 2.ÖÐRETÝM 130208014
% UZAKTAN ALGILAMA TEKNOLOJÝLERÝ DERSÝ PROJESÝ
% AVIRIS Indian Pine HÝPERSPEKTRAL VERÝ KÜMESÝ ÝÇÝN, K EN YAKIN KOMÞULAR ÝLE SINIFLANDIRMA YAPILMIÞTIR.
% TAMAMEN NURHAK ALTIN TARAFINDAN YAZILMIÞTIR.
% K DEÐERÝ 3 VE 5 OLARAK ALINIP SONUÇLAR KAYDEDÝLMÝÞTÝR.
% BU KOD PREDICTED VE PREDICTEDN_5 OLARAK ÝKÝ SONUÇ VERMÝÞTÝR.K DEÐERÝNE GÖRE SONUÇ DEÐÝÞMEKTEDÝR. PREDICTED K=3 DEÐERÝ ÝÇÝN PREDICTED_5 K=5 DEÐERÝ ÝÇÝNDÝR.

clc;
clear all;
close all;

% DATALAR YÜKLENDÝ
load('Indian_pines_gt.mat');
load('Indian_pines.mat');

% EÐÝTÝM VERÝSÝ OLUÞTURMAK ÝÇÝN VE %10 A KARAR VEREBÝLMEK ÝÇÝN MATRÝSLER
% OLUÞTURULDU.
label=zeros(2,16);
egitim = zeros(1,16);

% K DEÐERÝ KULLANICIDAN ALINDI
prompt='K Degerini Giriniz=';
k_value=input(prompt);

% ETÝKETLER OLUÞTURULDU 0 ALINMAYACAÐI ÝÇÝN 1 DEN 15 E KADAR
for i=1:16
    label(1,i)=i;
end

% ANA VERÝDE KAÇ TANE AYNI LABELDEN OLDUÐU SAYILDI VE LABEL MATRÝSÝNE
% ATILDI
for i=1:145
   for j=1:145
       for k=1:16
           if (indian_pines_gt(i,j)==k)
                label(2,k)=label(2,k)+1;
           end
       end
   end   
end

%EÐÝTÝM VERÝSÝ %10 OLMASI GEREKTÝÐÝ ÝÇÝN SAYILAR HESAPLANDI VE EÐÝTÝM
%MATRÝSÝNE ATILDI
for i=1:16
    egitim(1,i)=uint8(label(2,i)/10);
end

%RANDOM OLARAK HER LABEL ÝÇÝN BELÝRLENEN %10 LUK VERÝ KADAR VERÝLERÝN
%KOORDÝNATLARI VE LABELLARI SONUC MATRÝSÝNE ATILDI
sonuc=zeros(3,1027);
counter=0;
temp=1;
for i=1:16
  while(temp<=egitim(1,i))
    l=randi([1 145],1,1);
    j =randi([1 145],1,1);
    if(indian_pines_gt(l,j)==i)
        counter=counter+1;
        temp=temp+1;
        sonuc(1,counter)=i;
        sonuc(2,counter)=l;
        sonuc(3,counter)=j;
    end
  end
 temp=1;
end


%KOORDÝNATLARI VERÝLER VERÝLERÝN ANA MATRÝSTEN VEKTÖRLERÝ ALINARAK EÐÝTÝM
%KÜMESÝ OLUÞTURULDU.
final_egitim=zeros(1027,220);
for i=1:1027
  for j=1:220
  final_egitim(i,j)=indian_pines(sonuc(2,i),sonuc(3,i),j);
  end
end

%SINIFLANDIRMA SONUÇALRI ÝÇÝN MATRÝS OLUÞTURULDU.
predicted_5=zeros(145,145);

%SIRALAMALAR VE ÖKLÝD UZAKLIÐI ÝÇÝN MATRÝS OLUÞTURULDU
count=0;
g=zeros(1027,2);
k_array=zeros(k_value,2);

for row=1:145
  for col=1:145
    for l=1:1027
        count=count+1;
        %ÖKLÝD UZAKLIK HESAPLANDI
        g(count,1)=sqrt(sum((indian_pines(row,col,:) - final_egitim(l)) .^ 2));
%        g(count,1)=pdist2(indian_pines(row,col),final_egitim(l));
        g(count,2)=sonuc(1,l);
        %UZAKLIKLAR SIRALANDI
        B=sortrows(g,1);
        
        %K DEÐERÝ NE KADAR AYRI BÝR MATRÝSE ALINDI
        for i=1:k_value
            k_array(i,1)=B(i,1);
            k_array(i,2)=B(i,2);
            %EN ÇOK TEKRAR EDEN LABEL SONUÇ OLARAK BULUNDU VE ATILDI.
            sorted=mode(k_array());
%             predicted_5(row,col)=sorted(2);
        end
    end
    count=0;
  end
end


