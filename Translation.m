classdef Translation
    % Translation Used to calculate translation (SE(3)) matrices
    %
    %   A collection of static methods to calculate SE(3) translation 
    %   matrices given a distance.
    
    methods(Static)
        function ret = x(n)
            % x Returns the SE(3) matrix to translate along the x axis
            %
            % Parameters:
            %   n - The amount to translate along the x axis
            %
            % Returns: An SE(3) matrix
            
            ret = [
                1 0 0 n
                0 1 0 0
                0 0 1 0
                0 0 0 1
            ];
        end
        
        function ret = y(n)
            % y Returns the SE(3) matrix to translate along the y axis
            %
            % Parameters:
            %   n - The amount to translate along the y axis
            %
            % Returns: An SE(3) matrix
            
            ret = [
                1 0 0 0
                0 1 0 n
                0 0 1 0
                0 0 0 1
            ];
        end
        
        function ret = z(n)
            % z Returns the SE(3) matrix to translate along the z axis
            %
            % Parameters:
            %   n - The amount to translate along the z axis
            %
            % Returns: An SE(3) matrix
            
            ret = [
                1 0 0 0
                0 1 0 0 
                0 0 1 n
                0 0 0 1
            ];
        end
    end
end

