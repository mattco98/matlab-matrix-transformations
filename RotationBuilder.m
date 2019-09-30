classdef RotationBuilder
    % RotationBuilder A builder class for matrix rotations
    %
    %   This class should not be instantiated directly. Rather, the methods
    %   provided by the Transformation and Rotation class should be used.
    
    properties
        is_local
        mat
        rotations
    end
    
    methods
        function obj = RotationBuilder(matrix, is_local)
            obj.is_local = is_local;
            obj.mat = matrix;
            obj.rotations = [];
        end
        
        function ret = translate(obj)
            % translate Switch to translations
            %
            %   This method allows one to start providing translations
            %   instead of rotations. All of the rotations up until this
            %   point are combined into one, and the result is passed to a
            %   TranslationBuilder instance.
            %
            % Returns: A TranslationBuilder instance
            
            ret = TranslationBuilder(obj.finish().mat, obj.is_local);
        end
        
        function ret = loc(obj)
            % loc Switches to local frame rotations
            %
            % Returns: The object for method chaining
            
            obj.is_local = true;
            ret = obj;
        end
        
        function ret = glob(obj)
            % glob Switches to global frame rotations
            %
            % Returns: The object for method chaining
            
            obj.is_local = false;
            ret = obj;
        end
        
        function ret = x(obj, n)
            % x Appends a rotation about the x axis to the list of current
            % rotations.
            %
            %   This rotation respects the current is_local setting
            %
            % Parameters:
            %   n - The amount of radians to rotate about the x axis
            %
            % Returns: The object for method chaining
            
            obj.rotations(end + 1).local = obj.is_local;
            obj.rotations(end).direction = Direction.X;
            obj.rotations(end).amount = n;
            
            ret = obj;
        end
        
        function ret = y(obj, n)
            % y Appends a rotation about the y axis to the list of current
            % rotations.
            %
            %   This rotation respects the current is_local setting
            %
            % Parameters:
            %   n - The amount of radians to rotate about the y axis
            %
            % Returns: The object for method chaining
            
            obj.rotations(end + 1).local = obj.is_local;
            obj.rotations(end).direction = Direction.Y;
            obj.rotations(end).amount = n;
            
            ret = obj;
        end
        
        function ret = z(obj, n)
            % x Appends a rotation about the z axis to the list of current
            % rotations.
            %
            %   This rotation respects the current is_local setting
            %
            % Parameters:
            %   n - The amount of radians to rotate about the z axis
            %
            % Returns: The object for method chaining
            
            obj.rotations(end + 1).local = obj.is_local;
            obj.rotations(end).direction = Direction.Z;
            obj.rotations(end).amount = n;
            
            ret = obj;
        end
        
        function ret = xd(obj, n)
            % x Appends a rotation about the x axis in degrees to the list
            % of current rotations.
            %
            %   This rotation respects the current is_local setting
            %
            % Parameters:
            %   n - The amount of degrees to rotate about the x axis
            %
            % Returns: The object for method chaining
            
            obj = obj.x(n * pi / 180);
            ret = obj;
        end
        
        function ret = yd(obj, n)
            % x Appends a rotation about the y axis in degrees to the list
            % of current rotations.
            %
            %   This rotation respects the current is_local setting
            %
            % Parameters:
            %   n - The amount of degrees to rotate about the y axis
            %
            % Returns: The object for method chaining
            
            obj = obj.y(n * pi / 180);
            ret = obj;
        end
        
        function ret = zd(obj, n)
            % x Appends a rotation about the z axis in degrees to the list
            % of current rotations.
            %
            %   This rotation respects the current is_local setting
            %
            % Parameters:
            %   n - The amount of degrees to rotate about the z axis
            %
            % Returns: The object for method chaining
            
            obj = obj.z(n * pi / 180);
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
            
            obj = obj.finish();
            ret = obj.mat * target;
        end
        
        function ret = matrix3(obj, target)
            % matrix Calculates the pure rotation matrix
            %
            %   This method is similar to the "matrix" method, except that
            %   it returns the pure SO(3) rotation matrix, or the result
            %   matrix if the target parameter was supplied.
            %
            % Parameters:
            %   target - An optional matrix to be multiplied by the
            %            calculated rotation matrix. Defaults to
            %            eye(length(rotation_matrix)).
            %
            % Returns: The rotation matrix, or the result matrix if a
            %          matrix was supplied to the method.
            
            if nargin == 1
                target = eye(3);
            end
            
            obj = obj.finish();
            ret = obj.mat(1:3, 1:3) * target;
        end
        
        function [k, theta] = axis(obj)
            % axis Calculates the axis angle represented by this rotation
            %
            %   This method effectively "finishes" the rotation, returning
            %   the unit vector and theta radian rotation. 
            %
            %   If this RotationBuilder instance does not represent a pure
            %   rotation, that is, the transformation at some point
            %   received some translation via the TranslationBuilder,
            %   then this method will throw an error. Axis angles only make
            %   sense when talking about pure rotations.
            %
            % Returns:
            %   k     - A unit vector about which to rotate
            %   theta - An amount in radians to rotate about k
            %
            % See AXISD
            
            obj = obj.finish();
            
            if length(obj.mat) == 4 && any(obj.mat(1:4, 4) ~= 0)
                error('Cannot create axis rotation for SE(3) matrix with translation component');
            end
            
            [kT, thetaT] = Rotation.mat2axis(obj.mat);
            k = kT;
            theta = thetaT;
        end
        
        function [k, theta] = axisd(obj)
            % axis Calculates the axis angle represented by this rotation
            %
            %   This method effectively "finishes" the rotation, returning
            %   the unit vector and theta degree rotation. 
            %
            %   If this RotationBuilder instance does not represent a pure
            %   rotation, that is, the transformation at some point
            %   received some translation via the TranslationBuilder,
            %   then this method will throw an error. Axis angles only make
            %   sense when talking about pure rotations.
            %
            % Returns:
            %   k     - A unit vector about which to rotate
            %   theta - An amount in degrees to rotate about k
            %
            % See AXIS
            
            obj = obj.finish();
            
            if length(obj.mat) == 4 && any(obj.mat(1:4, 4) ~= 0)
                error('Cannot create axis rotation for SE(3) matrix with translation component');
            end
            
            [kT, thetaT] = Rotation.mat2axis(obj.mat);
            k = kT;
            theta = thetaT * 180 / pi;
        end
    end
    
    methods(Access=private)
        function ret = finish(obj)
            % Step 1: Loop through list of rotations from last to first and
            % apply any global rotations
            for i = length(obj.rotations):-1:1
                s = obj.rotations(i);
                
                if ~s.local
                    obj.mat = obj.mat * RotationBuilder.get_rotation(...
                        s.direction, s.amount, length(obj.mat));
                    % When applied, remove the rotation from the list
                    obj.rotations(i) = [];
                end
            end
            
            % Step 2: Loop through the list of rotations from first to last
            % and apply the local rotations
            for i = 1:length(obj.rotations)
                s = obj.rotations(i);
                obj.mat = obj.mat * RotationBuilder.get_rotation(...
                    s.direction, s.amount, length(obj.mat));
            end
            
            ret = obj;
        end
    end
    
    methods(Static, Access=private)
        function mat = get_rotation(dir, n, dim)
            % Utility function to get the rotation from a struct easily
            if nargin == 2
                dim = 4;
            end
            
            switch dir
                case Direction.X
                    mat = Rotation.x(n, dim);
                case Direction.Y
                    mat = Rotation.y(n, dim);
                case Direction.Z
                    mat = Rotation.z(n, dim);
            end
        end
    end
end

