classdef TranslationBuilder
    % TranslationBuilder A builder class for matrix rotations
    %
    %   This class should not be instantiated directly. Rather, the methods
    %   provided by the Transformation and Translation class should be 
    %   used.
    
    properties
        is_local
        mat
    end
    
    methods
        function obj = TranslationBuilder(matrix, is_local)
            if nargin == 1
                is_local = true;
            end
            
            obj.mat = matrix;
            obj.is_local = is_local;
        end
        
        function ret = loc(obj)
            % loc Switches to local frame translations
            %
            % Returns: The object for method chaining
            
            obj.is_local = true;
            ret = obj;
        end
        
        function ret = glob(obj)
            % glob Switches to global frame translations
            %
            % Returns: The object for method chaining
            
            obj.is_local = false;
            ret = obj;
        end
        
        function ret = rotate(obj)
            % rotate Switch to rotations
            %
            %   This method allows one to start providing rotations
            %   instead of translations. All of the translations up until
            %   this point are combined into one, and the result is passed
            %   to a RotationBuilder instance.
            %
            % Returns: A RotationBuilder instance
            
            ret = RotationBuilder(obj.mat, obj.is_local);
        end
        
        function ret = x(obj, n)
            % x Applies a translation along the x axis to the
            % transformation matrix.
            %
            %   This rotation respects the current is_local setting
            %
            % Parameters:
            %   n - The distance to translate along the x axis
            %
            % Returns: The object for method chaining
            
            if obj.is_local
                obj.mat = obj.mat * Translation.x(n);
            else
                obj.mat(1, end) = obj.mat(1, end) + n;
            end
            ret = obj;
        end
        
        function ret = y(obj, n)
            % y Applies a translation along the y axis to the
            % transformation matrix.
            %
            %   This rotation respects the current is_local setting
            %
            % Parameters:
            %   n - The distance to translate along the y axis
            %
            % Returns: The object for method chaining
            
            if obj.is_local
                obj.mat = obj.mat * Translation.y(n);
            else
                obj.mat(2, end) = obj.mat(2, end) + n;
            end
            ret = obj;
        end
        
        function ret = z(obj, n)
            % z Applies a translation along the z axis to the
            % transformation matrix.
            %
            %   This rotation respects the current is_local setting
            %
            % Parameters:
            %   n - The distance to translate along the z axis
            %
            % Returns: The object for method chaining
            
            if obj.is_local
                obj.mat = obj.mat * Translation.z(n);
            else
                obj.mat(3, end) = obj.mat(3, end) + n;
            end
            ret = obj;
        end
        
        function ret = matrix(obj, target)
            % matrix Calculates the transformation matrix
            %
            %   This method effectively "finishes" the transformation,
            %   calculating the transformation matrix and returning it. If
            %   a target matrix is provided, it will automatically be
            %   multiplied by the transformation matrix, and the result
            %   will be returned.
            %
            % Parameters:
            %   target - An optional matrix to be multiplied by the
            %            calculated transformation matrix. Defaults to
            %            eye(length(transformation_matrix)).
            %
            % Returns: The transformation matrix, or the result matrix if a
            %          matrix was supplied to the method.
            
            if nargin == 1
                target = eye(length(obj.mat));
            end
            
            ret = obj.mat * target;
        end
    end
end

