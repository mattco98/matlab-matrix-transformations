classdef Transformation
    % Transformation Top-level class with static methods for matrix transformations
    %   This class contains useful static methods for matrix rotations,
    %   primarily rotate() and translate(). These methods just instantiate
    %   a RotationBuilder or TranslationBuilder, respectively.
    
    methods(Static)
        function ret = rotate(mat)
            % rotate Instantiates a RotationBuilder object
            %   Creates a new RotationBuilder object wit the provided
            %   matrix. If no matrix is specified, eye(4) is used.
            %
            % Returns: A RotationBuilder instance
            
            if nargin == 0
                mat = eye(4);
            end
            
            ret = RotationBuilder(mat, true);
        end
        
        function ret = translate(mat)
            % translate Instantiates a TranslationBuilder object
            %   Creates a new TranslationBuilder object wiht the provided
            %   matrix. If no matrix is specified, eye(4) is used.
            %
            % Returns: A TranslationBuilder instance
            
            if nargin == 0
                mat = eye(4);
            end
            
            ret = TranslationBuilder(mat, true);
        end
        
        function ret = pad4(mat)
            % pad4 Pads a matrix with an extra row
            %   Takes a 3-row matrix and adds a row to make it a 4-row
            %   matrix, where the new row is [zeros(1, length(mat - 1) 1]
            %
            % Returns: A matrix
            
            ret = [mat; zeros(1, length(mat) - 1) 1];
        end
    end
end

