function [jing_chengben]=zuanjing_chengben1(Djinchi) 
if Djinchi<=5000 %Djinchi<5000m
        jing_chengben(idx)=6419249+1682.6937*Djinchi+0.3024432575*Djinchi^2 + 0.0000072470369*Djinchi^3-0.0000059816812*Djinchi^2*DA+859.21936*DA-0.253570107*Djinchi*DA+0.1362177047*DA^2+0.0000029908406*Djinchi*DA^2 ;

    elseif Djinchi<=7000     %5000m<Djinchi<7000m
        jing_chengben(idx)=7477591+1523.8474*Djinchi+0.3406464357*Djinchi^2+0.0000072470369*Djinchi^3-0.0000059816812*Djinchi^2*DA+958.66891*DA-0.285102889*Djinchi*DA+0.1519840957*DA^2+0.0000029908406*Djinchi*DA^2;

   elseif  Djinchi>7000 
        jing_chengben(idx) = 10e10;
    end    
end