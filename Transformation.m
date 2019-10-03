classdef Transformation
    % Transformation Top-level class with static methods for matrix transformations
    %   This class contains useful static methods for matrix rotations,
    %   primarily rotate() and translate(). These methods just instantiate
    %   a TransformationBuilder with the respective mode set.
    enumeration
        TRANSLATE
        ROTATE
        SCALE
        NONE
    end
    
    methods(Static)
        function ret = rotate(mat)
            % rotate Instantiates a TransformationBuilder object
            %   Creates a new TransformationBuilder object with the 
            %   provided matrix and sets it to ROTATE mode. If no matrix is 
            %   specified, eye(4) is used.
            %
            % Returns: A TransformationBuilder instance
            
            if nargin == 0
                mat = eye(4);
            end
            
            ret = TransformationBuilder(mat, true, Transformation.ROTATE);
        end
        
        function ret = r(mat)
            % r Shorthand for .rotate()
            % See ROTATE
            
            if nargin == 0
                mat = eye(4);
            end
            
            ret = Transformation.rotate(mat);
        end
        
        function ret = translate(mat)
            % translate Instantiates a TransformationBuilder object
            %   Creates a new TransformationBuilder object with the 
            %   provided matrix and sets it to TRANSLATE mode. If no matrix
            %   is specified, eye(4) is used.
            %
            % Returns: A TransformationBuilder instance
            
            if nargin == 0
                mat = eye(4);
            end
            
            ret = TransformationBuilder(mat, true, Transformation.TRANSLATE);
        end
        
        function ret = t(mat)
            % t Shorthand for .translate()
            % See TRANSLATE
            
            if nargin == 0
                mat = eye(4);
            end
            
            ret = Transformation.translate(mat);
        end
        
        function ret = scale(mat)
            % scale Instantiates a TransformationBuilder object
            %   Creates a new TransformationBuilder object with the 
            %   provided matrix and sets it to SCALE mode. If no matrix is 
            %  specified, eye(4) is used.
            %
            % Returns: A TransformationBuilder instance
            
            if nargin == 0
                mat = eye(4);
            end
            
            ret = TransformationBuilder(mat, true, Transformation.SCALE);
        end
        
        function ret = s(mat)
            % s Shorthand for .scale()
            % See SCALE
            
            if nargin == 0
                mat = eye(4);
            end
            
            ret = Transformation.scale(mat);
        end
    end
end

