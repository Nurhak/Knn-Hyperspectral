% NURHAK ALTIN KCOAEL� �N�VERS�TES� ELEKTRON�K VE HABERLE�ME M�HEND�SL��� 3.SINIF 2.��RET�M 130208014
% UZAKTAN ALGILAMA TEKNOLOJ�LER� DERS� PROJES�
% AVIRIS Indian Pine H�PERSPEKTRAL VER� K�MES� ���N, K EN YAKIN KOM�ULAR �LE SINIFLANDIRMA YAPILMI�TIR.
% TAMAMEN NURHAK ALTIN TARAFINDAN YAZILMI�TIR.
% K DE�ER� 3 VE 5 OLARAK ALINIP SONU�LAR KAYDED�LM��T�R.


%SONU�LAR VE GROUNDTRUTH Y�KLEND�
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



