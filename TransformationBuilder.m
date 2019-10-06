classdef TransformationBuilder
    % TransformationBuilder The builder class for matrix transformations
    %
    %   This class is responsible for handling all matrix transformation
    %   chains. This class should not be instantiated directly. Instead,
    %   use one of the static methods in the Transformation class to obtain
    %   and instance.
    
    properties
        mode
        is_local
        mat
    end
    
    methods
        function obj = TransformationBuilder(matrix, is_local, mode)
            obj.mode = mode;
            obj.is_local = is_local;
            obj.mat = matrix;
        end
        
        function ret = rotate(obj)
            % rotate Sets the mode to ROTATE
            %
            %   Any transformations specified will be interpreted as
            %   rotations until another mode changing method is called.
            %
            % Returns: The object for method chaining.
            
            obj.mode = Transformation.ROTATE;
            ret = obj;
        end
        
        function ret = r(obj)
            % r Shorthand for .rotate()
            % See ROTATE
            ret = obj.rotate();
        end
            
        
        function ret = translate(obj)
            % translate Sets the mode to TRANSLATE
            %
            %   Any transformations specified will be interpreted as
            %   translate until another mode changing method is called.
            %
            % Returns: The object for method chaining.
            
            obj.mode = Transformation.TRANSLATE;
            ret = obj;
        end
        
        function ret = t(obj)
            % t Shorthand for .translate()
            % See TRANSLATE
            ret = obj.translate();
        end
        
        function ret = scale(obj)
            % translate Sets the mode to SCALE
            %
            %   Any transformations specified will be interpreted as
            %   scaling until another mode changing method is called.
            %
            % Returns: The object for method chaining.
            
            obj.mode = Transformation.SCALE;
            ret = obj;
        end
        
        function ret = s(obj)
            % s Shorthand for .scale()
            % See SCALE
            ret = obj.scale();
        end
        
        function ret = loc(obj)
            % loc Sets the reference frame to local mode
            %
            %   Any transformation specified will be interpreted in
            %   reference to the local frame until glob() is called.
            %
            % Returns: The object for method chaining.
            obj.is_local = true;
            ret = obj;
        end
        
        function ret = l(obj)
            % l Shorthand for .loc()
            % see LOC
            ret = obj.loc();
        end
        
        function ret = glob(obj)
            % glob Sets the reference frame to global mode
            %
            %   Any transformation specified will be interpreted in
            %   reference to the global frame until loc() is called.
            %
            % Returns: The object for method chaining.
            obj.is_local = false;
            ret = obj;
        end
        
        function ret = g(obj)
            % g Shorthand for .glob()
            % See GLOB
            ret = obj.glob();
        end
        
        function ret = x(obj, n)
            % x Creates a new transformation with respect to the X axis.
            %
            %   The exact transformation this creates depends on the mode
            %   of this TransformationBuilder instance.
            %
            % Parameters:
            %   - n: The amount, whether that be a distance, degrees, etc.
            %
            % Returns: The object for method chaining
            
            switch obj.mode
                case Transformation.TRANSLATE
                    ret = obj.apply_transform(Translation.x(n));
                case Transformation.ROTATE
                    ret = obj.apply_transform(Rotation.x(n));
                case Transformation.SCALE
                    ret = obj.apply_transform(Scaling.x(n));
                otherwise
                    error('Transformation mode is not set. Set a mode with either ".rotate()" or ".translate()"');
            end
        end
        
        function ret = xd(obj, n)
            % xd Creates a new rotation with respect to the X axis.
            %
            %   In order to use this method, the TransformationBuilder must
            %   be in rotation mode. If it is not, an error will be thrown.
            %   This is the same as calling x(n * pi / 180).
            %
            % Parameters: 
            %   - n: The amount of rotation in degrees
            %
            % Returns: The object for method chaining
            
            if obj.mode ~= Transformation.ROTATE
                error('In order to use a degree rotation, the transformation mode must be set to ROTATE');
            end
            
            ret = obj.x(n * pi / 180);
        end
        
        function ret = y(obj, n)
            % y Creates a new transformation with respect to the Y axis.
            %
            %   The exact transformation this creates depends on the mode
            %   of this TransformationBuilder instance.
            %
            % Parameters:
            %   - n: The amount, whether that be a distance, degrees, etc.
            %
            % Returns: The object for method chaining
            
            switch obj.mode
                case Transformation.TRANSLATE
                    ret = obj.apply_transform(Translation.y(n));
                case Transformation.ROTATE
                    ret = obj.apply_transform(Rotation.y(n));
                case Transformation.SCALE
                    ret = obj.apply_transform(Scaling.y(n));
                otherwise
                    error('Transformation mode is not set. Set a mode with either ".rotate()" or ".translate()"');
            end
        end
        
        function ret = yd(obj, n)
            % yd Creates a new rotation with respect to the Y axis.
            %
            %   In order to use this method, the TransformationBuilder must
            %   be in rotation mode. If it is not, an error will be thrown.
            %   This is the same as calling y(n * pi / 180).
            %
            % Parameters: 
            %   - n: The amount of rotation in degrees
            %
            % Returns: The object for method chaining
            
            if obj.mode ~= Transformation.ROTATE
                error('In order to use a degree rotation, the transformation mode must be set to ROTATE');
            end
            
            ret = obj.y(n * pi / 180);
        end
        
        function ret = z(obj, n)
            % z Creates a new transformation with respect to the Z axis.
            %
            %   The exact transformation this creates depends on the mode
            %   of this TransformationBuilder instance.
            %
            % Parameters:
            %   - n: The amount, whether that be a distance, degrees, etc.
            %
            % Returns: The object for method chaining
            
            switch obj.mode
                case Transformation.TRANSLATE
                    ret = obj.apply_transform(Translation.z(n));
                case Transformation.ROTATE
                    ret = obj.apply_transform(Rotation.z(n));
                case Transformation.SCALE
                    ret = obj.apply_transform(Scaling.z(n));
                otherwise
                    error('Transformation mode is not set. Set a mode with either ".rotate()" or ".translate()"');
            end
        end
        
        function ret = zd(obj, n)
            % zd Creates a new rotation with respect to the Z axis.
            %
            %   In order to use this method, the TransformationBuilder must
            %   be in rotation mode. If it is not, an error will be thrown.
            %   This is the same as calling Z(n * pi / 180).
            %
            % Parameters: 
            %   - n: The amount of rotation in degrees
            %
            % Returns: The object for method chaining
            
            if obj.mode ~= Transformation.ROTATE
                error('In order to use a degree rotation, the transformation mode must be set to ROTATE');
            end
            
            ret = obj.z(n * pi / 180);
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
            %            eye(4).
            %
            % Returns: The transformation matrix, or the result matrix if a
            %          matrix was supplied to the method.
            
            if nargin == 1
                target = eye(4);
            end
            
            ret = obj.mat * target;
        end
        
        function ret = m(obj, target)
            % m Shorthand for .matrix()
            % See MATRIX
            
            if nargin == 1
                target = eye(4);
            end
            
            ret = obj.matrix(target);
        end
        
        function ret = matrix3(obj, target)
            % matrix3 Calculates the pure rotation matrix
            %
            %   This method is similar to the "matrix" method, except that
            %   it returns the pure SO(3) rotation matrix, or the result
            %   matrix if the target parameter was supplied.
            %
            % Parameters:
            %   target - An optional matrix to be multiplied by the
            %            calculated rotation matrix. Defaults to eye(3).
            %
            % Returns: The rotation matrix, or the result matrix if a
            %          matrix was supplied to the method.
            
            if nargin == 1
                target = eye(3);
            end
            
            ret = obj.mat(1:3, 1:3) * target;
        end
        
        function ret = m3(obj, target)
            % m3 Shorthand for .matrix3()
            % See M3
            
            if nargin == 1
                target = eye(3);
            end
            
            ret = obj.matrix3(target);
        end
        
        function [k, theta] = axis(obj)
            % axis Calculates the axis angle represented by this rotation
            %
            %   This method effectively "finishes" the rotation, returning
            %   the unit vector and theta radian rotation. This method will
            %   only consider the SO(3) matrix that exists inside of the
            %   SE(3) matrix that this TransformationBuilder instance
            %   represents.
            %
            % Returns:
            %   k     - A unit vector about which to rotate
            %   theta - An amount in radians to rotate about k
            %
            % See AXISD
            
            [kT, thetaT] = Rotation.mat2axis(obj.mat(1:3, 1:3));
            k = kT;
            theta = thetaT;
        end
        
        function [k, theta] = axisd(obj)
            % axisd Calculates the axis angle represented by this rotation
            %
            %   This method effectively "finishes" the rotation, returning
            %   the unit vector and theta radian rotation. This method will
            %   only consider the SO(3) matrix that exists inside of the
            %   SE(3) matrix that this TransformationBuilder instance
            %   represents. This method is identical to ".axis()", except
            %   it returns theta in degrees.
            %
            % Returns:
            %   k     - A unit vector about which to rotate
            %   theta - An amount in degrees to rotate about k
            %
            % See AXIS
            
            [kT, thetaT] = Rotation.mat2axis(obj.mat(1:3, 1:3));
            k = kT;
            theta = thetaT * 180 / pi;
        end
        
        function ret = dh(obj, theta, d, a, alpha)
            % dh Calculates Denavit-Hartenberg transformations
            %
            % Parameters:
            %     theta - The amount, in radians, to rotate about the local
            %             z axis.
            %     d     - The distance to translate along the local z axis.
            %     a     - The distance to translate along the local x axis.
            %     alpha - The amount, in radians, to rotate about the local
            %             x axis.
            %
            % Returns: A TransformationBuilder instance
            ret = obj.r().z(theta).t().z(d).x(a).r().x(alpha);
        end
    end
    
    methods(Access=private)
        function ret = apply_transform(obj, transform)
            if obj.is_local
                obj.mat = obj.mat * transform;
            else
                obj.mat = transform * obj.mat;
            end
            
            ret = obj;
        end
    end
end

