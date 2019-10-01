classdef Rotation
    % Rotation Used to calculate rotation (SE(3)) matrices
    %
    %   A collection of static methods to calculate SE(3) rotation matrices
    %   given an angle in radians or degrees, as well as some utility 
    %   methods for dealing with axis angles.
    
    methods(Static)
        function mat = x(angle)
            % x Returns an x rotation matrix
            %
            %   Calculates a rotation matrix given the angle in radians
            %
            % Parameters:
            %   angle - The angle in radians to rotate about the x axis
            %
            % Returns: A rotation matrix with the specified angle
            %
            % See XD
            
            mat = [
                1 0           0           0
                0 cos(angle) -sin(angle)  0
                0 sin(angle)  cos(angle)  0
                0 0           0           1
            ];
        end
        
        function mat = y(angle)
            % y Returns an y rotation matrix
            %
            %   Calculates a rotation matrix given the angle in radians
            %
            % Parameters:
            %   angle - The angle in radians to rotate about the y axis
            %
            % Returns: A rotation matrix with the specified angle
            %
            % See YD
            
            mat = [
                cos(angle)  0 sin(angle) 0
                0           1 0          0
                -sin(angle) 0 cos(angle) 0
                0           0 0          1
            ];
        end
        
        function mat = z(angle)
            % z Returns an z rotation matrix
            %
            %   Calculates a rotation matrix given the angle in radians
            %
            % Parameters:
            %   angle - The angle in radians to rotate about the z axis
            %
            % Returns: A rotation matrix with the specified angle
            %
            % See ZD
            
            mat = [
                cos(angle) -sin(angle)  0 0
                sin(angle)  cos(angle)  0 0
                0           0           1 0
                0           0           0 1
            ];
        end
        
        function mat = xd(angle)
            % x Returns an x rotation matrix
            %
            %   Calculates a rotation matrix given the angle in degrees
            %
            % Parameters:
            %   angle - The angle in degrees to rotate about the x axis
            %
            % Returns: A rotation matrix with the specified angle
            %
            % See X
            
            mat = Rotation.x(angle * pi / 180);
        end
        
        function mat = yd(angle)
            % y Returns an y rotation matrix
            %
            %   Calculates a rotation matrix given the angle in degrees
            %
            % Parameters:
            %   angle - The angle in degrees to rotate about the y axis
            %
            % Returns: A rotation matrix with the specified angle
            %
            % See Y
            
            mat = Rotation.y(angle * pi / 180);
        end
        
        function mat = zd(angle)
            % z Returns an z rotation matrix
            %
            %   Calculates a rotation matrix given the angle in degrees
            %
            % Parameters:
            %   angle - The angle in degrees to rotate about the z axis
            %
            % Returns: A rotation matrix with the specified angle
            %
            % See Z
            
            mat = Rotation.z(angle * pi / 180);
        end
        
        function mat = axis2mat(k, theta)
            % axis2mat Converts an axis angle to an SO(3) matrix
            %  
            % Parameters:
            %   k     - The unit vector about which to rotate theta radians
            %   theta - The number of radians to rotate about k
            %
            % Returns: An SO(3) matrix corresponding to the given k and
            %          theta arguments
            
            kx = k(0);
            ky = k(1);
            kz = k(2);
            c = cos(theta);
            s = sin(theta);
            v = 1 - c;

            mat = [
                (kx ^ 2 * v + c)       (kx * ky * v - kz * s) (kx * kz * v + ky * s)
                (kx * ky * v + kz * s) (ky^2 * v + c)         (ky * kz * v - kx * s)
                (kx * kz * v - ky * s) (ky * kz * v + kx * s) (kz ^ 2 * v + c)
            ];
        end
        
        function [k, theta] = mat2axis(mat)
            % mat2axis Converts an SO(3) matrix to an axis angle
            %
            % Parameters:
            %   mat - An SO(3) matrix 
            %
            % Returns:
            %   k     - A unit vector about which to rotate
            %   theta - An amount in radians to rotate about k
            
            theta = acos((trace(mat(1:3, 1:3)) - 1) / 2);
            k = (1 / (2 * sin(theta))) .* [
                mat(3, 2) - mat(2, 3)
                mat(1, 3) - mat(3, 1)
                mat(2, 1) - mat(1, 2)
            ];
        end
    end
end