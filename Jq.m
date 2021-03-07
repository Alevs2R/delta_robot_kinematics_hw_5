function [ Result ] = Jq(q, q_passive, L)
 
     a1 = 0.0;
     a2 = 2*pi/3;  % угол 2 ноги на базе
     a3 = -2*pi/3; % угол 3 ноги на базе

     q1_1 = q(1);
     q1_2 = q(2);
     q1_3 = q(3);

     q2_1 = q_passive(1,1);
     q2_2 = q_passive(1,2);
     q2_3 = q_passive(1,3);

     q3_1 = q_passive(2,1);
     q3_2 = q_passive(2,2);
     q3_3 = q_passive(2,3); 

     Jz = [
          Jz_leg(q1_1, q2_1, q3_1, a1);
          Jz_leg(q1_2, q2_2, q3_2, a2);
          Jz_leg(q1_3, q2_3, q3_3, a3);
     ];

     Jtheta = [
          L.bicep_length*sin(q2_1)*cos(q3_1) 0 0;
          0 L.bicep_length*sin(q2_2)*cos(q3_2) 0;
          0 0 L.bicep_length*sin(q2_3)*cos(q3_3);
     ];

     Result = inv(Jtheta)*Jz;
