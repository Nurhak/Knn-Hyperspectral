% NURHAK ALTIN KCOAEL� �N�VERS�TES� ELEKTRON�K VE HABERLE�ME M�HEND�SL��� 3.SINIF 2.��RET�M 130208014
% UZAKTAN ALGILAMA TEKNOLOJ�LER� DERS� PROJES�
% AVIRIS Indian Pine H�PERSPEKTRAL VER� K�MES� ���N, K EN YAKIN KOM�ULAR �LE SINIFLANDIRMA YAPILMI�TIR.
% TAMAMEN NURHAK ALTIN TARAFINDAN YAZILMI�TIR.
% K DE�ER� 3 VE 5 OLARAK ALINIP SONU�LAR KAYDED�LM��T�R.
% BU KOD PREDICTED VE PREDICTEDN_5 OLARAK �K� SONU� VERM��T�R.K DE�ER�NE G�RE SONU� DE���MEKTED�R. PREDICTED K=3 DE�ER� ���N PREDICTED_5 K=5 DE�ER� ���ND�R.

clc;
clear all;
close all;

% DATALAR Y�KLEND�
load('Indian_pines_gt.mat');
load('Indian_pines.mat');

% E��T�M VER�S� OLU�TURMAK ���N VE %10 A KARAR VEREB�LMEK ���N MATR�SLER
% OLU�TURULDU.
label=zeros(2,16);
egitim = zeros(1,16);

% K DE�ER� KULLANICIDAN ALINDI
prompt='K Degerini Giriniz=';
k_value=input(prompt);

% ET�KETLER OLU�TURULDU 0 ALINMAYACA�I ���N 1 DEN 15 E KADAR
for i=1:16
    label(1,i)=i;
end

% ANA VER�DE KA� TANE AYNI LABELDEN OLDU�U SAYILDI VE LABEL MATR�S�NE
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

%E��T�M VER�S� %10 OLMASI GEREKT��� ���N SAYILAR HESAPLANDI VE E��T�M
%MATR�S�NE ATILDI
for i=1:16
    egitim(1,i)=uint8(label(2,i)/10);
end

%RANDOM OLARAK HER LABEL ���N BEL�RLENEN %10 LUK VER� KADAR VER�LER�N
%KOORD�NATLARI VE LABELLARI SONUC MATR�S�NE ATILDI
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


%KOORD�NATLARI VER�LER VER�LER�N ANA MATR�STEN VEKT�RLER� ALINARAK E��T�M
%K�MES� OLU�TURULDU.
final_egitim=zeros(1027,220);
for i=1:1027
  for j=1:220
  final_egitim(i,j)=indian_pines(sonuc(2,i),sonuc(3,i),j);
  end
end

%SINIFLANDIRMA SONU�ALRI ���N MATR�S OLU�TURULDU.
predicted_5=zeros(145,145);

%SIRALAMALAR VE �KL�D UZAKLI�I ���N MATR�S OLU�TURULDU
count=0;
g=zeros(1027,2);
k_array=zeros(k_value,2);

for row=1:145
  for col=1:145
    for l=1:1027
        count=count+1;
        %�KL�D UZAKLIK HESAPLANDI
        g(count,1)=sqrt(sum((indian_pines(row,col,:) - final_egitim(l)) .^ 2));
%        g(count,1)=pdist2(indian_pines(row,col),final_egitim(l));
        g(count,2)=sonuc(1,l);
        %UZAKLIKLAR SIRALANDI
        B=sortrows(g,1);
        
        %K DE�ER� NE KADAR AYRI B�R MATR�SE ALINDI
        for i=1:k_value
            k_array(i,1)=B(i,1);
            k_array(i,2)=B(i,2);
            %EN �OK TEKRAR EDEN LABEL SONU� OLARAK BULUNDU VE ATILDI.
            sorted=mode(k_array());
%             predicted_5(row,col)=sorted(2);
        end
    end
    count=0;
  end
end


