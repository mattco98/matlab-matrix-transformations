classdef Translation
    % Translation Used to calculate translation (SE(3)) matrices
    %
    % Calculates translation matrices in 3-space in either locale or global
    % coordinate frame. Contains useful static methods for calculating
    % single translation matrices.
    
    methods(Static)
        function ret = builder(matrix)
            % builder Returns an instance of the TranslationBuilder
            % 
            %   This method exists mostly to keep consistency with
            %   Rotation, which has the .loc() and .glob() methods
            %   which return instances of RotationBuilder. This method
            %   allows access to the TranslationBuilder without having to
            %   construct one manually or go through the Transformation
            %   class.
            %
            % Parameters:
            %   matrix - A matrix to provide to the TranslationBuilder
            %            instance. If none is provided, eye(4) is used.
            %
            % Returns: A TranslationBuilder instance
            if nargin == 0
                matrix = eye(4);
            end
            
            ret = TranslationBuilder(matrix);
        end
        
        function ret = loc(matrix)
            % loc Returns an instance of the TranslationBuilder
            %
            %   This method only exist to keep consistency between
            %   TranslationBuilder and RotationBuilder.
            if nargin == 0
                matrix = eye(4);
            end
            
            ret = TranslationBuilder(matrix);
        end
        
        function ret = glob(matrix)
            % glob Returns an instance of the TranslationBuilder
            %
            %   This method only exist to keep consistency between
            %   TranslationBuilder and RotationBuilder.
            if nargin == 0
                matrix = eye(4);
            end
            
            ret = TranslationBuilder(matrix);
        end
        
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

