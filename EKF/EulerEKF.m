% ## Copyright (C) 2020 PetarHlad
% ## 
% ## This program is free software: you can redistribute it and/or modify it
% ## under the terms of the GNU General Public License as published by
% ## the Free Software Foundation, either version 3 of the License, or
% ## (at your option) any later version.
% ## 
% ## This program is distributed in the hope that it will be useful, but
% ## WITHOUT ANY WARRANTY; without even the implied warranty of
% ## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% ## GNU General Public License for more details.
% ## 
% ## You should have received a copy of the GNU General Public License
% ## along with this program.  If not, see
% ## <https://www.gnu.org/licenses/>.
% 
% ## -*- texinfo -*- 
% ## @deftypefn {} {@var{retval} =} EulerEKF (@var{input1}, @var{input2})
% ##
% ## @seealso{}
% ## @end deftypefn
% 
% ## Author: PetarHlad <PetarHlad@DESKTOP-67A4CMH>
% ## Created: 2020-01-23

function [phi theta psi] = EulerEKF (z, rates, dt)
  
  persistent H Q R
  persistent x P
  persistent firstRun
  
  
  if isempty(firstRun)
    H = [ 1 0 0;
          0 1 0 ];
    
    Q = [0.1 0      0;
         0      0.1 0;
         0      0      0.1 ];
    
    R = [ 6 0;
          0 6 ];
    
    x = [0 0 0]';
    P = 10*eye(3);
    
    firstRun = 1;
  end
  
  F = Fjacob(x, rates, dt);
  
  xp = fx(x, rates, dt);
  Pp = F*P*F' + Q;
  
  K = Pp*H'*inv(H*Pp*H' + R);
  
  x = xp + K*(z - H*xp);
  P = Pp - K*H*Pp;
  
  phi   = x(1);
  theta = x(2);
  psi   = x(3);

end 
%-------------------------------------------------------------------------------
function xp = fx(xhat, rates, dt)
   
   phi   = xhat(1);
   theta = xhat(2);
   
   p = rates(1);
   q = rates(2);
   r = rates(3);
   
   xdot = zeros(3,1);
   xdot(1) = p + q*sin(phi)*tan(theta) + r*cos(phi)*tan(theta);
   xdot(2) =     q*cos(phi)            - r*sin(phi);
   xdot(3) =     q*sin(phi)*sec(theta) + r*cos(phi)*sec(theta);
   
   xp = xhat + xdot*dt;
   
end

%-------------------------------------------------------------------------------
function F = Fjacob(xhat, rates, dt)
  
  F = zeros(3,3);
  
  phi   = xhat(1);
  theta = xhat(2);
  
  p = rates(1);
  q = rates(2);
  r = rates(3);
  
  F(1,1) = q*cos(phi)*tan(theta)    - r*sin(phi)*tan(theta);
  F(1,2) = q*sin(phi)*sec(theta)^2 + r*cos(phi)*sec(theta)^2;
  F(1,3) = 0;
  
  F(2,1) = -q*sin(phi) - r*cos(phi);
  F(2,2) = 0;
  F(2,3) = 0;
  
  F(3,1) = q*cos(phi)*sec(theta)            - r*sin(phi)*sec(theta);
  F(3,2) = q*sin(phi)*sec(theta)*tan(theta) + r*cos(phi)*sec(theta)*tan(theta);
  F(3,3) = 0;
  
  F = eye(3) + F*dt;
end
