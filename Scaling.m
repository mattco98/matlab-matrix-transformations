classdef Scaling
    % Scaling Used to calculate scaling (SE(3)) matrices
    %
    %   A collection of static methods to calculate SE(3) scaling 
    %   matrices given a scale factor.
    
    methods(Static)
        function ret = x(n)
            % x Returns the SE(3) matrix to scale along the x axis
            %
            % Parameters:
            %   n - The amount to scale along the x axis
            %
            % Returns: An SE(3) matrix
            
            ret = [
                n 0 0 0
                0 1 0 0
                0 0 1 0
                0 0 0 1
            ];
        end
        
        function ret = y(n)
            % y Returns the SE(3) matrix to scale along the y axis
            %
            % Parameters:
            %   n - The amount to scale along the y axis
            %
            % Returns: An SE(3) matrix
            
            ret = [
                1 0 0 0
                0 n 0 0
                0 0 1 0
                0 0 0 1
            ];
        end
        
        function ret = z(n)
            % z Returns the SE(3) matrix to scale along the z axis
            %
            % Parameters:
            %   n - The amount to scale along the z axis
            %
            % Returns: An SE(3) matrix
            
            ret = [
                1 0 0 0
                0 1 0 0
                0 0 n 0
                0 0 0 1
            ];
        end
    end
end