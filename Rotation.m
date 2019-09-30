classdef Rotation
    % Rotation Used to calculate rotation (SO(3)/SE(3)) matrices
    %
    % Calculates rotation matrices in 3-space in either locale or global
    % coordinate frame. Contains useful static methods for calculating
    % single rotation matrices, as well as methods for easy access to the
    % RotationBuilder class.
    
    methods(Static)
        function obj = loc(mat)
            % loc Returns a rotation builder in local frame mode
            %
            %   Returns an instance of RotationBuilder with is_local =
            %   true.
            %
            % Parameters:
            %   mat - A square matrix. If the matrix is of length 3, it
            %         represents an SO(3) matrix. If the matrix is of
            %         length 4, it represents an SE(3) matrix. If no matrix
            %         is supplies, eye(3) is used as a default.
            % 
            % Returns: A RotationBuilder instance
            
            if nargin == 0
                mat = eye(3);
            elseif length(mat) ~= length(mat(1, :)) || (length(mat) ~= 3 && length(mat) ~= 4)
                error('Matrix must be a 3x3 or 4x4 matrix');
            end
            
            obj = RotationBuilder(mat, true);
        end
        
        function obj = glob(mat)
            % glob Returns a rotation builder in global frame mode
            %
            %   Returns an instance of RotationBuilder with is_local =
            %   false.
            %
            % Parameters:
            %   mat - A square matrix. If the matrix is of length 3, it
            %         represents an SO(3) matrix. If the matrix is of
            %         length 4, it represents an SE(3) matrix. If no matrix
            %         is supplies, eye(3) is used as a default.
            % 
            % Returns: A RotationBuilder instance
            
            if nargin == 0
                mat = eye(3);
            elseif length(mat) ~= length(mat(1, :)) || (length(mat) ~= 3 && length(mat) ~= 4)
                error('Matrix must be a 3x3 or 4x4 matrix');
            end
            
            obj = RotationBuilder(mat, false);
        end
        
        function mat = x(angle, dim)
            % x Returns an x rotation matrix
            %
            %   Calculates a rotation matrix given the angle and dimension
            %
            % Parameters:
            %   angle - The angle in radians to rotate about the x axis
            %   dim   - The dimensions of the returns matrix. Must be 3
            %           (for an SO(3) matrix) or 4 (for an SE(3) matrix)
            %
            % Returns: A rotation matrix with the specified parameters
            %
            % See XD
            
            if nargin == 1
                dim = 3;
            elseif dim ~= 3 && dim ~= 4
                error('dim must be 3 or 4');
            end
            
            if dim == 3
                mat = [
                    1 0           0
                    0 cos(angle) -sin(angle)
                    0 sin(angle)  cos(angle)
                ];
            elseif dim == 4
                mat = [
                    1 0           0           0
                    0 cos(angle) -sin(angle)  0
                    0 sin(angle)  cos(angle)  0
                    0 0           0           1
                ];
            end
        end
        
        function mat = y(angle, dim)
            % y Returns a y rotation matrix
            %
            %   Calculates a rotation matrix given the angle and dimension
            %
            % Parameters:
            %   angle - The angle in radians to rotate about the y axis
            %   dim   - The dimensions of the returns matrix. Must be 3
            %           (for an SO(3) matrix) or 4 (for an SE(3) matrix)
            %
            % Returns: A rotation matrix with the specified parameters
            %
            % See YD
            
            if nargin == 1
                dim = 3;
            elseif dim ~= 3 && dim ~= 4
                error('dim must be 3 or 4');
            end
            
            if dim == 3
                mat = [
                     cos(angle)  0 sin(angle)
                     0           1 0
                    -sin(angle)  0 cos(angle)
                ];
            elseif dim == 4
                mat = [
                    cos(angle)  0 sin(angle) 0
                    0           1 0          0
                    -sin(angle) 0 cos(angle) 0
                    0           0 0          1
                ];
            end
        end
        
        function mat = z(angle, dim)
            % x Returns a z rotation matrix
            %
            %   Calculates a rotation matrix given the angle and dimension
            %
            % Parameters:
            %   angle - The angle in radians to rotate about the z axis
            %   dim   - The dimensions of the returns matrix. Must be 3
            %           (for an SO(3) matrix) or 4 (for an SE(3) matrix)
            %
            % Returns: A rotation matrix with the specified parameters
            %
            % See ZD
            
            if nargin == 1
                dim = 3;
            elseif dim ~= 3 && dim ~= 4
                error('dim must be 3 or 4');
            end
            
            if dim == 3
                mat = [
                    cos(angle) -sin(angle)  0
                    sin(angle)  cos(angle)  0
                    0           0           1
                ];
            elseif dim == 4
                mat = [
                    cos(angle) -sin(angle)  0 0
                    sin(angle)  cos(angle)  0 0
                    0           0           1 0
                    0           0           0 1
                ];
            end
        end
        
        function mat = xd(angle)
            % xd Returns an x rotation matrix
            %
            %   Calculates a rotation matrix given the angle and dimension
            %
            % Parameters:
            %   angle - The angle in degrees to rotate about the x axis
            %   dim   - The dimensions of the returns matrix. Must be 3
            %           (for an SO(3) matrix) or 4 (for an SE(3) matrix)
            %
            % Returns: A rotation matrix with the specified parameters
            %
            % See X
            
            mat = Rotation.x(angle * pi / 180);
        end
        
        function mat = yd(angle)
            % yd Returns a y rotation matrix
            %
            %   Calculates a rotation matrix given the angle and dimension
            %
            % Parameters:
            %   angle - The angle in degrees to rotate about the y axis
            %   dim   - The dimensions of the returns matrix. Must be 3
            %           (for an SO(3) matrix) or 4 (for an SE(3) matrix)
            %
            % Returns: A rotation matrix with the specified parameters
            %
            % See Y
            
            mat = Rotation.y(angle * pi / 180);
        end
        
        function mat = zd(angle)
            % zd Returns a z rotation matrix
            %
            %   Calculates a rotation matrix given the angle and dimension
            %
            % Parameters:
            %   angle - The angle in degrees to rotate about the z axis
            %   dim   - The dimensions of the returns matrix. Must be 3
            %           (for an SO(3) matrix) or 4 (for an SE(3) matrix)
            %
            % Returns: A rotation matrix with the specified parameters
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