function d = hidiff(f, xi, h, o, dir, acc)
% Difference formula helper function
%   input:
%       f = function/x,y row vector of values
%       xi = value to est derivative
%       h = step size
%       o = order of differentiation (defaults to 1)
%       dir = char for forward, back, center ('f', 'b', 'c')
%       acc = char for accuracy normal, high ('n', 'h')
% check inputs, default to normal accuracy centered difference formula
if nargin<4
    error('at least 4 input arguments required')
end
if nargin<6||isempty(acc)
    acc = 'n';
end
if nargin<5||isempty(dir)
    dir = 'c';
end
if nargin<4||isempty(o)
    o = 1;
end
% check type of f
% if function_handle, generate f(xi-3):f(xi+3) to handle both directions
% hi accuracy
if isa(f, 'function_handle')
    for i = 1:7
        fvals(i) = f(h*(i-1));
    end

else
    fvals = f;
end

% Finite-Diff formulas
% get index of xi
j = find(fvals==xi);
% forward
if dir == 'f'
    % first order
    if o == 1
        % normal f'(xi) = f(xi+1) - f(xi)/h
        d = (fvals(j+1)-fvals(j))/h;
        % hi-acc f'(xi) = -f(xi+2) + 4f(xi+1) - 3f(xi)/2h
        if acc == 'h'
            d = (-fvals(j+2) + 4*fvals(j+1) - 3*fvals(j))/(2*h);
        end % hi
    end % end first order
    if o == 2
        % normal f''(xi) = f(xi+2) - 2f(xi+1) + f(xi)/h^2
        d = (fvals(j+2) - 2*fvals(j+1)+fvals(j))/h^2;
        % hi-acc f''(xi) = -f(xi+3) + 4f(xi+2) - 5f(xi+1)+2f(xi)/h^2
        if acc == 'h'
            d = (-fvals(j+3)+4*fvals(j+2)-5*fvals(j+1)+2*fvals(j))/(h^2);
        end % hi
    end % end second order
end % end forward
% backward
if dir == 'b' && j > 1
    % first order
    if o == 1
        % normal f'(xi) = f(xi) - f(xi-1)/h
        d = (fvals(j)-fvals(j-1))/h;

        if acc == 'h' && j > 2
            % hi-acc f'(xi) = 3f(xi) - 4f(xi-1) + f(xi-2)/2h
            d = (3*fvals(j) - 4*fvals(j-1) + fvals(j-2))/(2*h);
        end % hi
    end % end first order
    if o == 2 && j > 2
        % normal f''(xi) = f(xi) - 2f(xi-1) + f(xi-2)/h^2
        d = (fvals(j) - 2*fvals(j-1)+fvals(j-2))/h^2;

        if acc == 'h' && j>3
            % hi-acc f''(xi) = 2f(xi) - 5f(xi-1) + 4f(xi-2)-f(xi-3)/h^2
            d = (2*fvals(j)-5*fvals(j-1)+4*fvals(j-2)-fvals(j-3))/(h^2);
        end % hi
    end % end second order
end % end backward
% centered
if dir == 'c' && j > 1
    % first order
    if o == 1
        % normal f'(xi) = f(xi+1) - f(xi-1)/2h
        d = (fvals(j+1)-fvals(j-1))/(2*h);

        if acc == 'h' && j > 1
            % hi-acc f'(xi) = -f(xi+2) + 8f(xi+1)-8f(xi-1) + f(xi-2)/12h
            d = (-fvals(j+2) + 8*fvals(j+1) - 8*fvals(j-1) + fvals(j-2))/(12*h);
        end % hi
    end % end first order
    if o == 2 && j > 1
        % normal f''(xi) = f(xi+1) - 2f(xi) + f(xi-1)/h^2
        d = (fvals(j+1) - 2*fvals(j)+fvals(j-1))/h^2;

        if acc == 'h' && j>2
            % hi-acc f''(xi) = -f(xi+2)+16f(xi+1)-30f(xi)+16f(xi-1)-f(xi-2)/h^2
            d = (-fvals(j+2)+16*fvals(j+1)-30*fvals(j)+16*fvals(j-1)-fvals(j-2))/(12*h^2);
        end % hi
    end % end second order
end % end centered
end